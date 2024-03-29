# Heap

A *Heap* is a tree structure. There are many different kinds of Heaps each having different characteristics.

## Max Heap

A *Max Heap* is a Heap is a *binary tree* in which the element within a node is larger than all elements in it's two subtrees.
This guarantees that the largest element in always in the *root* node.

### Python Implementation

```python
class MinHeap:
    def __init__(self, arr=None):
        self.heap = []
        if type(arr) is list:
            self.heap = arr.copy()
            for i in range(len(self.heap))[::-1]:
                self._siftDown(i)

    def _siftUp(self, i):
        parent = (i - 1) // 2
        while i != 0 and self.heap[parent] > self.heap[i]:
            self.heap[parent], self.heap[i] = self.heap[i], self.heap[parent]
            i = parent
            parent = (i - 1) // 2

    def _siftDown(self, i):
        left = 2 * i + 1
        right = 2 * i + 2
        while (left < len(self.heap) and self.heap[i] > self.heap[left]) or (right < len(self.heap) and self.heap[i] > self.heap[right]):
            smallest = left if (right >= len(self.heap) or self.heap[left] < self.heap[right]) else right
            self.heap[i], self.heap[smallest] = self.heap[smallest], self.heap[i]
            i = smallest
            left = 2*i + 1
            right = 2*i + 2

    def extract_min(self):
        if len(self.heap) == 0:
            return None
        minval = self.heap[0]
        self.heap[0], self.heap[-1] = self.heap[-1], self.heap[0]
        self.heap.pop()
        self._siftDown(0)

        return minval

    def insert(self, element):
        self.heap.append(element)
        self._siftUp(len(self.heap) - 1)

    def get_min(self):
        return self.heap[0] if len(self.heap) > 0 else None
```

