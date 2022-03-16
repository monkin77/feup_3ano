import Tree
from copy import deepcopy

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
        print("currentState: ", currentState)
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
        print(node)
