import re
import codecs
import os

def fix_paths(file_path):
    # 使用 utf-8-sig 兼容带 BOM 的情况，写入时使用 utf-8 (Hugo/GitHub 推荐)
    with codecs.open(file_path, 'r', 'utf-8-sig') as f:
        content = f.read()
    
    # 替换 exp1-part1.assets 路径
    # 匹配 src=".\exp1-part1.assets\ 或 src="任意路径\exp1-part1.assets\
    content = re.sub(r'src=".*?exp1-part1\.assets\\', 'src="/exp1-part1.assets/', content)
    
    # 替换 images 路径
    content = re.sub(r'src=".*?images\\', 'src="/images/', content)

    # 替换 Markdown 格式链接中的反斜杠 (如果有)
    # content = re.sub(r'\((.*?exp1-part1\.assets)\\(.*?)\)', r'(/\1/\2)', content)

    with codecs.open(file_path, 'w', 'utf-8') as f:
        f.write(content)

if __name__ == "__main__":
    target = r"C:\D\luohaomin\Work\TA\ustc-isp-page\content\exp1\exp1-part1.md"
    fix_paths(target)
    print("Paths fixed successfully.")
