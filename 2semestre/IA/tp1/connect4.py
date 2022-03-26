BOARD_NUM_ROWS = 6
BOARD_NUM_COLS = 7

EMPTY_CELL = 0
P1_CELL = 1
P2_CELL = 2

state = {
    "board": [[EMPTY_CELL for x in range(BOARD_NUM_COLS)] for y in range(BOARD_NUM_ROWS)],
    "turn": 1
}

NUM_CONSECUTIVE = 4


def showBoard():
    for row in state["board"]:
        print(row)
    print()


def showState():
    showBoard()
    print("Player's turn: ", state["turn"])
    print()


def isValidCell(col):
    if col < 0 or col >= BOARD_NUM_COLS:
        return False
    return state["board"][0][col] == EMPTY_CELL


def calculateRowFromCol(col):
    for i in range(BOARD_NUM_ROWS - 1, 0, -1):
        if state["board"][i][col] == EMPTY_CELL:
            return i
    return -1


def getPlayerInput():
    while True:
        col = int(
            input("Player " + str(state["turn"]) + ", choose The Column\n"))
        if isValidCell(col):
            row = calculateRowFromCol(col)
            return (row, col)
        print("That's an invalid input!")


def make_turn(row, col):
    state["board"][row][col] = P1_CELL if state["turn"] == 1 else P2_CELL

# numPieces -> number of pieces trying to detect in a row
# Returns -> Number of horizontal solutions for a cell


def checkHorizontal(row, col, player, numPieces, withEmptySlot):
    for emptySlot in [0, numPieces-1]:
        piecesCount = 0
        for i in range(numPieces):
            newCol = col+i
            target = player if (i != emptySlot or (not withEmptySlot)) else EMPTY_CELL 
            if newCol < BOARD_NUM_COLS:
                if state["board"][row][newCol] == target:
                    piecesCount += 1
                else:
                    break
        if piecesCount == numPieces:
            return 1

    return 0

# numPieces -> number of pieces trying to detect in a row
# Returns -> Number of horizontal solutions for a cell


def checkVertical(row, col, player, numPieces, withEmptySlot):
    for emptySlot in [0, numPieces-1]:
        piecesCount = 0
        for i in range(numPieces):
            newRow = row+i
            target = player if (i != emptySlot or (not withEmptySlot)) else EMPTY_CELL 
            if newRow < BOARD_NUM_ROWS:
                if state["board"][newRow][col] == target:
                    piecesCount += 1
                else:
                    break
        if piecesCount == numPieces:
            return 1

    return 0


"""
# numPieces -> number of pieces trying to detect in a row
# Returns -> Number of horizontal solutions for a cell
"""
def checkDiagonal(row, col, player, numPieces, withEmptySlot):
    solCount = 0

    directions = [(-1, 1), (1, 1)]

    for direction in directions:
        for emptySlot in [0, numPieces-1]:
            piecesCount = 0
            for i in range(numPieces):
                newRow = row + direction[0] * i
                newCol = col + direction[1] * i
                target = player if (i != emptySlot or (not withEmptySlot)) else EMPTY_CELL 
                if (newRow < BOARD_NUM_ROWS) and (newRow >= 0) and (newCol >= 0) and (newCol < BOARD_NUM_COLS):
                    if state["board"][newRow][newCol] == target:
                        piecesCount += 1
                    else:
                        break
            if piecesCount == numPieces:
                solCount += 1

    return solCount


def endGame():
    # DETECT ENDGAME
    for i in range(BOARD_NUM_ROWS):
        for j in range(BOARD_NUM_COLS):
            if checkHorizontal(i, j, state["turn"], NUM_CONSECUTIVE, False):
                return True
            if checkVertical(i, j, state["turn"], NUM_CONSECUTIVE, False):
                return True
            if checkDiagonal(i, j, state["turn"], NUM_CONSECUTIVE, False):
                return True

    return False

def nlines4():
    numSolutions = 0
    for i in range(BOARD_NUM_ROWS):
        for j in range(BOARD_NUM_COLS):
            numSolutions += checkHorizontal(i, j, state["turn"], 4, False)
            numSolutions += checkVertical(i, j, state["turn"], 4, False)
            numSolutions += checkDiagonal(i, j, state["turn"], 4, False)
    return numSolutions

def nlines3():
    numSolutions = 0
    for i in range(BOARD_NUM_ROWS):
        for j in range(BOARD_NUM_COLS):
            numSolutions += checkHorizontal(i, j, state["turn"], 4, True)
            numSolutions += checkVertical(i, j, state["turn"], 4, True)
            numSolutions += checkDiagonal(i, j, state["turn"], 4, True)
    return numSolutions

def central():
    numPoints = 0
    midCol = BOARD_NUM_COLS // 2
    for i in range(BOARD_NUM_ROWS):
        if state["board"][i][midCol] == state["turn"]:
            numPoints += 2
    
    for col in [midCol-1, midCol+1]:
        for i in range(BOARD_NUM_ROWS):
            if state["board"][i][col] == state["turn"]:
                numPoints += 1
    
    return numPoints

def play():
    while True:
        showState()

        (row, col) = getPlayerInput()
        make_turn(row, col)

        print("nlines4:", nlines4())
        print("nlines3:", nlines3())
        print("central:", central())
        if endGame():
            showBoard()
            print("Player", state["turn"], " Won the game!")
            return
        state["turn"] = 3 - state["turn"]


if __name__ == '__main__':
    play()
