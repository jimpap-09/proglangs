
# NOTIFICATION!!!
# we used stack-overflow and chat-gpt
# to guide us on our journey with python

from collections import deque
import sys
import numpy as np

# Node class
class Node:
    # constructor
    def __init__ (self, x, y, path=None):
        self.x = x
        self.y = y
        self.path = path if path is not None else []

# function for valid cords
def isValid(x, y):
    if 0 <= x < n and 0 <= y < n:
        return True
    else:
        return False

# recieve the filepath
file_path = sys.argv[1]
# open the infile according to filepath
infile = open(file_path)
# read the first line
n = int(infile.readline())
plane = []

# for the rest n lines create a plane (list of lists)
for line in infile:
    row = list(map(int, line.split()))
    plane.append(row)

# convert it to an array using numpy
grid = np.array(plane)

# possible directions
dirs = [(-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1)]
directions = {(-1, 0):"N", (-1, 1):"NE", (0, 1):"E", (1, 1):"SE", (1, 0):"S", (1, -1):"SW", (0, -1):"W", (-1, -1):"NW"}

# bfs algorithm
def bfs (grid, n):
    # mark all the nodes as unvisited
    visited = np.zeros((n, n), dtype=bool)
    # start from (0, 0)
    start = (0, 0)
    # the target is (n-1, n-1)
    finish = (n-1, n-1)
    # mark the starting node as visited
    visited[0, 0] = True
    # and add it in the queue
    queue = deque([(start, [])])
    # as long as the queue is not empty
    while queue:
        # mark the first node as current node
        (x, y), path = queue.popleft()
        # if the current node is the target then return its path
        if (x, y) == finish:
            return path
        # otherwise for each possible direction
        for dx, dy in dirs:
            nx, ny = x + dx, y + dy
            # if the next node is valid and unvisited with less grid than the current one
            if isValid(nx, ny) and not visited[nx, ny] and grid[nx, ny] < grid[x, y]:
                # then visit that node and add it in the queue with its new path
                visited[nx, ny] = True
                queue.append(((nx, ny), path + [directions[(dx, dy)]]))
    # if the queue is empty and we haven't found the target yet, then return IMPOSSIBLE
    return "IMPOSSIBLE"

# return IMPOSSIBLE or the path in the right form
result = bfs(grid, n)
if result == "IMPOSSIBLE":
    print(result)
else:
    print(f"[{','.join(result)}]")