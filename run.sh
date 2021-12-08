#!/bin/bash

python3 src/ex01.py
node src/ex02.js
lua src/ex03.lua
gcc src/ex04.c -std=c11 -Wall -Wextra && ./a.out && rm a.out
java src/ex05.java
scheme src/ex06.ss --quiet
php -f src/ex07.php
