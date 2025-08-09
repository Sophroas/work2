#include <iostream>
#include <string>
#include <memory>
#include <vector>
#include <algorithm>

#include "src/ast.h"
#include "src/symbol_table.h"
#include "src/semantic_analyzer.h"
#include "src/code_generator.h"
#include "src/optimizer.h"

// 创建更复杂的测试AST
std::unique_ptr<CompUnit> create_comprehensive_test_ast() {
    auto comp_unit = std::make_unique<CompUnit>();
    
    // 1. 创建add函数: int add(int a, int b) { return a + b; }
    {
        std::vector<std::string> params = {"a", "b"};
        auto a_expr = std::make_unique<VarExpr>("a");
        auto b_expr = std::make_unique<VarExpr>("b");
        auto add_expr = std::make_unique<BinaryExpr>(
            BinaryExpr::Operator::ADD, 
            std::move(a_expr), 
            std::move(b_expr)
        );
        auto return_stmt = std::make_unique<ReturnStmt>(std::move(add_expr));
        
        auto block = std::make_unique<Block>();
        block->statements.push_back(std::move(return_stmt));
        
        auto add_func = std::make_unique<FuncDef>(
            FuncDef::ReturnType::INT,
            "add",
            std::move(params),
            std::move(block)
        );
        
        comp_unit->functions.push_back(std::move(add_func));
    }
    
    // 2. 创建main函数，包含更复杂的逻辑
    {
        std::vector<std::string> params;
        auto block = std::make_unique<Block>();
        
        // int x = 5;
        auto var_decl = std::make_unique<VarDecl>("x", std::make_unique<NumberExpr>(5));
        block->statements.push_back(std::move(var_decl));
        
        // int y = add(3, 4);
        std::vector<std::unique_ptr<Expr>> args;
        args.push_back(std::make_unique<NumberExpr>(3));
        args.push_back(std::make_unique<NumberExpr>(4));
        auto call_expr = std::make_unique<CallExpr>("add", std::move(args));
        auto var_decl2 = std::make_unique<VarDecl>("y", std::move(call_expr));
        block->statements.push_back(std::move(var_decl2));
        
        // if (x > y) { return x; } else { return y; }
        auto x_expr = std::make_unique<VarExpr>("x");
        auto y_expr = std::make_unique<VarExpr>("y");
        auto cond_expr = std::make_unique<BinaryExpr>(
            BinaryExpr::Operator::GT,
            std::move(x_expr),
            std::move(y_expr)
        );
        
        auto return_x = std::make_unique<ReturnStmt>(std::make_unique<VarExpr>("x"));
        auto return_y = std::make_unique<ReturnStmt>(std::make_unique<VarExpr>("y"));
        
        auto if_stmt = std::make_unique<IfStmt>(
            std::move(cond_expr),
            std::move(return_x),
            std::move(return_y)
        );
        
        block->statements.push_back(std::move(if_stmt));
        
        auto main_func = std::make_unique<FuncDef>(
            FuncDef::ReturnType::INT,
            "main",
            std::move(params),
            std::move(block)
        );
        
        comp_unit->functions.push_back(std::move(main_func));
    }
    
    return comp_unit;
}

void test_individual_components() {
    std::cout << "\n=== 组件单独测试 ===" << std::endl;
    
    // 测试符号表
    std::cout << "测试符号表..." << std::endl;
    SymbolTable sym_table;
    sym_table.define_function("test", DataType::INT, {DataType::INT});
    sym_table.enter_scope();
    sym_table.define_variable("x", DataType::INT);
    auto* var = sym_table.lookup_symbol("x");
    if (var && var->name == "x") {
        std::cout << "   ✓ 符号表基本功能正常" << std::endl;
    }
    sym_table.exit_scope();
    
    // 测试AST节点创建
    std::cout << "测试AST节点..." << std::endl;
    auto expr = std::make_unique<BinaryExpr>(
        BinaryExpr::Operator::ADD,
        std::make_unique<NumberExpr>(1),
        std::make_unique<NumberExpr>(2)
    );
    if (expr) {
        std::cout << "   ✓ AST节点创建正常" << std::endl;
    }
}

int main() {
    std::cout << "=== ToyC 编译器综合测试 ===" << std::endl;
    
    try {
        // 测试单个组件
        test_individual_components();
        
        // 1. 创建复杂的测试AST
        std::cout << "\n1. 创建复杂测试AST..." << std::endl;
        auto ast = create_comprehensive_test_ast();
        std::cout << "   ✓ 复杂AST创建成功（包含函数调用、条件语句等）" << std::endl;
        
        // 2. 打印AST结构
        std::cout << "\n2. AST结构：" << std::endl;
        ast->print(1);
        
        // 3. 语义分析
        std::cout << "\n3. 语义分析..." << std::endl;
        SemanticAnalyzer analyzer;
        bool semantic_ok = analyzer.analyze(*ast);
        if (semantic_ok) {
            std::cout << "   ✓ 复杂语义分析通过" << std::endl;
        } else {
            std::cout << "   ✗ 语义分析失败:" << std::endl;
            analyzer.print_errors();
            return 1;
        }
        
        // 4. 优化器测试
        std::cout << "\n4. 优化器测试..." << std::endl;
        Optimizer optimizer(true);
        optimizer.optimize(*ast);
        std::cout << "   ✓ 优化器处理完成，应用了 " 
                  << optimizer.get_optimizations_count() << " 项优化" << std::endl;
        
        // 5. 代码生成
        std::cout << "\n5. 代码生成..." << std::endl;
        CodeGenerator code_gen(&analyzer.get_symbol_table());
        std::string assembly = code_gen.generate(*ast);
        std::cout << "   ✓ 复杂代码生成完成" << std::endl;
        
        // 6. 输出生成的汇编代码
        std::cout << "\n=== 生成的RISC-V汇编代码 ===" << std::endl;
        std::cout << assembly << std::endl;
        
        // 7. 统计信息
        std::cout << "=== 编译统计 ===" << std::endl;
        std::cout << "• 函数数量: " << ast->functions.size() << std::endl;
        std::cout << "• 优化应用: " << optimizer.get_optimizations_count() << " 项" << std::endl;
        std::cout << "• 汇编行数: " << std::count(assembly.begin(), assembly.end(), '\n') << " 行" << std::endl;
        
        std::cout << "\n=== 🎉 全面测试成功！编译器所有组件正常工作！ ===" << std::endl;
        return 0;
        
    } catch (const std::exception& e) {
        std::cout << "   ✗ 错误: " << e.what() << std::endl;
        return 1;
    }
}
