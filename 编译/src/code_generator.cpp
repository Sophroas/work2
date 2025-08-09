#include "code_generator.h"
#include <algorithm>
#include <cassert>

CodeGenerator::CodeGenerator(SymbolTable* sym_table) 
    : symbol_table(sym_table), next_label_id(0), current_function_stack_size(0),
      current_function_return_type(DataType::VOID), local_var_count(0) {
    
    // 初始化临时寄存器池
    temp_registers = {RISCV::T0, RISCV::T1, RISCV::T2, RISCV::T3, RISCV::T4, RISCV::T5, RISCV::T6};
    register_used.resize(temp_registers.size(), false);
}

std::string CodeGenerator::generate(CompUnit& root) {
    output.str("");  // 清空输出缓冲区
    
    // 生成汇编代码头部
    emit(".text");
    emit(".globl main");
    emit("");
    
    // 遍历AST生成代码
    root.accept(*this);
    
    return output.str();
}

void CodeGenerator::visit(CompUnit& node) {
    // 生成所有函数的代码
    for (const auto& func : node.functions) {
        func->accept(*this);
        emit("");  // 函数之间添加空行
    }
}

void CodeGenerator::visit(FuncDef& node) {
    current_function_name = node.name;
    current_function_return_type = (node.return_type == FuncDef::ReturnType::INT) ? 
                                  DataType::INT : DataType::VOID;
    
    // 重置局部变量计数器和偏移映射
    local_var_count = 0;
    variable_offsets.clear();
    scope_stack.clear();
    
    // 函数标签
    emit_label(node.name);
    
    // 简化：预先分配固定的栈空间（足够容纳合理数量的局部变量）
    current_function_stack_size = 64; // 预分配64字节，可容纳16个int变量
    
    // 函数序言
    setup_function_prologue(node.name, current_function_stack_size);
    
    // 为参数分配栈空间
    for (size_t i = 0; i < node.params.size(); i++) {
        if (i < 8) {
            // 前8个参数：从寄存器a0-a7复制到栈上
            std::string arg_reg = "a" + std::to_string(i);
            local_var_count++;
            int offset = -local_var_count * 4;
            variable_offsets[node.params[i]] = offset;
            emit("sw " + arg_reg + ", " + std::to_string(offset) + "(s0)");
        } else {
            // 超过8个的参数：从调用者栈帧中加载
            local_var_count++;
            int offset = -local_var_count * 4;
            variable_offsets[node.params[i]] = offset;
            
            // 计算参数在调用者栈中的位置
            // 栈参数位置：s0 + 8 + (i-8)*4
            int caller_offset = 8 + (i - 8) * 4;
            emit("lw t0, " + std::to_string(caller_offset) + "(s0)");
            emit("sw t0, " + std::to_string(offset) + "(s0)");
        }
    }
    
    // 生成函数体代码 - 直接处理语句，避免额外的作用域管理
    for (const auto& stmt : node.body->statements) {
        stmt->accept(*this);
    }
    
    // 如果函数没有显式return，添加默认return
    if (current_function_return_type == DataType::VOID) {
        emit("li a0, 0");  // void函数返回0
        setup_function_epilogue();
    } else if (current_function_return_type == DataType::INT) {
        emit("li a0, 0");  // 默认返回0
        setup_function_epilogue();
    }
}

void CodeGenerator::visit(Block& node) {
    // 进入新的作用域
    symbol_table->enter_scope();
    
    // 保存当前的变量偏移映射
    scope_stack.push_back(variable_offsets);
    
    // 生成所有语句的代码
    for (const auto& stmt : node.statements) {
        stmt->accept(*this);
    }
    
    // 退出作用域 - 恢复之前的变量映射
    if (!scope_stack.empty()) {
        variable_offsets = scope_stack.back();
        scope_stack.pop_back();
    }
    
    symbol_table->exit_scope();
}

void CodeGenerator::visit(ExprStmt& node) {
    if (node.expression) {
        // 计算表达式，但不需要保存结果
        std::string result_reg = generate_expr(*node.expression);
        free_temp_register(result_reg);
    }
}

void CodeGenerator::visit(VarDecl& node) {
    // 为变量分配栈空间
    local_var_count++;
    int offset = -local_var_count * 4; // 每个变量4字节，向下增长
    variable_offsets[node.name] = offset;
    
    // 计算初始化表达式
    std::string init_reg = generate_expr(*node.init_expr);
    
    // 将值存储到变量位置
    emit("sw " + init_reg + ", " + std::to_string(offset) + "(s0)");
    
    free_temp_register(init_reg);
}

void CodeGenerator::visit(AssignStmt& node) {
    // 计算右值表达式
    std::string value_reg = generate_expr(*node.value);
    
    // 查找变量的栈偏移
    auto it = variable_offsets.find(node.name);
    if (it != variable_offsets.end()) {
        emit("sw " + value_reg + ", " + std::to_string(it->second) + "(s0)");
    }
    
    free_temp_register(value_reg);
}

void CodeGenerator::visit(IfStmt& node) {
    std::string false_label = generate_label("if_false");
    std::string end_label = generate_label("if_end");
    
    // 生成条件判断
    generate_condition(*node.condition, "", false_label);
    
    // then分支
    node.then_stmt->accept(*this);
    
    if (node.else_stmt) {
        emit("j " + end_label);
        emit_label(false_label);
        node.else_stmt->accept(*this);
        emit_label(end_label);
    } else {
        emit_label(false_label);
    }
}

void CodeGenerator::visit(WhileStmt& node) {
    std::string loop_start = generate_label("while_start");
    std::string loop_end = generate_label("while_end");
    
    // 为break和continue准备标签
    break_labels.push(loop_end);
    continue_labels.push(loop_start);
    
    // 循环开始
    emit_label(loop_start);
    
    // 生成条件判断
    generate_condition(*node.condition, "", loop_end);
    
    // 生成循环体
    node.body->accept(*this);
    
    // 跳回循环开始
    emit("j " + loop_start);
    emit_label(loop_end);
    
    // 清理标签栈
    break_labels.pop();
    continue_labels.pop();
}

void CodeGenerator::visit(BreakStmt& /* node */) {
    if (!break_labels.empty()) {
        emit("j " + break_labels.top());
    }
}

void CodeGenerator::visit(ContinueStmt& /* node */) {
    if (!continue_labels.empty()) {
        emit("j " + continue_labels.top());
    }
}

void CodeGenerator::visit(ReturnStmt& node) {
    if (node.value) {
        // 计算返回值并放入a0寄存器
        std::string result_reg = generate_expr(*node.value);
        if (result_reg != RISCV::A0) {
            emit("mv a0, " + result_reg);
        }
        free_temp_register(result_reg);
    } else {
        // void函数返回0
        emit("li a0, 0");
    }
    
    // 直接调用函数尾声并返回
    setup_function_epilogue();
}

void CodeGenerator::visit(BinaryExpr& /* node */) {
    // 这个方法不应该被直接调用，应该通过generate_expr调用
    assert(false && "BinaryExpr::visit should not be called directly");
}

void CodeGenerator::visit(UnaryExpr& /* node */) {
    // 这个方法不应该被直接调用，应该通过generate_expr调用
    assert(false && "UnaryExpr::visit should not be called directly");
}

void CodeGenerator::visit(NumberExpr& /* node */) {
    // 这个方法不应该被直接调用，应该通过generate_expr调用
    assert(false && "NumberExpr::visit should not be called directly");
}

void CodeGenerator::visit(VarExpr& /* node */) {
    // 这个方法不应该被直接调用，应该通过generate_expr调用
    assert(false && "VarExpr::visit should not be called directly");
}

void CodeGenerator::visit(CallExpr& /* node */) {
    // 这个方法不应该被直接调用，应该通过generate_expr调用
    assert(false && "CallExpr::visit should not be called directly");
}

// 辅助方法实现
void CodeGenerator::emit(const std::string& instruction) {
    output << "    " << instruction << "\n";
}

void CodeGenerator::emit_label(const std::string& label) {
    output << label << ":\n";
}

std::string CodeGenerator::generate_label(const std::string& prefix) {
    return prefix + "_" + std::to_string(next_label_id++);
}

void CodeGenerator::push_register(const std::string& reg) {
    emit("addi sp, sp, -4");
    emit("sw " + reg + ", 0(sp)");
}

void CodeGenerator::pop_register(const std::string& reg) {
    emit("lw " + reg + ", 0(sp)");
    emit("addi sp, sp, 4");
}

void CodeGenerator::allocate_stack(int size) {
    if (size > 0) {
        emit("addi sp, sp, -" + std::to_string(size));
    }
}

void CodeGenerator::deallocate_stack(int size) {
    if (size > 0) {
        emit("addi sp, sp, " + std::to_string(size));
    }
}

std::string CodeGenerator::allocate_temp_register() {
    for (size_t i = 0; i < register_used.size(); i++) {
        if (!register_used[i]) {
            register_used[i] = true;
            return temp_registers[i];
        }
    }
    
    // 如果没有可用的临时寄存器，使用栈溢出（简化实现）
    std::string reg = temp_registers[0];
    push_register(reg);
    return reg;
}

void CodeGenerator::free_temp_register(const std::string& reg) {
    auto it = std::find(temp_registers.begin(), temp_registers.end(), reg);
    if (it != temp_registers.end()) {
        size_t index = it - temp_registers.begin();
        register_used[index] = false;
    }
}

std::string CodeGenerator::generate_expr(Expr& expr) {
    // 根据表达式类型生成代码
    if (auto* num_expr = dynamic_cast<NumberExpr*>(&expr)) {
        std::string reg = allocate_temp_register();
        emit("li " + reg + ", " + std::to_string(num_expr->value));
        return reg;
    }
    
    if (auto* var_expr = dynamic_cast<VarExpr*>(&expr)) {
        return load_variable(var_expr->name);
    }
    
    if (auto* bin_expr = dynamic_cast<BinaryExpr*>(&expr)) {
        // 处理短路求值
        if (bin_expr->op == BinaryExpr::Operator::AND) {
            return generate_short_circuit_and(*bin_expr);
        } else if (bin_expr->op == BinaryExpr::Operator::OR) {
            return generate_short_circuit_or(*bin_expr);
        }
        
        // 普通二元运算 - 需要保护左操作数的结果
        std::string left_reg = generate_expr(*bin_expr->left);
        
        // 如果左操作数是函数调用结果，需要保存到栈上
        bool left_needs_save = (left_reg == RISCV::A0);
        if (left_needs_save) {
            push_register(left_reg);
        }
        
        std::string right_reg = generate_expr(*bin_expr->right);
        
        // 如果保存了左操作数，现在恢复它
        if (left_needs_save) {
            std::string saved_left = allocate_temp_register();
            pop_register(saved_left);
            free_temp_register(left_reg);
            left_reg = saved_left;
        }
        
        std::string result_reg = allocate_temp_register();
        
        switch (bin_expr->op) {
            case BinaryExpr::Operator::ADD:
                emit("add " + result_reg + ", " + left_reg + ", " + right_reg);
                break;
            case BinaryExpr::Operator::SUB:
                emit("sub " + result_reg + ", " + left_reg + ", " + right_reg);
                break;
            case BinaryExpr::Operator::MUL:
                emit("mul " + result_reg + ", " + left_reg + ", " + right_reg);
                break;
            case BinaryExpr::Operator::DIV:
                emit("div " + result_reg + ", " + left_reg + ", " + right_reg);
                break;
            case BinaryExpr::Operator::MOD:
                emit("rem " + result_reg + ", " + left_reg + ", " + right_reg);
                break;
            case BinaryExpr::Operator::LT:
                emit("slt " + result_reg + ", " + left_reg + ", " + right_reg);
                break;
            case BinaryExpr::Operator::GT:
                emit("slt " + result_reg + ", " + right_reg + ", " + left_reg);
                break;
            case BinaryExpr::Operator::LE:
                emit("slt " + result_reg + ", " + right_reg + ", " + left_reg);
                emit("xori " + result_reg + ", " + result_reg + ", 1");
                break;
            case BinaryExpr::Operator::GE:
                emit("slt " + result_reg + ", " + left_reg + ", " + right_reg);
                emit("xori " + result_reg + ", " + result_reg + ", 1");
                break;
            case BinaryExpr::Operator::EQ:
                emit("sub " + result_reg + ", " + left_reg + ", " + right_reg);
                emit("seqz " + result_reg + ", " + result_reg);
                break;
            case BinaryExpr::Operator::NE:
                emit("sub " + result_reg + ", " + left_reg + ", " + right_reg);
                emit("snez " + result_reg + ", " + result_reg);
                break;
            default:
                break;
        }
        
        free_temp_register(left_reg);
        free_temp_register(right_reg);
        return result_reg;
    }
    
    if (auto* unary_expr = dynamic_cast<UnaryExpr*>(&expr)) {
        std::string operand_reg = generate_expr(*unary_expr->operand);
        std::string result_reg = allocate_temp_register();
        
        switch (unary_expr->op) {
            case UnaryExpr::Operator::PLUS:
                emit("mv " + result_reg + ", " + operand_reg);
                break;
            case UnaryExpr::Operator::MINUS:
                emit("neg " + result_reg + ", " + operand_reg);
                break;
            case UnaryExpr::Operator::NOT:
                emit("seqz " + result_reg + ", " + operand_reg);
                break;
        }
        
        free_temp_register(operand_reg);
        return result_reg;
    }
    
    if (auto* call_expr = dynamic_cast<CallExpr*>(&expr)) {
        generate_function_call(*call_expr);
        return RISCV::A0;  // 函数返回值在a0中
    }
    
    // 默认情况
    std::string reg = allocate_temp_register();
    emit("li " + reg + ", 0");
    return reg;
}

std::string CodeGenerator::load_variable(const std::string& name) {
    // 查找变量的栈偏移
    auto it = variable_offsets.find(name);
    if (it == variable_offsets.end()) {
        // 错误处理：变量未找到
        std::string reg = allocate_temp_register();
        emit("li " + reg + ", 0");
        return reg;
    }
    
    std::string reg = allocate_temp_register();
    emit("lw " + reg + ", " + std::to_string(it->second) + "(s0)");
    return reg;
}

void CodeGenerator::store_variable(const std::string& name, const std::string& value_reg) {
    Symbol* symbol = symbol_table->lookup_symbol(name);
    if (!symbol) {
        return;  // 错误处理：变量未找到
    }
    
    // 修复：确保使用正确的栈基址
    emit("sw " + value_reg + ", " + std::to_string(symbol->stack_offset) + "(s0)");
}

void CodeGenerator::generate_condition(Expr& condition, const std::string& true_label, 
                                      const std::string& false_label) {
    std::string cond_reg = generate_expr(condition);
    
    if (!false_label.empty()) {
        emit("beqz " + cond_reg + ", " + false_label);
    }
    if (!true_label.empty()) {
        emit("bnez " + cond_reg + ", " + true_label);
    }
    
    free_temp_register(cond_reg);
}

std::string CodeGenerator::generate_short_circuit_and(BinaryExpr& expr) {
    std::string false_label = generate_label("and_false");
    std::string end_label = generate_label("and_end");
    std::string result_reg = allocate_temp_register();
    
    // 计算左操作数
    std::string left_reg = generate_expr(*expr.left);
    emit("beqz " + left_reg + ", " + false_label);
    
    // 左操作数为真，计算右操作数
    std::string right_reg = generate_expr(*expr.right);
    emit("mv " + result_reg + ", " + right_reg);
    emit("j " + end_label);
    
    // 左操作数为假
    emit_label(false_label);
    emit("li " + result_reg + ", 0");
    
    emit_label(end_label);
    
    free_temp_register(left_reg);
    free_temp_register(right_reg);
    return result_reg;
}

std::string CodeGenerator::generate_short_circuit_or(BinaryExpr& expr) {
    std::string true_label = generate_label("or_true");
    std::string end_label = generate_label("or_end");
    std::string result_reg = allocate_temp_register();
    
    // 计算左操作数
    std::string left_reg = generate_expr(*expr.left);
    emit("bnez " + left_reg + ", " + true_label);
    
    // 左操作数为假，计算右操作数
    std::string right_reg = generate_expr(*expr.right);
    emit("mv " + result_reg + ", " + right_reg);
    emit("j " + end_label);
    
    // 左操作数为真
    emit_label(true_label);
    emit("li " + result_reg + ", 1");
    
    emit_label(end_label);
    
    free_temp_register(left_reg);
    free_temp_register(right_reg);
    return result_reg;
}

void CodeGenerator::setup_function_prologue(const std::string& /* func_name */, int local_vars_size) {
    // 保存返回地址和帧指针
    push_register(RISCV::RA);
    push_register(RISCV::S0);
    
    // 设置帧指针
    emit("mv s0, sp");
    
    // 为局部变量分配空间
    if (local_vars_size > 0) {
        allocate_stack(local_vars_size);
    }
}

void CodeGenerator::setup_function_epilogue() {
    // 恢复栈指针
    emit("mv sp, s0");
    
    // 恢复帧指针和返回地址
    pop_register(RISCV::S0);
    pop_register(RISCV::RA);
    
    // 返回
    emit("ret");
}

void CodeGenerator::generate_function_call(CallExpr& call) {
    // 保存调用者保存的寄存器
    save_caller_saved_registers();
    
    // 计算所有参数表达式并保存结果
    std::vector<std::string> arg_regs;
    for (size_t i = 0; i < call.args.size(); i++) {
        std::string arg_reg = generate_expr(*call.args[i]);
        arg_regs.push_back(arg_reg);
    }
    
    // 传递超过8个的参数到栈上（逆序压栈）
    if (call.args.size() > 8) {
        for (int i = (int)call.args.size() - 1; i >= 8; i--) {
            push_register(arg_regs[i]);
        }
    }
    
    // 传递前8个参数到寄存器
    for (size_t i = 0; i < call.args.size() && i < 8; i++) {
        std::string param_reg = "a" + std::to_string(i);
        if (arg_regs[i] != param_reg) {
            emit("mv " + param_reg + ", " + arg_regs[i]);
        }
    }
    
    // 释放临时寄存器
    for (const auto& reg : arg_regs) {
        free_temp_register(reg);
    }
    
    // 调用函数
    emit("call " + call.name);
    
    // 清理栈上的参数
    if (call.args.size() > 8) {
        int stack_params = (int)call.args.size() - 8;
        emit("addi sp, sp, " + std::to_string(stack_params * 4));
    }
    
    // 恢复调用者保存的寄存器
    restore_caller_saved_registers();
}

void CodeGenerator::save_caller_saved_registers() {
    // 简化实现：只保存需要的寄存器
    for (size_t i = 0; i < register_used.size(); i++) {
        if (register_used[i]) {
            push_register(temp_registers[i]);
        }
    }
}

void CodeGenerator::restore_caller_saved_registers() {
    // 按相反顺序恢复寄存器
    for (int i = (int)register_used.size() - 1; i >= 0; i--) {
        if (register_used[i]) {
            pop_register(temp_registers[i]);
        }
    }
}

bool CodeGenerator::is_optimization_enabled() const {
    #ifdef ENABLE_OPTIMIZATION
    return true;
    #else
    return false;
    #endif
}

std::string CodeGenerator::escape_string(const std::string& str) {
    // 简单的字符串转义实现
    return str;
}

bool CodeGenerator::is_temp_register(const std::string& reg) {
    // 检查是否是临时寄存器 (t0-t6)
    return reg == RISCV::T0 || reg == RISCV::T1 || reg == RISCV::T2 || 
           reg == RISCV::T3 || reg == RISCV::T4 || reg == RISCV::T5 || reg == RISCV::T6;
}

bool CodeGenerator::is_callee_saved_register(const std::string& reg) {
    return reg.find("s") == 0;  // s0-s11是被调用者保存的寄存器
}

void CodeGenerator::calculate_stack_size(Stmt& stmt) {
    // 预先计算栈空间需求，遍历AST来统计局部变量数量
    if (auto* var_decl = dynamic_cast<VarDecl*>(&stmt)) {
        // 变量声明，在符号表中预定义
        symbol_table->define_variable(var_decl->name, DataType::INT);
    } else if (auto* block = dynamic_cast<Block*>(&stmt)) {
        // 递归处理语句块中的所有语句
        symbol_table->enter_scope();
        for (const auto& s : block->statements) {
            calculate_stack_size(*s);
        }
        symbol_table->exit_scope();
    } else if (auto* if_stmt = dynamic_cast<IfStmt*>(&stmt)) {
        // 处理if语句的两个分支
        calculate_stack_size(*if_stmt->then_stmt);
        if (if_stmt->else_stmt) {
            calculate_stack_size(*if_stmt->else_stmt);
        }
    } else if (auto* while_stmt = dynamic_cast<WhileStmt*>(&stmt)) {
        // 处理while循环体
        calculate_stack_size(*while_stmt->body);
    }
    // 其他语句类型不包含变量声明，不需要处理
}
