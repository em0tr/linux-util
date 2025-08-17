import sys, re

def slugify(title):
    return re.sub(r'[^a-z0-9]+', '-', title.lower()).strip('-')

print('## Table of Contents\n')
with open(sys.argv[1]) as f:
    for line in f:
        if line.startswith('#'):
            level = line.count('#')
            title = line.strip('# ').strip()
            link = slugify(title)
            print('  ' * (level-1) + f'- [{title}](#{link})')
