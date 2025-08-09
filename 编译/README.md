# ToyC编译器

一个将ToyC语言编译为RISC-V32汇编代码的编译器实现。

## 项目概述

本项目是武汉大学计算机学院编译系统实践课程的作业，实现了一个完整的ToyC语言编译器。ToyC是C语言的一个简化子集，支持基本的程序结构、控制流和函数调用。

### 主要特性

- **词法分析**: 手动实现，识别关键字、标识符、数字、运算符等
- **语法分析**: 递归下降分析器，构建抽象语法树(AST)
- **语义分析**: 符号表管理、类型检查、作用域检查
- **代码生成**: 生成RISC-V32汇编代码
- **优化**: 常量折叠、死代码消除等基本优化
- **错误处理**: 详细的错误报告和定位

## 技术栈

- **编程语言**: C++20
- **构建系统**: CMake (主要) / Makefile (备用)
- **词法/语法分析**: 手动实现
- **目标架构**: RISC-V32

## ToyC语言特性

ToyC是C语言的简化版本，支持以下特性：

### 数据类型
- `int`: 32位有符号整数
- `void`: 空类型（仅用于函数返回类型）

### 语句类型
- 变量声明: `int x = 10;`
- 赋值语句: `x = y + 5;`
- 表达式语句: `func();`
- 控制流: `if-else`, `while`, `break`, `continue`, `return`
- 语句块: `{ ... }`

### 表达式
- 算术运算: `+`, `-`, `*`, `/`, `%`
- 关系运算: `<`, `>`, `<=`, `>=`, `==`, `!=`
- 逻辑运算: `&&`, `||`, `!`
- 函数调用: `func(arg1, arg2)`
- 括号表达式: `(expr)`

### 函数
- 函数定义: `int func(int a, int b) { ... }`
- 递归调用支持
- 必须有`main`函数作为程序入口

## 快速开始

### 环境要求

- **操作系统**: Linux/Unix (推荐) 或 Windows (WSL)
- **编译器**: g++ (支持C++20)
- **工具**: cmake, make

在Ubuntu/Debian上安装依赖：
```bash
sudo apt update
sudo apt install build-essential cmake
```

### 构建编译器

1. **克隆项目**
```bash
git clone <your-repo-url>
cd toyc-compiler
```

2. **构建**
```bash
# 自动检查依赖并构建
chmod +x build.sh
./build.sh build

# 或者手动使用CMake
mkdir build && cd build
cmake ..
make

# 或者使用Makefile
make -f complete_makefile
```

3. **测试**
```bash
./build.sh test
```

### 使用编译器

基本用法：
```bash
# 编译ToyC源文件到RISC-V汇编
./toyc_compiler < input.tc > output.s

# 启用优化
./toyc_compiler -opt < input.tc > output.s
```

示例：
```bash
# 编译提供的测试用例
./toyc_compiler < 01_minimal.tc > minimal.s
./toyc_compiler < 05_function_call.tc > function_call.s
```

## 项目结构

```
toyc-compiler/
├── src/                    # 源代码目录
│   ├── toyc_main.cpp      # 主程序入口
│   ├── manual_lexer.h/.cpp   # 手动词法分析器
│   ├── manual_parser.h/.cpp  # 手动语法分析器
│   ├── ast.h/.cpp         # 抽象语法树定义和实现
│   ├── symbol_table.h/.cpp # 符号表管理
│   ├── semantic_analyzer.h/.cpp # 语义分析器
│   ├── code_generator.h/.cpp    # 代码生成器
│   └── optimizer.h/.cpp   # 优化器
├── CMakeLists.txt         # CMake构建配置
├── complete_makefile      # 完整Makefile
├── build.sh              # 构建脚本
├── README.md             # 项目说明
├── *.tc                  # ToyC测试用例
├── 实践报告.pdf           # 项目报告
└── 资料.md               # 课程资料
```

## 测试用例

项目包含15个测试用例，覆盖ToyC语言的各个特性：

1. `01_minimal.tc` - 最小程序
2. `02_assignment.tc` - 变量赋值
3. `03_if_else.tc` - 条件分支
4. `04_while_break.tc` - 循环和break
5. `05_function_call.tc` - 函数调用
6. `06_continue.tc` - continue语句
7. `07_scope_shadow.tc` - 作用域和变量覆盖
8. `08_short_circuit.tc` - 短路求值
9. `09_recursion.tc` - 递归函数
10. `10_void_fn.tc` - void函数
11. `11_precedence.tc` - 运算符优先级
12. `12_division_check.tc` - 除法检查
13. `13_scope_block.tc` - 作用域块
14. `14_nested_if_while.tc` - 嵌套控制结构
15. `15_multiple_return_paths.tc` - 多返回路径

运行所有测试：
```bash
./build.sh test
```

## 编译器架构

### 1. 词法分析 (Lexer)
- 手动实现词法分析器
- 识别ToyC语言的所有token
- 处理注释和空白字符
- 提供行号和列号信息用于错误报告

### 2. 语法分析 (Parser)
- 递归下降分析器实现
- 根据ToyC文法构建AST
- 处理运算符优先级和结合性
- 支持语法错误恢复

### 3. 语义分析 (Semantic Analyzer)
- 符号表管理和作用域检查
- 类型检查和类型推导
- 函数调用参数匹配
- 控制流有效性检查

### 4. 代码生成 (Code Generator)
- 生成RISC-V32汇编代码
- 栈帧管理和寄存器分配
- 函数调用约定
- 短路求值实现

### 5. 优化 (Optimizer)
- 常量折叠
- 死代码消除
- 表达式简化
- 控制流优化

## 开发和调试

### 调试模式
```bash
# 构建调试版本
make debug

# 启用详细输出
DEBUG_AST=1 DEBUG_SEMANTIC=1 ./toyc_compiler < test.tc > test.s
```

### 添加新特性
1. 修改词法分析器 (`src/manual_lexer.cpp`)
2. 更新语法分析器 (`src/manual_parser.cpp`)
3. 扩展AST节点 (`src/ast.h/.cpp`)
4. 实现语义检查 (`src/semantic_analyzer.cpp`)
5. 添加代码生成 (`src/code_generator.cpp`)

## 评分和性能

编译器按以下标准评分：
- **正确性** (85%): 测试用例通过率
- **性能** (15%): 生成代码的运行效率
- **报告** (20%): 实践报告质量

优化建议：
- 启用 `-opt` 参数
- 实现更多优化算法
- 改进寄存器分配策略

## 故障排除

### 常见问题

1. **编译错误: 找不到源文件**
   - 确保所有源文件都在src/目录下
   - 检查CMakeLists.txt或Makefile配置

2. **链接错误: undefined reference**
   - 确保所有源文件都被编译
   - 检查CMakeLists.txt或Makefile配置

3. **运行时错误: 段错误**
   - 使用gdb调试: `gdb ./toyc_compiler`
   - 检查指针和内存管理

4. **语法错误: parse error**
   - 检查ToyC语法是否正确
   - 查看错误消息中的行号和列号

## 贡献

这是一个课程项目，请按照小组分工进行开发：
1. 词法/语法分析
2. 语义分析
3. 代码生成
4. 优化和测试

## 许可证

本项目仅用于教学目的，请勿用于商业用途。

---

**作者**: 武汉大学计算机学院编译系统实践小组  
**指导教师**: 辛奇  
**课程**: 编译系统实践 (2025年)
