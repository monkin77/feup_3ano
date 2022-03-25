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


def checkHorizontal(row, col, player, numPieces):
    piecesCount = 0
    solCount = 0

    for i in range(numPieces):
        newCol = col+i
        if newCol < BOARD_NUM_COLS:
            if state["board"][row][newCol] == player:
                piecesCount += 1
            else:
                break
    if piecesCount == numPieces:
        solCount += 1

    piecesCount = 0
    for i in range(numPieces):
        newCol = col - i
        if newCol >= 0:
            if state["board"][row][newCol] == player:
                piecesCount += 1
            else:
                break
    if piecesCount == numPieces:
        solCount += 1
    return solCount

# numPieces -> number of pieces trying to detect in a row
# Returns -> Number of horizontal solutions for a cell


def checkVertical(row, col, player, numPieces):
    piecesCount = 0
    solCount = 0

    for i in range(numPieces):
        newRow = row+i
        if newRow < BOARD_NUM_ROWS:
            if state["board"][newRow][col] == player:
                piecesCount += 1
            else:
                break
    if piecesCount == numPieces:
        solCount += 1

    piecesCount = 0
    for i in range(numPieces):
        newRow = row - i
        if newRow >= 0:
            if state["board"][newRow][col] == player:
                piecesCount += 1
            else:
                break
    if piecesCount == numPieces:
        solCount += 1
    return solCount


"""
# numPieces -> number of pieces trying to detect in a row
# Returns -> Number of horizontal solutions for a cell
"""
def checkDiagonal(row, col, player, numPieces):
    solCount = 0

    directions = [(-1, -1), (-1, 1), (1, 1), (1, -1)]
    for direction in directions:
        piecesCount = 0
        for i in range(numPieces):
            newRow = row + direction[0] * i
            newCol = col + direction[1] * i
            if (newRow < BOARD_NUM_ROWS) and (newRow >= 0) and (newCol >= 0) and (newCol < BOARD_NUM_COLS):
                if state["board"][newRow][newCol] == player:
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
            if checkHorizontal(i, j, state["turn"], NUM_CONSECUTIVE):
                return True
            if checkVertical(i, j, state["turn"], NUM_CONSECUTIVE):
                return True
            if checkDiagonal(i, j, state["turn"], NUM_CONSECUTIVE):
                return True

    return False


def play():
    while True:
        showState()

        (row, col) = getPlayerInput()
        make_turn(row, col)

        if endGame():
            showBoard()
            print("Player", state["turn"], " Won the game!")
            return
        state["turn"] = 3 - state["turn"]


if __name__ == '__main__':
    play()
