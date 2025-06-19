#!/usr/bin/env python
import argparse
import re
import os

p = argparse.ArgumentParser()
p.add_argument("start_number", type=int, help="from which number to start")
args = p.parse_args()

files = os.listdir()
files.sort()
num = args.start_number

for file in files:
    if file.endswith(".jpg") or file.endswith(".jpeg"):
        if re.match(r"^P\d{5}", file):
            dest = f"P{num:05d}{file[6:]}"
        else:
            dest = f"P{num:05d}{file}"

        print(f"{file} => {dest}")
        os.rename(file, dest)
        num += 1
    else:
        print(f"Skipped file '{file}'")
