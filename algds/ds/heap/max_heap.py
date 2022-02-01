import unittest

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

def heapSort(arr):
    heap = MinHeap(arr)
    return [heap.extract_min() for i in range(len(heap.heap))]

class TestHeap (unittest.TestCase):
    def testHeapify(self):
        # There are many valid arrays heapify could return
        self.assertEqual(MinHeap([9, 11, 18, 13, 15, 14, 7, 8, 12, 9, 4, 6, 3]).heap, [3, 4, 6, 8, 9, 9, 7, 13, 12, 11, 15, 18, 14])

    def testGetMin(self):
        self.assertEqual(MinHeap([9, 11, 18, 13, 15, 14, 7, 8, 12, 9, 4, 6, 3]).get_min(), 3)
        self.assertEqual(MinHeap([9, 11, 2, 13, 15, 14, 7, 8, 12, 9, 4, 6, 3]).get_min(), 2)

    def testInsert(self):
        heap = MinHeap([9, 11, 2, 13, 15, 14, 7, 8, 12, 9, 4, 6, 3])
        self.assertEqual(heap.get_min(), 2)
        heap.insert(1)
        self.assertEqual(heap.get_min(), 1)

    def testHeapSort(self):
        self.assertEqual(heapSort([5, 2, 3, 4, 1]), [1, 2, 3, 4, 5])
        self.assertEqual(heapSort([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5])
        self.assertEqual(heapSort([5]), [5])
        self.assertEqual(heapSort([]), [])

if __name__ == '__main__':
    unittest.main()
