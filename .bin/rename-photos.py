#!/usr/bin/env python3
# 
import argparse
import os
import shutil
import tempfile

p = argparse.ArgumentParser()
p.add_argument('dirname', help='Directory in which to work')

args = vars(p.parse_args())

dirname = args["dirname"]

if not os.path.isdir(dirname):
    raise ValueError('Dirname is incorrect')

renamed_dir = os.path.join(dirname, '_renamed')
if os.path.isdir(renamed_dir):
    shutil.rmtree(renamed_dir)
os.mkdir(renamed_dir)

jpegs_dir = os.path.join(dirname, "jpegs")
os.mkdir(jpegs_dir)


files = os.listdir(dirname)

orig_dir = tempfile.mkdtemp()

for f in files:
    old_filename = os.path.join(dirname, f)

    if not os.path.isfile(old_filename):
        continue

    if f.lower().startswith('img_'):
        f = f[4:]

    if f.lower().startswith('vid_'):
        f = f[4:]


    new_filename = f[:4] + '-' + f[4:6] + '-' + f[6:8] + ' ' + f[9:11] + '.'
    new_filename += f[11:13] + '.' + f[13:]

    new_filename = os.path.join(renamed_dir, new_filename)
    # Copy file while preserving metadata.
    shutil.copy2(old_filename, new_filename)

    # Copy to the "originals" folder.
    shutil.copy2(old_filename, os.path.join(orig_dir, f))

os.rename(orig_dir, os.path.join(dirname, "originals"))

for f in files:
    old_filename = os.path.join(dirname, f)
    if not os.path.isfile(old_filename):
        continue
    os.remove(old_filename)

renamed_files = os.listdir(renamed_dir)

for f in renamed_files:
    # Find the index of file extension in the file name.
    d = f.rfind('.')
    d += 1

    if f[d:] in ['jpg', 'jpeg']:
        if f[:d] + 'dng' in renamed_files:
            print('Found duplicate file %s' % f)
            os.rename(
                os.path.join(renamed_dir, f),
                os.path.join(jpegs_dir, f)
            )
    else:
        os.rename(
            os.path.join(renamed_dir, f),
            os.path.join(dirname, f)
        )

os.rmdir(renamed_dir)
