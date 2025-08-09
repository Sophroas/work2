#include "ast.h"
#include <iostream>
#include <iomanip>

// 工具函数：打印缩进
static void print_indent(int indent) {
    for (int i = 0; i < indent; i++) {
        std::cout << "  ";
    }
}

// CompUnit 实现
void CompUnit::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void CompUnit::print(int indent) const {
    print_indent(indent);
    std::cout << "CompUnit:\n";
    for (const auto& func : functions) {
        func->print(indent + 1);
    }
}

// FuncDef 实现
FuncDef::FuncDef(ReturnType ret_type, std::string func_name, 
                 std::vector<std::string> parameters, 
                 std::unique_ptr<Block> function_body)
    : return_type(ret_type), name(std::move(func_name)), 
      params(std::move(parameters)), body(std::move(function_body)) {}

void FuncDef::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void FuncDef::print(int indent) const {
    print_indent(indent);
    std::cout << "FuncDef: " << (return_type == INT ? "int" : "void") 
              << " " << name << "(";
    for (size_t i = 0; i < params.size(); i++) {
        if (i > 0) std::cout << ", ";
        std::cout << "int " << params[i];
    }
    std::cout << ")\n";
    body->print(indent + 1);
}

// Block 实现
void Block::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void Block::print(int indent) const {
    print_indent(indent);
    std::cout << "Block:\n";
    for (const auto& stmt : statements) {
        stmt->print(indent + 1);
    }
}

// ExprStmt 实现
ExprStmt::ExprStmt(std::unique_ptr<Expr> expr) 
    : expression(std::move(expr)) {}

void ExprStmt::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void ExprStmt::print(int indent) const {
    print_indent(indent);
    if (expression) {
        std::cout << "ExprStmt:\n";
        expression->print(indent + 1);
    } else {
        std::cout << "EmptyStmt\n";
    }
}

// VarDecl 实现
VarDecl::VarDecl(std::string var_name, std::unique_ptr<Expr> init)
    : name(std::move(var_name)), init_expr(std::move(init)) {}

void VarDecl::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void VarDecl::print(int indent) const {
    print_indent(indent);
    std::cout << "VarDecl: int " << name << " =\n";
    init_expr->print(indent + 1);
}

// AssignStmt 实现
AssignStmt::AssignStmt(std::string var_name, std::unique_ptr<Expr> val)
    : name(std::move(var_name)), value(std::move(val)) {}

void AssignStmt::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void AssignStmt::print(int indent) const {
    print_indent(indent);
    std::cout << "AssignStmt: " << name << " =\n";
    value->print(indent + 1);
}

// IfStmt 实现
IfStmt::IfStmt(std::unique_ptr<Expr> cond, std::unique_ptr<Stmt> then_part, 
               std::unique_ptr<Stmt> else_part)
    : condition(std::move(cond)), then_stmt(std::move(then_part)), 
      else_stmt(std::move(else_part)) {}

void IfStmt::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void IfStmt::print(int indent) const {
    print_indent(indent);
    std::cout << "IfStmt:\n";
    print_indent(indent + 1);
    std::cout << "condition:\n";
    condition->print(indent + 2);
    print_indent(indent + 1);
    std::cout << "then:\n";
    then_stmt->print(indent + 2);
    if (else_stmt) {
        print_indent(indent + 1);
        std::cout << "else:\n";
        else_stmt->print(indent + 2);
    }
}

// WhileStmt 实现
WhileStmt::WhileStmt(std::unique_ptr<Expr> cond, std::unique_ptr<Stmt> loop_body)
    : condition(std::move(cond)), body(std::move(loop_body)) {}

void WhileStmt::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void WhileStmt::print(int indent) const {
    print_indent(indent);
    std::cout << "WhileStmt:\n";
    print_indent(indent + 1);
    std::cout << "condition:\n";
    condition->print(indent + 2);
    print_indent(indent + 1);
    std::cout << "body:\n";
    body->print(indent + 2);
}

// BreakStmt 实现
void BreakStmt::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void BreakStmt::print(int indent) const {
    print_indent(indent);
    std::cout << "BreakStmt\n";
}

// ContinueStmt 实现
void ContinueStmt::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void ContinueStmt::print(int indent) const {
    print_indent(indent);
    std::cout << "ContinueStmt\n";
}

// ReturnStmt 实现
ReturnStmt::ReturnStmt(std::unique_ptr<Expr> ret_value)
    : value(std::move(ret_value)) {}

void ReturnStmt::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void ReturnStmt::print(int indent) const {
    print_indent(indent);
    if (value) {
        std::cout << "ReturnStmt:\n";
        value->print(indent + 1);
    } else {
        std::cout << "ReturnStmt (void)\n";
    }
}

// BinaryExpr 实现
BinaryExpr::BinaryExpr(Operator operation, std::unique_ptr<Expr> lhs, std::unique_ptr<Expr> rhs)
    : op(operation), left(std::move(lhs)), right(std::move(rhs)) {}

void BinaryExpr::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void BinaryExpr::print(int indent) const {
    print_indent(indent);
    std::cout << "BinaryExpr: " << operatorToString(op) << "\n";
    print_indent(indent + 1);
    std::cout << "left:\n";
    left->print(indent + 2);
    print_indent(indent + 1);
    std::cout << "right:\n";
    right->print(indent + 2);
}

std::string BinaryExpr::operatorToString(Operator op) {
    switch (op) {
        case ADD: return "+";
        case SUB: return "-";
        case MUL: return "*";
        case DIV: return "/";
        case MOD: return "%";
        case LT: return "<";
        case GT: return ">";
        case LE: return "<=";
        case GE: return ">=";
        case EQ: return "==";
        case NE: return "!=";
        case AND: return "&&";
        case OR: return "||";
        default: return "UNKNOWN";
    }
}

// UnaryExpr 实现
UnaryExpr::UnaryExpr(Operator operation, std::unique_ptr<Expr> expr)
    : op(operation), operand(std::move(expr)) {}

void UnaryExpr::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void UnaryExpr::print(int indent) const {
    print_indent(indent);
    std::cout << "UnaryExpr: " << operatorToString(op) << "\n";
    operand->print(indent + 1);
}

std::string UnaryExpr::operatorToString(Operator op) {
    switch (op) {
        case PLUS: return "+";
        case MINUS: return "-";
        case NOT: return "!";
        default: return "UNKNOWN";
    }
}

// NumberExpr 实现
NumberExpr::NumberExpr(int val) : value(val) {}

void NumberExpr::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void NumberExpr::print(int indent) const {
    print_indent(indent);
    std::cout << "NumberExpr: " << value << "\n";
}

// VarExpr 实现
VarExpr::VarExpr(std::string var_name) : name(std::move(var_name)) {}

void VarExpr::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void VarExpr::print(int indent) const {
    print_indent(indent);
    std::cout << "VarExpr: " << name << "\n";
}

// CallExpr 实现
CallExpr::CallExpr(std::string func_name, std::vector<std::unique_ptr<Expr>> arguments)
    : name(std::move(func_name)), args(std::move(arguments)) {}

void CallExpr::accept(ASTVisitor& visitor) {
    visitor.visit(*this);
}

void CallExpr::print(int indent) const {
    print_indent(indent);
    std::cout << "CallExpr: " << name << "\n";
    for (const auto& arg : args) {
        arg->print(indent + 1);
    }
}
