from asyncio.windows_events import NULL
import Tree

initialState = Tree.Node((0, 0), NULL)
c1 = 4
c2 = 3
finalCapacity = 2
queue = [initialState]


def verifyTransitions(state, history):
    transitions = []
    if state[0] < c1:   # fill B1
        s1 = [c1, state[1]]
        if not s1 in history:
            transitions.append(s1)
    if state[1] < c2:
        s2 = [state[0], c2]
        if not s2 in history:
            transitions.append(s2)
    if state[0] > 0:    # empty B1
        s3 = [0, state[1]]
        if not s3 in history:
            transitions.append(s3)
    if state[1] > 0:
        s4 = [state[0], 0]
        if not s4 in history:
            transitions.append(s4)

    return transitions


while (True):
    currentNode = queue[0]
    currentState = currentNode.state
    if currentState[0] == 2:
        break

    currTransitions = verifyTransitions(currentState, [])
    print(currTransitions)
    newNode = Tree.Node((2, 0), currentState)
    queue.pop(0)
    queue.append(newNode)

print(queue)
