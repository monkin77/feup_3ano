import Tree
from copy import deepcopy

algTypes = {
    "uniform": 1,
    "greedy": 2,
    "A*": 3
}


class SearchProblem:
    def __init__(self, initState, goalState, isFinalState):
        self.initState = initState
        self.goalState = goalState
        self.initialNode = Tree.Node((initState, 0), -1)
        self.queue = [self.initialNode]
        self.isFinalState = isFinalState

    def getPrevNodes(self, node: Tree.Node):
        sol = []
        currentNode = node
        while currentNode.prev != -1:
            sol.insert(0, currentNode.value)
            currentNode = currentNode.prev
        sol.insert(0, currentNode.value)
        return sol

    # verifyTransitions determines if it is uniform, greedy or A*
    def informedSearch(self, type, verifyTransitions, algType):
        while True:
            if len(self.queue) == 0:
                print("No solution found :(")
                return -1
            currentNode = self.queue[0]
            (currentState, _) = currentNode.value
            # print("currentState: ", currentState)
            if self.isFinalState(currentState):
                break

            currTransitions = verifyTransitions(currentNode, type, algType)
            for transition in currTransitions:
                self.queue.append(Tree.Node(transition, currentNode))

            self.queue.pop(0)
            self.queue.sort(key=lambda node: node.value[1])
            # print("---currTransitions---")
            # for node in queue:
            #     print(node.value)

        sol = self.getPrevNodes(currentNode)

        print("Search path:")
        for node in sol:
            print(node[0])
        print("Solution depth:", len(sol))
