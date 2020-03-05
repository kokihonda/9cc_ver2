#!/bin/bash
try() {
    expected="$1"
    input="$2"

    ./9cc "$input" > tmp.s
    gcc -o tmp tmp.s
    ./tmp
    actual="$?"

    if [ "$actual" == "$expected" ]; then
        echo "$input => $actual"
    else
        echo "$input => $expected expected, but got $actual" 
        exit 1
    fi
}

try 0 "0;" 
try 42 "42;" 
try 21 "5+20-4;"
try 41 " 12 + 34 - 5; "
try 47 "5+6*7;"
try 15 "5*(9-6);"
try 4 "(3+5)/2;"
try 9 "-3*-3;"
try 5 "-3*+5+ 20;"
try 1 "1 < 3;"
try 0 "1 > 3;"
try 1 "1 <= 4;"
try 4 "(1 >= 5) + 4 * 1;"
try 1 "1 == 1;"
try 0 "1 != 1;"
try 5 "2*5; 1*5;"
try 18 "b = 5; b*4-2;" 
try 3 "a = 5; b=-2; a+b;"
try 3 "a = 5; b=-2; c=a+b; c;"
try 3 "foo= 5; bar=-2; ans=foo+bar; ans;"
try 14 "a = 3;
    b = 5 * 6 - 8;
    return a + b / 2;"
try 4 "i = 1; num = 3; if (i == 1) 
						num = 4;;
						return num;"
try 3 "i = 0; num = 3; if (i == 1) 
						num = 4;;
						return num;"
try 5 "i = 0; num = 3; if (i == 1) 
						num = 4;
						else
						num=5;
						return num;"
try 3 "i = 1; n=3; while (i < n)
							i = i+1;
							return i;"
try 100 "i = 1; n=100; while (i < n)
							i = i+1;
							return i;"
try 4 "ans = 0; n=5; for (i=1;i<n;i = i+2)
						ans = ans + i;
						return ans;"
echo Ok