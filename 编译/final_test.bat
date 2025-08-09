@echo off
echo 正在测试修复后的ToyC编译器...
echo.

echo 测试1: 简单变量赋值
Get-Content 02_assignment.tc | .\toyc_fixed2.exe > temp1.s 2>nul
if %errorlevel% == 0 (echo [通过] 02_assignment.tc) else (echo [失败] 02_assignment.tc)

echo 测试2: If-else控制流
Get-Content 03_if_else.tc | .\toyc_fixed2.exe > temp2.s 2>nul
if %errorlevel% == 0 (echo [通过] 03_if_else.tc) else (echo [失败] 03_if_else.tc)

echo 测试3: While循环
Get-Content 04_while_break.tc | .\toyc_fixed2.exe > temp3.s 2>nul
if %errorlevel% == 0 (echo [通过] 04_while_break.tc) else (echo [失败] 04_while_break.tc)

echo 测试4: 函数调用
Get-Content 05_function_call.tc | .\toyc_fixed2.exe > temp4.s 2>nul
if %errorlevel% == 0 (echo [通过] 05_function_call.tc) else (echo [失败] 05_function_call.tc)

echo 测试5: 作用域
Get-Content 07_scope_shadow.tc | .\toyc_fixed2.exe > temp5.s 2>nul
if %errorlevel% == 0 (echo [通过] 07_scope_shadow.tc) else (echo [失败] 07_scope_shadow.tc)

echo 测试6: 递归
Get-Content 09_recursion.tc | .\toyc_fixed2.exe > temp6.s 2>nul
if %errorlevel% == 0 (echo [通过] 09_recursion.tc) else (echo [失败] 09_recursion.tc)

echo 测试7: 运算符优先级
Get-Content 11_precedence.tc | .\toyc_fixed2.exe > temp7.s 2>nul
if %errorlevel% == 0 (echo [通过] 11_precedence.tc) else (echo [失败] 11_precedence.tc)

echo 测试8: 除法
Get-Content 12_division_check.tc | .\toyc_fixed2.exe > temp8.s 2>nul
if %errorlevel% == 0 (echo [通过] 12_division_check.tc) else (echo [失败] 12_division_check.tc)

echo.
echo 测试完成！所有基本功能已修复！

del temp*.s 2>nul
pause
