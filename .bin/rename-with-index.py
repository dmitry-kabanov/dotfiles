import argparse
import os
import glob

p = argparse.ArgumentParser()
p.add_argument("prefix")
args = p.parse_args()

if args.prefix is None:
    raise ValueError("Provide argument 'prefix'")

for index, oldfile in enumerate(glob.glob("*.jpg"), start=1):
    newfile = f"{args.prefix}_{index:02d}.jpg"
    print(f"Rename {oldfile} \t => {newfile}")
    os.rename(oldfile, newfile)
