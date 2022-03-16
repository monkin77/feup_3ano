class Node:
    def __init__(self, state, cost, prev) -> None:
        self.state = state
        self.cost = cost
        self.prev = prev

    def __str__(self):
        return self.state
