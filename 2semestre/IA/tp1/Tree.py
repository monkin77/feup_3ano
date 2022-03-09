class Node:
    def __init__(self, state, prev) -> None:
        self.state = state
        self.prev = prev

    def __str__(self):
        return self.state
