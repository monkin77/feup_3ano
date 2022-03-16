import Tree
from copy import deepcopy

initState = (
    [[1, 6, 2],
     [5, 7, 3],
     [0, 4, 8]],
    (2, 0)
)

goalState = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 0]
]

# Node value = (state, cost)
initialNode = Tree.Node((initState, 0), -1)
boardSize = len(initState[0])
queue = [initialNode]
history = []


def isArrayEqual(l1, l2):
    for i in range(0, len(l1), 1):
        for j in range(0, len(l1[0]), 1):
            if l1[i][j] != l2[i][j]:
                return False
    return True


def isFinalState(currState):
    currPositions = currState[0]
    return isArrayEqual(currPositions, goalState)


def getPrevNodes(node: Tree.Node):
    sol = []
    currentNode = node
    while currentNode.prev != -1:
        sol.insert(0, currentNode.value)
        currentNode = currentNode.prev
    sol.insert(0, currentNode.value)
    return sol


def isVisited(currentLeaf: Tree.Node, newBoard):
    currentNode = currentLeaf
    while currentNode != -1:
        if isArrayEqual(currentNode.value[0][0], newBoard):
            return True
        currentNode = currentNode.prev
    return False


def verifyTransitions(node: Tree.Node):
    prevBoard = node.value[0][0]
    (RE, CE) = node.value[0][1]
    cost = node.value[1]
    newCost = cost + 1  # Since the newCost is cost+1 in this case
    transitions = []
    if CE < boardSize - 1:  # Move Piece left
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE][CE+1]
        newBoard[RE][CE+1] = 0
        newEmptyPos = (RE, CE+1)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if CE > 0:  # Move piece right
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE][CE-1]
        newBoard[RE][CE-1] = 0
        newEmptyPos = (RE, CE-1)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if RE < boardSize - 1:  # Move piece up
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE+1][CE]
        newBoard[RE+1][CE] = 0
        newEmptyPos = (RE+1, CE)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if RE > 0:  # Move piece down
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE-1][CE]
        newBoard[RE-1][CE] = 0
        newEmptyPos = (RE-1, CE)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)

    return transitions


def uniformCost():
    while True:
        if len(queue) == 0:
            print("No solution found :(")
            return -1
        currentNode = queue[0]
        (currentState, _) = currentNode.value
        # print("currentState: ", currentState)
        if isFinalState(currentState):
            break
        # print("Queue:")
        # for elem in queue:
        #     print(elem.__str__())

        currTransitions = verifyTransitions(currentNode)
        for transition in currTransitions:
            queue.append(Tree.Node(transition, currentNode))

        queue.pop(0)
        queue.sort(key=lambda node: node.value[1])
        # print("---currTransitions---")
        # for node in queue:
        #     print(node.value)

    sol = getPrevNodes(currentNode)

    print("Uniform-Cost search path:")
    for node in sol:
        print(node[0])


def heuristic(state, currCost, type):
    board = state[0]
    h = currCost
    if type == 1:
        for i in range(0, len(board), 1):
            for j in range(0, len(board[0]), 1):
                if board[i][j] != goalState[i][j]:
                    h += 1
    else:
        for i in range(0, len(board), 1):
            for j in range(0, len(board[0]), 1):
                currVal = board[i][j]
                if currVal != 0:
                    goalCol = (currVal - 1) % boardSize
                    goalRow = (currVal - 1) // boardSize
                else:
                    goalCol = boardSize - 1
                    goalRow = boardSize - 1
                h += (abs(i-goalRow) + abs(j - goalCol))
    return h


def verifyGreedyTransitions(node: Tree.Node, type):
    state = node.value[0]
    prevBoard = state[0]
    (RE, CE) = state[1]
    cost = node.value[1]

    transitions = []
    if CE < boardSize - 1:  # Move Piece left
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE][CE+1]
        newBoard[RE][CE+1] = 0
        newEmptyPos = (RE, CE+1)
        newCost = heuristic((newBoard, newEmptyPos), 0, type)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if CE > 0:  # Move piece right
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE][CE-1]
        newBoard[RE][CE-1] = 0
        newEmptyPos = (RE, CE-1)
        newCost = heuristic((newBoard, newEmptyPos), 0, type)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if RE < boardSize - 1:  # Move piece up
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE+1][CE]
        newBoard[RE+1][CE] = 0
        newEmptyPos = (RE+1, CE)
        newCost = heuristic((newBoard, newEmptyPos), 0, type)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if RE > 0:  # Move piece down
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE-1][CE]
        newBoard[RE-1][CE] = 0
        newEmptyPos = (RE-1, CE)
        newCost = heuristic((newBoard, newEmptyPos), 0, type)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)

    return transitions

# type -> 0 or 1 for different heuristics


def greedy(type):
    while True:
        if len(queue) == 0:
            print("No solution found :(")
            return -1
        currentNode = queue[0]
        (currentState, _) = currentNode.value
        # print("currentState: ", currentState)
        if isFinalState(currentState):
            break

        currTransitions = verifyGreedyTransitions(currentNode, type)
        for transition in currTransitions:
            queue.append(Tree.Node(transition, currentNode))

        queue.pop(0)
        queue.sort(key=lambda node: node.value[1])
        # print("---currTransitions---")
        # for node in queue:
        #     print(node.value)

    sol = getPrevNodes(currentNode)

    # print("Greedy search path:")
    for node in sol:
        print(node[0])


def verifyAStarTransitions(node: Tree.Node, type):
    state = node.value[0]
    prevBoard = state[0]
    (RE, CE) = state[1]
    cost = node.value[1]

    transitions = []
    if CE < boardSize - 1:  # Move Piece left
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE][CE+1]
        newBoard[RE][CE+1] = 0
        newEmptyPos = (RE, CE+1)
        newCost = heuristic((newBoard, newEmptyPos), cost, type)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if CE > 0:  # Move piece right
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE][CE-1]
        newBoard[RE][CE-1] = 0
        newEmptyPos = (RE, CE-1)
        newCost = heuristic((newBoard, newEmptyPos), cost, type)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if RE < boardSize - 1:  # Move piece up
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE+1][CE]
        newBoard[RE+1][CE] = 0
        newEmptyPos = (RE+1, CE)
        newCost = heuristic((newBoard, newEmptyPos), cost, type)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if RE > 0:  # Move piece down
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE-1][CE]
        newBoard[RE-1][CE] = 0
        newEmptyPos = (RE-1, CE)
        newCost = heuristic((newBoard, newEmptyPos), cost, type)
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)

    return transitions


def aStar(type):
    while True:
        if len(queue) == 0:
            print("No solution found :(")
            return -1
        currentNode = queue[0]
        (currentState, _) = currentNode.value
        print("currentState: ", currentState)
        if isFinalState(currentState):
            break

        currTransitions = verifyAStarTransitions(currentNode, type)
        for transition in currTransitions:
            queue.append(Tree.Node(transition, currentNode))

        queue.pop(0)
        queue.sort(key=lambda node: node.value[1])
        # print("---currTransitions---")
        # for node in queue:
        #     print(node.value)

    sol = getPrevNodes(currentNode)

    print("A* search path:")
    for node in sol:
        print(node[0])
