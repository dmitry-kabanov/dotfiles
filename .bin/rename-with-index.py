import argparse
import os
import glob
import sys

p = argparse.ArgumentParser()
p.add_argument("prefix")
args = p.parse_args()

if args.prefix is None:
    raise ValueError("Provide argument 'prefix'")

file_list = []
for index, oldfile in enumerate(glob.glob("*.jpeg"), start=1):
    file_list.append(oldfile)

if not file_list:
    print("After searching for images '*.jpeg', the file list is empty", file=stderr)
    sys.exit(1)

file_list.sort()
assert len(file_list) < 100, "Program can rename files with index in range 1..99"

for index, oldfile in enumerate(file_list, start=1):
    newfile = f"{args.prefix}_{index:02d}.jpg"
    print(f"Rename {oldfile} \t => {newfile}")
    os.rename(oldfile, newfile)
