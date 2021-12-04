#!/usr/bin/env python3

def first():
    ct = 0
    prev = None
    with open("data/01") as f:
        for line in f:
            val = int(line.strip())
            if prev is not None:
                diff = val - prev
                if diff > 0:
                    ct += 1
            prev = val
    print("ex1 pt1", ct)


def second():
    ct = 0
    prev = None
    with open("data/01") as f:
        vals = [int(line.strip()) for line in f]
        for ix in range(len(vals) - 2):
            val = sum(vals[ix:ix+3])
            if prev is not None:
                diff = val - prev
                if diff > 0:
                    ct += 1
            prev = val
    print("ex1 pt2", ct)


first()
second()
