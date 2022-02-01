import heapq
import unittest

def heapsort(arr):
    heapq.heapify(arr)
    return [heapq.heappop(arr) for i in range(len(arr))]

class TestHeapSort(unittest.TestCase):
    def testSort(self):
        self.assertEqual(heapsort([5, 2, 3, 4, 1]), [1, 2, 3, 4, 5])
        self.assertEqual(heapsort([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5])
        self.assertEqual(heapsort([5]), [5])
        self.assertEqual(heapsort([]), [])

if __name__ == '__main__':
    unittest.main()
