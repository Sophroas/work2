#!/bin/bash

# ToyC编译器构建脚本

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印彩色信息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查依赖
check_dependencies() {
    print_info "检查构建依赖..."
    
    # 检查编译器
    if ! command -v g++ &> /dev/null; then
        print_error "g++编译器未找到，请安装g++编译器"
        exit 1
    fi
    
    # 检查C++20支持
    if ! g++ -std=c++20 -x c++ -E /dev/null &> /dev/null; then
        print_error "g++编译器不支持C++20标准"
        exit 1
    fi
    
    # 检查CMake
    CMAKE_AVAILABLE=false
    if command -v cmake &> /dev/null; then
        CMAKE_AVAILABLE=true
        print_info "CMake可用，版本: $(cmake --version | head -n1)"
    else
        print_warning "CMake未找到，将使用Makefile构建"
    fi
    
    # 检查Flex和Bison
    if ! command -v flex &> /dev/null; then
        print_error "Flex未找到，请安装flex"
        exit 1
    fi
    
    if ! command -v bison &> /dev/null; then
        print_error "Bison未找到，请安装bison"
        exit 1
    fi
    
    print_success "所有依赖检查通过"
}

# 使用CMake构建
build_with_cmake() {
    print_info "使用CMake构建..."
    
    # 创建构建目录
    mkdir -p build
    cd build
    
    # 配置
    cmake .. -DCMAKE_BUILD_TYPE=Release
    
    # 构建
    make -j$(nproc)
    
    # 复制可执行文件到根目录
    cp toyc_compiler ../
    
    cd ..
    print_success "CMake构建完成"
}

# 使用Makefile构建
build_with_make() {
    print_info "使用Makefile构建..."
    make clean
    make -j$(nproc)
    print_success "Makefile构建完成"
}

# 运行测试
run_tests() {
    print_info "运行测试用例..."
    
    if [ ! -f toyc_compiler ]; then
        print_error "编译器可执行文件不存在"
        exit 1
    fi
    
    test_count=0
    pass_count=0
    
    for tc_file in *.tc; do
        if [ -f "$tc_file" ]; then
            test_count=$((test_count + 1))
            output_file="${tc_file%.tc}.s"
            
            print_info "测试: $tc_file"
            
            # 运行编译器
            if ./toyc_compiler < "$tc_file" > "$output_file" 2>/dev/null; then
                print_success "  编译成功: $output_file"
                pass_count=$((pass_count + 1))
            else
                print_error "  编译失败: $tc_file"
            fi
        fi
    done
    
    if [ $test_count -eq 0 ]; then
        print_warning "没有找到测试用例文件 (*.tc)"
    else
        print_info "测试结果: $pass_count/$test_count 通过"
        if [ $pass_count -eq $test_count ]; then
            print_success "所有测试通过！"
        else
            print_warning "部分测试失败"
        fi
    fi
}

# 清理构建文件
clean() {
    print_info "清理构建文件..."
    rm -rf build/
    rm -f toyc_compiler
    rm -f *.s
    make clean 2>/dev/null || true
    print_success "清理完成"
}

# 显示使用帮助
show_help() {
    echo "ToyC编译器构建脚本"
    echo ""
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  build    - 构建编译器 (默认)"
    echo "  test     - 运行测试用例"
    echo "  clean    - 清理构建文件"
    echo "  help     - 显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 build"
    echo "  $0 test"
    echo "  ./toyc_compiler < input.tc > output.s"
    echo "  ./toyc_compiler -opt < input.tc > output.s"
}

# 主函数
main() {
    case "${1:-build}" in
        "build")
            check_dependencies
            if [ "$CMAKE_AVAILABLE" = true ]; then
                build_with_cmake
            else
                build_with_make
            fi
            print_success "构建完成！可执行文件: ./toyc_compiler"
            ;;
        "test")
            run_tests
            ;;
        "clean")
            clean
            ;;
        "help")
            show_help
            ;;
        *)
            print_error "未知选项: $1"
            show_help
            exit 1
            ;;
    esac
}

# 脚本入口
main "$@"
