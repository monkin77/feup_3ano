import Tree

initState = (
    [[1, 5, 3],
    [4, 2, 8],
    [7, 0, 6]],
    (2, 1)
)

goalState = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 0]
]


initialNode = Tree.Node(initState, 0, -1)
queue = [initialNode]
history = []

def verifyTransitions(state):
    transitions = []
    if state[0] < c1:   # fill B1
        s1 = (c1, state[1])
        n1 =
        if not s1 in history:
            transitions.append(s1)
    if state[1] < c2:
        s2 = (state[0], c2)
        if not s2 in history:
            transitions.append(s2)
    if state[0] > 0:    # empty B1
        s3 = (0, state[1])
        if not s3 in history:
            transitions.append(s3)
    if state[1] > 0:
        s4 = (state[0], 0)
        if not s4 in history:
            transitions.append(s4)

    if state[0] > c2-state[1] and state[1] < c2:
        s5 = (state[0] - (c2-state[1]), c2)
        if not s5 in history:
            transitions.append(s5)
    if c2 - state[1] > state[0]:
        s6 = (0, state[0] + state[1])
        if not s6 in history:
            transitions.append(s6)
    if state[1] > c1-state[0] and state[0] < c1:
        s7 = (c1, state[1] - (c1-state[0]))
        if not s7 in history:
            transitions.append(s7)
    if c1 - state[0] > state[1]:
        s8 = (state[0] + state[1], 0)
        if not s8 in history:
            transitions.append(s8)

    return transitions

def isFinalState(currState):
    currPositions = currState[0]
    for i in range(0, len(currPositions), 1):
        for j in range(0, len(currPositions[0]), 1):
            if currPositions[i][j] != goalState[i][j]:
                return False
    return True

def bfs():
    while True:
        currentNode = queue[0]
        currentState = currentNode.state
        if isFinalState(currentState):
            break
        # print("Queue:")
        # for elem in queue:
        #     print(elem.__str__())

        currTransitions = verifyTransitions(currentState)
        for transition in currTransitions:
            queue.append(Tree.Node(transition, currentNode.cost + , currentNode))
            history.append(transition)

        queue.pop(0)

    sol = []
    while currentNode.prev != -1:
        sol.insert(0, currentNode.state)
        currentNode = currentNode.prev
    sol.insert(0, currentNode.state)

    print("Breadth-First search path:")
    for node in sol:
        print(node)

