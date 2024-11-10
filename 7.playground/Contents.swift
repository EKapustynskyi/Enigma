import sys
import math

# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

g, h, q = [int(i) for i in input().split()]

def solve(g, h, q):
    # Calculate N as the square root of (p - 1) and round it up
    N = int(math.ceil(math.sqrt(q - 1)))
    values = {}

    # Baby step: calculate g^i % p for i from 0 to N-1 and store in values dictionary
    for i in range(N):
        values[pow(g, i, q)] = i

    # Calculate the factor for the giant steps using Fermat's Little Theorem
    factor = pow(g, N * (q - 2), q)

    # Giant step: calculate h * factor^j % p for j from 0 to N-1
    for j in range(N):
        current_value = (h * pow(factor, j, q)) % q
        if current_value in values:
            # If we find a match, return the solution
            return j * N + values[current_value]

    return None

# print(g)

x = solve(g, h, q)
print(x)
