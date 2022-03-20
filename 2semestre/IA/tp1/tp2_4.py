from SearchProblem import SearchProblem, algTypes
import Tree
from copy import deepcopy

initState = (0, 0)
goalState = (2, -1)  # 2nd bucket doesn't matter
c1 = 4
c2 = 3


def isFinalState(currState):
    return currState[0] == 2


def isVisited(currentLeaf: Tree.Node, newState):
    currentNode = currentLeaf
    while currentNode != -1:
        if currentNode.value[0] == newState:
            return True
        currentNode = currentNode.prev
    return False


def heuristic(state, currCost, type):
    h = currCost
    if type == 1:
        h += abs(state[0] - goalState[0])
    else:
        h += (abs(state[0] - goalState[0]) + abs(state[1] - goalState[1]))

    return h


def verifyTransitions(node: Tree.Node, type, algType):
    transitions = []
    state = node.value[0]
    cost = node.value[1] + 1 if algType != algTypes["greedy"] else 0

    if state[0] < c1:   # fill B1
        newState = (c1, state[1])
        newCost = heuristic(
            newState, cost, type) if algType != algTypes["uniform"] else cost
        newNode = (newState, newCost)
        if not isVisited(node, newState):
            transitions.append(newNode)
    if state[1] < c2:
        newState = (state[0], c2)
        newCost = heuristic(
            newState, cost, type) if algType != algTypes["uniform"] else cost
        newNode = (newState, newCost)
        if not isVisited(node, newState):
            transitions.append(newNode)
    if state[0] > 0:    # empty B1
        newState = (0, state[1])
        newCost = heuristic(
            newState, cost, type) if algType != algTypes["uniform"] else cost
        newNode = (newState, newCost)
        if not isVisited(node, newState):
            transitions.append(newNode)
    if state[1] > 0:
        newState = (state[0], 0)
        newCost = heuristic(
            newState, cost, type) if algType != algTypes["uniform"] else cost
        newNode = (newState, newCost)
        if not isVisited(node, newState):
            transitions.append(newNode)

    if state[0] > c2-state[1] and state[1] < c2:
        newState = (state[0] - (c2-state[1]), c2)
        newCost = heuristic(
            newState, cost, type) if algType != algTypes["uniform"] else cost
        newNode = (newState, newCost)
        if not isVisited(node, newState):
            transitions.append(newNode)
    if c2 - state[1] > state[0]:
        newState = (0, state[0] + state[1])
        newCost = heuristic(
            newState, cost, type) if algType != algTypes["uniform"] else cost
        newNode = (newState, newCost)
        if not isVisited(node, newState):
            transitions.append(newNode)
    if state[1] > c1-state[0] and state[0] < c1:
        newState = (c1, state[1] - (c1-state[0]))
        newCost = heuristic(
            newState, cost, type) if algType != algTypes["uniform"] else cost
        newNode = (newState, newCost)
        if not isVisited(node, newState):
            transitions.append(newNode)
    if c1 - state[0] > state[1]:
        newState = (state[0] + state[1], 0)
        newCost = heuristic(
            newState, cost, type) if algType != algTypes["uniform"] else cost
        newNode = (newState, newCost)
        if not isVisited(node, newState):
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
