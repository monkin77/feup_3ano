from SearchProblem import SearchProblem, algTypes
import Tree
from copy import deepcopy

initState = (0, 0)
goalState = (2, -1)  # 2nd bucket doesn't matter
c1 = 4
c2 = 3


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


initState = (
    [[1, 2, 3],
     [4, 5, 6],
     [7, 0, 8]],
    (2, 1)
)

goalState = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 0]
]

boardSize = len(initState[0])


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


def verifyUniformTransitions(node: Tree.Node, type):
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
    print("Calculating Uniform solution...")
    solution = SearchProblem(initState, goalState, isFinalState)
    solution.informedSearch(-1, verifyUniformTransitions)


def heuristic(state, currCost, algType):
    board = state[0]
    # If type is greedy, then cost up until now does not count
    h = currCost if algType != algTypes["greedy"] else 0
    if algType != algTypes["uniform"]:
        for i in range(0, len(board), 1):
            for j in range(0, len(board[0]), 1):
                if board[i][j] != goalState[i][j]:
                    h += 1

    return h


def greedy(type):
    print("Calculating Greedy solution for type", type, "...")
    solution = SearchProblem(initState, goalState, isFinalState)
    heuristic = heuristic1 if type == 1 else heuristic2
    solution.informedSearch(heuristic, algTypes["greedy"])


def aStar(type):
    print("Calculating A* solution for type", type, "...")
    solution = SearchProblem(initState, goalState, isFinalState)
    heuristic = heuristic1 if type == 1 else heuristic2
    solution.informedSearch(heuristic, algTypes["A*"])
