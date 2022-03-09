from asyncio.windows_events import NULL

from numpy import dsplit
import Tree

initialState = Tree.Node((0, 0), NULL)
c1 = 4
c2 = 3
finalCapacity = 2
queue = [initialState]
history = []


def verifyTransitions(state, history):
    transitions = []
    if state[0] < c1:   # fill B1
        s1 = (c1, state[1])
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

# Breadth-First Search


def bfs():
    while True:
        currentNode = queue[0]
        currentState = currentNode.state
        if currentState[0] == 2:
            break
        # print("Queue:")
        # for elem in queue:
        #     print(elem.__str__())

        currTransitions = verifyTransitions(currentState, history)
        for transition in currTransitions:
            queue.append(Tree.Node(transition, currentNode))
            history.append(transition)

        queue.pop(0)

    sol = []
    while currentNode.prev != NULL:
        sol.insert(0, currentNode.state)
        currentNode = currentNode.prev
    sol.insert(0, currentNode.state)

    print("Breadth-First search path:")
    for node in sol:
        print(node)

# Depth First Search


def dfs():
    while True:
        while(True):
            if len(queue) == 0:  # No solution found
                return
            currentNode = queue[0]
            currentState = currentNode.state
            queue.pop(0)
            if currentState not in history:
                history.append(currentState)
                break

        if currentState[0] == 2:
            break

        currTransitions = verifyTransitions(currentState, history)
        offset = 0
        for transition in currTransitions:
            queue.insert(offset, Tree.Node(transition, currentNode))
            offset += 1

        print("queue:")
        for elem in queue:
            print(elem.__str__())
    sol = []
    while currentNode.prev != NULL:
        sol.insert(0, currentNode.state)
        currentNode = currentNode.prev
    sol.insert(0, currentNode.state)

    print("Depth-First search path:")
    for node in sol:
        print(node)

# Iterative Deepening Strategy


def iterativeDeepening():
    currMaxDeepness = 1
    foundSol = False

    while (True):
        foundNextNode = True
        currDeepness = 0
        while True:
            while(True):
                if len(queue) == 0:  # No solution found
                    foundNextNode = False
                    break
                currentNode = queue[0]
                currentState = currentNode.state
                queue.pop(0)
                if currentState not in history:
                    history.append(currentState)
                    break

            if not foundNextNode:   # Go increasse deepness
                break

            if currentState[0] == 2:    # Found solution
                foundSol = True
                break

            currTransitions = verifyTransitions(currentState, history)
            offset = 0
            for transition in currTransitions:
                queue.insert(offset, Tree.Node(transition, currentNode))
                offset += 1

            print("queue:")
            for elem in queue:
                print(elem.__str__())
        if foundSol == True:
            break
        currMaxDeepness += 1

    sol = []
    while currentNode.prev != NULL:
        sol.insert(0, currentNode.state)
        currentNode = currentNode.prev
    sol.insert(0, currentNode.state)

    print("Iterative Deepening search path:")
    for node in sol:
        print(node)


# bfs()
# dfs()
iterativeDeepening()
