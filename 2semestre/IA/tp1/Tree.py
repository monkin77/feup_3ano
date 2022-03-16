class Node:
    def __init__(self, value, prev) -> None:
        self.value = value
        self.prev = prev

    def __str__(self):
        return self.value
