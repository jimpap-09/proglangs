# NOTIFICATION!!!
# we used stack-overflow and chat-gpt
# to guide us on our journey with python

import numpy as np
import sys

def minDiffSubArray(a, n, tot_sum):
    # initialise the mindiff as the total sum
    mindiff = tot_sum
    # calculate the mindiff starting from k
    for k in range(0, n):
        # initialise the sum to 0
        prefix_sum = 0
        # calculate the sum of subarray starting from 0
        for i in range(k, n-1):
            prefix_sum += a[i]
            # calculate the difference
            diff = abs((tot_sum - prefix_sum) - prefix_sum)
            # if that's the minimum so far keep it
            if diff < mindiff:
                mindiff = diff
    return mindiff

# recieve the file_path
file_path = sys.argv[1]
# open the infile according to the file_path
with open(file_path, 'r') as infile:
    # read the first line
    s = int(infile.readline())
    # read the second line and store the string into a list
    arr = list(map(int, infile.readline().strip().split()))

# calculate the sum of numbers in the list
ts = sum(arr)
# calculate the minimum difference between sub Arrays
result = minDiffSubArray(arr, s, ts)
print(result)