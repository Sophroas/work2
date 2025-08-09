#include <iostream>
#include <string>
#include <memory>

// 简化的测试，验证编译器架构是否正确

// 包含必要的头文件
#include "src/ast.h"
#include "src/symbol_table.h"
#include "src/semantic_analyzer.h"
#include "src/code_generator.h"
#include "src/optimizer.h"

// 创建一个简单的AST用于测试
std::unique_ptr<CompUnit> create_test_ast() {
    auto comp_unit = std::make_unique<CompUnit>();
    
    // 创建一个简单的main函数: int main() { return 42; }
    std::vector<std::string> params;
    auto return_stmt = std::make_unique<ReturnStmt>(std::make_unique<NumberExpr>(42));
    
    auto block = std::make_unique<Block>();
    block->statements.push_back(std::move(return_stmt));
    
    auto main_func = std::make_unique<FuncDef>(
        FuncDef::ReturnType::INT,
        "main",
        std::move(params),
        std::move(block)
    );
    
    comp_unit->functions.push_back(std::move(main_func));
    
    return comp_unit;
}

int main() {
    std::cout << "=== ToyC 编译器架构测试 ===" << std::endl;
    
    try {
        // 1. 创建测试AST
        std::cout << "1. 创建测试AST..." << std::endl;
        auto ast = create_test_ast();
        std::cout << "   ✓ AST创建成功" << std::endl;
        
        // 2. 测试语义分析
        std::cout << "2. 测试语义分析..." << std::endl;
        SemanticAnalyzer analyzer;
        bool semantic_ok = analyzer.analyze(*ast);
        if (semantic_ok) {
            std::cout << "   ✓ 语义分析通过" << std::endl;
        } else {
            std::cout << "   ✗ 语义分析失败:" << std::endl;
            analyzer.print_errors();
            return 1;
        }
        
        // 3. 测试优化器
        std::cout << "3. 测试优化器..." << std::endl;
        Optimizer optimizer(true);
        optimizer.optimize(*ast);
        std::cout << "   ✓ 优化器运行完成，应用了 " << optimizer.get_optimizations_count() << " 项优化" << std::endl;
        
        // 4. 测试代码生成
        std::cout << "4. 测试代码生成..." << std::endl;
        CodeGenerator code_gen(&analyzer.get_symbol_table());
        std::string assembly = code_gen.generate(*ast);
        std::cout << "   ✓ 代码生成完成" << std::endl;
        std::cout << std::endl;
        
        // 5. 输出生成的汇编代码
        std::cout << "=== 生成的RISC-V汇编代码 ===" << std::endl;
        std::cout << assembly << std::endl;
        
        std::cout << "=== 所有测试通过！ ===" << std::endl;
        return 0;
        
    } catch (const std::exception& e) {
        std::cout << "   ✗ 错误: " << e.what() << std::endl;
        return 1;
    }
}
