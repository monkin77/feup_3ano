from SearchProblem import SearchProblem, algTypes
import Tree
from copy import deepcopy

initState = (
    [[7, 1, 3],
     [8, 0, 6],
     [4, 5, 2]],
    (1, 1)
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


def isVisited(currentLeaf: Tree.Node, newBoard):
    currentNode = currentLeaf
    while currentNode != -1:
        if isArrayEqual(currentNode.value[0][0], newBoard):
            return True
        currentNode = currentNode.prev
    return False


def heuristic(state, currCost, type):
    board = state[0]
    h = currCost
    if type == 1:   # Nº of incorrectly placed pieces
        for i in range(0, len(board), 1):
            for j in range(0, len(board[0]), 1):
                if board[i][j] != goalState[i][j]:
                    h += 1
    else:   # Sum of Manhatan distances from incorrected placed pieces to their correct places
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


def verifyTransitions(node: Tree.Node, type, algType):
    state = node.value[0]
    prevBoard = state[0]
    (RE, CE) = state[1]
    # If algorithm is greedy cost does not take into account the cost to reach the current state
    cost = node.value[1] if algType != algTypes["greedy"] else 0

    transitions = []
    if CE < boardSize - 1:  # Move Piece left
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE][CE+1]
        newBoard[RE][CE+1] = 0
        newEmptyPos = (RE, CE+1)
        # If algorith is uniform, cost is the cost to reach the current state
        newCost = heuristic((newBoard, newEmptyPos), cost,
                            type) if algType != algTypes["uniform"] else cost
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if CE > 0:  # Move piece right
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE][CE-1]
        newBoard[RE][CE-1] = 0
        newEmptyPos = (RE, CE-1)
        # If algorith is uniform, cost is the cost to reach the current state
        newCost = heuristic((newBoard, newEmptyPos), cost,
                            type) if algType != algTypes["uniform"] else cost
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if RE < boardSize - 1:  # Move piece up
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE+1][CE]
        newBoard[RE+1][CE] = 0
        newEmptyPos = (RE+1, CE)
        # If algorith is uniform, cost is the cost to reach the current state
        newCost = heuristic((newBoard, newEmptyPos), cost,
                            type) if algType != algTypes["uniform"] else cost
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)
    if RE > 0:  # Move piece down
        newBoard = deepcopy(prevBoard)
        newBoard[RE][CE] = prevBoard[RE-1][CE]
        newBoard[RE-1][CE] = 0
        newEmptyPos = (RE-1, CE)
        # If algorith is uniform, cost is the cost to reach the current state
        newCost = heuristic((newBoard, newEmptyPos), cost,
                            type) if algType != algTypes["uniform"] else cost
        newNode = ((newBoard, newEmptyPos), newCost)
        if not isVisited(node, newBoard):
            transitions.append(newNode)

    return transitions


def uniformCost():
    print("Calculating Uniform solution...")
    solution = SearchProblem(initState, isFinalState)
    solution.informedSearch(-1, verifyTransitions, algTypes["uniform"])


def greedy(type):
    print("Calculating Greedy solution for type", type, "...")
    solution = SearchProblem(initState, isFinalState)
    solution.informedSearch(type, verifyTransitions, algTypes["greedy"])


def aStar(type):
    print("Calculating A* solution for type", type, "...")
    solution = SearchProblem(initState, isFinalState)
    solution.informedSearch(type, verifyTransitions, algTypes["A*"])