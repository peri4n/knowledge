# Heap Sort

Heap Sort is a very easy to understand sorting algorithm, if you understand *Heaps*.
It builds up a [Heap](../../ds/heap/index.md) and continually extracts the max/min of the top of it.

## Implementation in Python

```python
import heapq

def heapsort(arr):
    heapq.heapify(arr)
    return [heapq.heappop(arr) for i in range(len(arr))]
```
