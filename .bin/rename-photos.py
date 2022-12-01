#!/usr/bin/env python3
import argparse
import os
import re
import shutil
import tempfile


def main(dirname: str):
    if not os.path.isdir(dirname):
        raise ValueError('Dirname is incorrect')

    renamed_tmpdir = os.path.join(dirname, '_renamed')
    if os.path.isdir(renamed_tmpdir):
        shutil.rmtree(renamed_tmpdir)
    os.mkdir(renamed_tmpdir)

    jpegs_dir = os.path.join(dirname, "jpegs")
    os.makedirs(jpegs_dir, exist_ok=True)

    originals_tmpdir = tempfile.mkdtemp()

    files = os.listdir(dirname)
    for f in files:
        old_file = os.path.join(dirname, f)

        if not os.path.isfile(old_file):
            continue

        new_f = _get_new_filename(f)
        print(f"{f} => {new_f}")

        new_filename = os.path.join(renamed_tmpdir, new_f)

        if os.path.isfile(new_filename):
            raise ValueError(f"File with name {new_filename} already exists")

        # # Copy to the "originals" folder.
        shutil.copy2(old_file, os.path.join(originals_tmpdir, f))

        os.rename(old_file, new_filename)

    os.rename(originals_tmpdir, os.path.join(dirname, "originals"))

    renamed_files = os.listdir(renamed_tmpdir)

    for f in renamed_files:
        # Find the index of file extension in the file name.
        d = f.rfind('.')
        d += 1

        if (f[d:] in ['jpg', 'jpeg']) and (f[:d] + 'dng' in renamed_files):
            print('Found duplicate file %s' % f)
            os.rename(
                os.path.join(renamed_tmpdir, f),
                os.path.join(jpegs_dir, f)
            )
        else:
            os.rename(
                os.path.join(renamed_tmpdir, f),
                os.path.join(dirname, f)
            )

    os.rmdir(renamed_tmpdir)


def _get_new_filename(f: str) -> str:
    pxl_re = re.compile(
        r"^PXL_(\d{4})(\d{2})(\d{2})_(\d{2})(\d{2})(\d{2})(\d{3})(\.\w+)?(\.dng|\.jpg)$"
    )

    new_f = ""
    if f.lower().startswith("pxl_"):
        # Check for pattern "PXL_20220802_125122426.NIGHT.dng".
        match = pxl_re.match(f)
        if match:
            chunks = match.groups()
            date = "-".join(chunks[0:3])
            time = ".".join(chunks[3:6])
            _ = chunks[6]
            suff = chunks[7] if chunks[7] else ""
            ext = chunks[8]
            new_f = date + " " + time + suff + ext
    else:
        if f.lower().startswith('img_'):
            f = f[4:]

        if f.lower().startswith('vid_'):
            f = f[4:]

        date = f[:4] + '-' + f[4:6] + '-' + f[6:8]
        new_f = date + ' ' + f[9:11] + '.' + f[11:13] + '.' + f[13:]

    return new_f


if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument('dirname', help='Directory in which to work')
    args = p.parse_args()
    main(args.dirname)
