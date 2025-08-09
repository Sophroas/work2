# ToyC编译器 Makefile
# 备用构建系统（如果CMake不可用）

CXX = g++
CXXFLAGS = -std=c++20 -Wall -Wextra -O2
INCLUDES = -Isrc -I.

# Flex和Bison
FLEX = flex
BISON = bison

# 目录
SRC_DIR = src
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj

# 源文件
SOURCES = $(SRC_DIR)/main.cpp \
          $(SRC_DIR)/ast.cpp \
          $(SRC_DIR)/symbol_table.cpp \
          $(SRC_DIR)/semantic_analyzer.cpp \
          $(SRC_DIR)/code_generator.cpp \
          $(SRC_DIR)/optimizer.cpp

# 生成的文件
FLEX_OUTPUT = $(BUILD_DIR)/lexer.cpp
BISON_OUTPUT = $(BUILD_DIR)/parser.cpp
BISON_HEADER = $(BUILD_DIR)/parser.hpp

GENERATED_SOURCES = $(FLEX_OUTPUT) $(BISON_OUTPUT)
ALL_SOURCES = $(SOURCES) $(GENERATED_SOURCES)

# 目标文件
OBJECTS = $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(notdir $(ALL_SOURCES)))

# 可执行文件
TARGET = toyc_compiler

.PHONY: all clean test debug help

all: $(TARGET)

# 创建目录
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# 生成词法分析器
$(FLEX_OUTPUT): $(SRC_DIR)/lexer.l $(BISON_HEADER) | $(BUILD_DIR)
	$(FLEX) -o $@ $<

# 生成语法分析器
$(BISON_OUTPUT) $(BISON_HEADER): $(SRC_DIR)/parser.y | $(BUILD_DIR)
	$(BISON) -d -o $(BISON_OUTPUT) $<

# 编译规则
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -I$(BUILD_DIR) -c $< -o $@

$(OBJ_DIR)/%.o: $(BUILD_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -I$(BUILD_DIR) -c $< -o $@

# 链接
$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) $^ -o $@

# 调试版本
debug: CXXFLAGS += -g -DDEBUG_AST -DDEBUG_SEMANTIC -DDEBUG_OPTIMIZATION
debug: $(TARGET)

# 测试
test: $(TARGET)
	@echo "运行测试用例..."
	@for tc_file in *.tc; do \
		if [ -f "$$tc_file" ]; then \
			echo "测试: $$tc_file"; \
			./$(TARGET) < "$$tc_file" > "$${tc_file%.tc}.s" 2>/dev/null; \
			if [ $$? -eq 0 ]; then \
				echo "  ✓ 编译成功"; \
			else \
				echo "  ✗ 编译失败"; \
			fi; \
		fi; \
	done

# 清理
clean:
	rm -rf $(BUILD_DIR) $(TARGET) *.s

# 帮助
help:
	@echo "ToyC编译器构建系统"
	@echo ""
	@echo "目标:"
	@echo "  all      - 构建编译器 (默认)"
	@echo "  debug    - 构建调试版本"
	@echo "  test     - 运行测试用例"
	@echo "  clean    - 清理构建文件"
	@echo "  help     - 显示此帮助信息"
	@echo ""
	@echo "使用方式:"
	@echo "  make"
	@echo "  ./toyc_compiler < input.tc > output.s"
	@echo "  ./toyc_compiler -opt < input.tc > output.s"

# 依赖关系
$(OBJ_DIR)/main.o: $(SRC_DIR)/main.cpp $(SRC_DIR)/ast.h $(SRC_DIR)/semantic_analyzer.h $(SRC_DIR)/code_generator.h $(SRC_DIR)/optimizer.h $(BISON_HEADER)
$(OBJ_DIR)/ast.o: $(SRC_DIR)/ast.cpp $(SRC_DIR)/ast.h
$(OBJ_DIR)/symbol_table.o: $(SRC_DIR)/symbol_table.cpp $(SRC_DIR)/symbol_table.h
$(OBJ_DIR)/semantic_analyzer.o: $(SRC_DIR)/semantic_analyzer.cpp $(SRC_DIR)/semantic_analyzer.h $(SRC_DIR)/ast.h $(SRC_DIR)/symbol_table.h
$(OBJ_DIR)/code_generator.o: $(SRC_DIR)/code_generator.cpp $(SRC_DIR)/code_generator.h $(SRC_DIR)/ast.h $(SRC_DIR)/symbol_table.h
$(OBJ_DIR)/optimizer.o: $(SRC_DIR)/optimizer.cpp $(SRC_DIR)/optimizer.h $(SRC_DIR)/ast.h
$(OBJ_DIR)/lexer.o: $(FLEX_OUTPUT) $(BISON_HEADER)
$(OBJ_DIR)/parser.o: $(BISON_OUTPUT) $(SRC_DIR)/ast.h
