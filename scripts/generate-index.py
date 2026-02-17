#!/usr/bin/env python3

from pathlib import Path
import sys
import unicodedata


def unicode_normalize(s):
    return unicodedata.normalize("NFC", s)


class Bufo:
    def __init__(self, path):
        self.path = path

    def stem(self):
        return unicode_normalize(self.path.stem)

    def __str__(self):
        return unicode_normalize(self.path.name)


def main():
    repo_root = Path(__file__).parent.parent
    bufo_folder = repo_root / "all-the-bufo"

    files_by_stem = {}
    bufos = []

    for f in bufo_folder.iterdir():
        if f.suffix.lower() not in [".gif", ".jpg", ".jpeg", ".png"]:
            continue

        bufo = Bufo(f)

        if dup := files_by_stem.get(bufo.stem()):
            print(f"warning: same stem for {bufo}, {dup}", file=sys.stderr)
        else:
            files_by_stem[bufo.stem()] = bufo

        bufos.append(bufo)

    bufos.sort(key=Bufo.__str__)

    with (repo_root / "index.md").open("wt") as f:
        print("| name | image |", file=f)
        print("| - | - |", file=f)
        for b in bufos:
            print(f"| {b} | ![{b}](all-the-bufo/{b}) |", file=f)


if __name__ == "__main__":
    main()
