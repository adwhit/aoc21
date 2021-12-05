#!/bin/bash

python3 src/ex01.py
node src/ex02.js
lua src/ex03.lua
gcc src/ex04.c -std=c11 -Wall -Wextra && ./a.out && rm a.out
