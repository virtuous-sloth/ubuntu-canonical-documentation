# Analyze Ubuntu and Canonical documentation structure

## Introduction

For those people for whom knowing the structure underlying something helps them
find information, such as myself, I want to collect and analyze what structure
I can find.

From the highest level, let's start with the primary entry points for
documentation, these three URLs (note that for this document I'll leave off
the `https://`.

- wiki.ubuntu.com/
- wiki.canonical.com/
- docs.ubuntu.com/

The first two are obvisously wikis and designed to stand on their own as both
the source and presentation of documentation, but will also likely point to
other sources/locations. The last is a regular web page that functions as a
landing page pointing to a collection of documentation web sites. The former
wikis have a long history dataing back to the beginning of Ubuntu and Canonical
while the latter is part of a concerted effort apply a more rigorous practice
to documentation at Canonical. Since the latter is forward-looking we'll start
there.

## docs.ubuntu.com

[This script](docs.ubuntu.com_table.sh) fetches the `docs.ubuntu.com` page and
processes out the documentation site links into a
[markdown table](docs.ubuntu.com_table.md)
```
00       1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```
