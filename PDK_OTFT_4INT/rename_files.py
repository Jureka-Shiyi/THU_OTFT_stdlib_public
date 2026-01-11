import os

def batch_rename_files():
    # 获取当前工作目录（脚本运行时所在的文件夹）
    current_dir = os.getcwd()
    print(f"当前操作文件夹：{current_dir}")
    
    # 定义需要替换的旧字符串和新字符串
    old_str = "CJ_OTFT20251202"
    new_str = "OTFT_4INT"
    rename_count = 0  # 统计重命名成功的文件数量

    # 遍历当前文件夹内的所有文件（不包含子文件夹）
    for filename in os.listdir(current_dir):
        # 拼接文件的完整路径
        file_path = os.path.join(current_dir, filename)
        
        # 仅处理文件（跳过文件夹，避免误操作）
        if os.path.isfile(file_path):
            # 判断文件名中是否包含需要替换的旧字符串
            if old_str in filename:
                # 替换文件名中的旧字符串为新字符串
                new_filename = filename.replace(old_str, new_str)
                # 拼接新文件的完整路径
                new_file_path = os.path.join(current_dir, new_filename)
                
                # 执行重命名操作
                try:
                    os.rename(file_path, new_file_path)
                    print(f"成功重命名：{filename} -> {new_filename}")
                    rename_count += 1
                except Exception as e:
                    print(f"重命名失败 {filename}：{str(e)}")

    print(f"\n批量重命名完成！共成功重命名 {rename_count} 个文件")

if __name__ == "__main__":
    batch_rename_files()