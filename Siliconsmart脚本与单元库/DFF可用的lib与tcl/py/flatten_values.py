import re

lib_name = "OTFT_stdlib_ref13to16"
# 错误修正1：给lib_path加r前缀，使用原始字符串避免反斜杠转义问题
lib_path = r"C:\THU\课题组\数字电路设计全流程\THU_OTFT_stdlib_public\Siliconsmart脚本与单元库\DFF可用的lib与tcl\py"
input_file = fr"{lib_path}\{lib_name}.lib"
output_file = fr"{lib_path}\{lib_name}_fix.lib"

# 错误修正2：补充读取输入文件的代码，定义lines变量（核心修正）
try:
    with open(input_file, "r", encoding="utf-8") as f:
        lines = f.readlines()  # 读取文件所有行到lines列表中
except FileNotFoundError:
    print(f"错误：未找到输入文件 {input_file}，请检查路径是否正确！")
    exit(1)  # 退出程序，避免后续报错

out = []
i = 0
n = len(lines)

while i < n:
    line = lines[i]

    # 匹配：values ( \
    if re.search(r'\bvalues\s*\(\s*\\\s*$', line):
        indent = line[:line.find("v")]  # 保留原始缩进
        buf = []

        i += 1
        while i < n:
            l = lines[i].rstrip()

            # 去掉用于续行的反斜杠
            if l.endswith("\\"):
                l = l[:-1].rstrip()

            buf.append(l.strip())

            if l.endswith(");"):
                break
            i += 1

        merged = " ".join(buf)
        out.append(f"{indent}values ({merged}\n")
    else:
        out.append(line)

    i += 1

with open(output_file, "w", encoding="utf-8") as f:
    f.writelines(out)

print("Done. Output written to:")
print(output_file)
