import math


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


def calculateRowFromCol(col, board):
    for i in range(BOARD_NUM_ROWS - 1, 0, -1):
        if board[i][col] == EMPTY_CELL:
            return i
    return -1


def getPlayerInput():
    while True:
        col = int(
            input("Player " + str(state["turn"]) + ", choose The Column\n"))
        if isValidCell(col):
            row = calculateRowFromCol(col, state["board"])
            return (row, col)
        print("That's an invalid input!")


def make_turn(row, col, player, board):
    board[row][col] = player

# numPieces -> number of pieces trying to detect in a row
# Returns -> Number of horizontal solutions for a cell


def checkHorizontal(row, col, player, board, numPieces, withEmptySlot):
    for emptySlot in [0, numPieces-1]:
        piecesCount = 0
        for i in range(numPieces):
            newCol = col+i
            target = player if (i != emptySlot or (not withEmptySlot)) else EMPTY_CELL 
            if newCol < BOARD_NUM_COLS:
                if board[row][newCol] == target:
                    piecesCount += 1
                else:
                    break
        if piecesCount == numPieces:
            return 1

    return 0

# numPieces -> number of pieces trying to detect in a row
# Returns -> Number of horizontal solutions for a cell


def checkVertical(row, col, player, board, numPieces, withEmptySlot):
    for emptySlot in [0, numPieces-1]:
        piecesCount = 0
        for i in range(numPieces):
            newRow = row+i
            target = player if (i != emptySlot or (not withEmptySlot)) else EMPTY_CELL 
            if newRow < BOARD_NUM_ROWS:
                if board[newRow][col] == target:
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
def checkDiagonal(row, col, player, board, numPieces, withEmptySlot):
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
                    if board[newRow][newCol] == target:
                        piecesCount += 1
                    else:
                        break
            if piecesCount == numPieces:
                solCount += 1

    return solCount


def endGame(board, player):
    # DETECT ENDGAME
    for i in range(BOARD_NUM_ROWS):
        for j in range(BOARD_NUM_COLS):
            if checkHorizontal(i, j, player, board, NUM_CONSECUTIVE, False):
                return True
            if checkVertical(i, j, player, board, NUM_CONSECUTIVE, False):
                return True
            if checkDiagonal(i, j, player, board, NUM_CONSECUTIVE, False):
                return True

    return False

def nlines4(player, board):
    numSolutions = 0
    for i in range(BOARD_NUM_ROWS):
        for j in range(BOARD_NUM_COLS):
            numSolutions += checkHorizontal(i, j, player, board, 4, False)
            numSolutions += checkVertical(i, j, player, board, 4, False)
            numSolutions += checkDiagonal(i, j, player, board, 4, False)
    return numSolutions

def nlines3(player, board):
    numSolutions = 0
    for i in range(BOARD_NUM_ROWS):
        for j in range(BOARD_NUM_COLS):
            numSolutions += checkHorizontal(i, j, player, board, 4, True)
            numSolutions += checkVertical(i, j, player, board, 4, True)
            numSolutions += checkDiagonal(i, j, player, board, 4, True)
    return numSolutions

def central(player, board):
    numPoints = 0
    midCol = BOARD_NUM_COLS // 2
    for i in range(BOARD_NUM_ROWS):
        if board[i][midCol] == player:
            numPoints += 2
    
    for col in [midCol-1, midCol+1]:
        for i in range(BOARD_NUM_ROWS):
            if board[i][col] == player:
                numPoints += 1
    
    return numPoints

def evalF1(board):
    return nlines4(2, board) - nlines4(1, board)
def evalF2(board):
    return 100*evalF1(board) + nlines3(2, board) - nlines3(1, board)
def evalF3(board):
    return 100*evalF1(board) + central(2, board) - central(1, board)
def evalF4(board):
    return 5*evalF2(board) + evalF3(board)

def minimax(depth, alpha, beta, maximizingPlayer, board, evaluation):
    player = 2 if maximizingPlayer else 1
    if depth == 0 or endGame(board, player):
        return {"score": evaluation(board)}
    
    if maximizingPlayer:
        maxEval = {"score": -math.inf}
        for col in range(BOARD_NUM_COLS):
            if not isValidCell(col):
                continue
            row = calculateRowFromCol(col, board)
            newBoard = [line.copy() for line in board]
            make_turn(row, col, 2, newBoard)
            eval = minimax(depth-1, alpha, beta, False, newBoard, evaluation)
            if eval["score"] > maxEval["score"]:
                maxEval = {"score": eval["score"], "play": (row,col)}
            alpha = max(alpha, eval["score"])
            if beta <= alpha:
                break

        return maxEval
    else:
        minEval = {"score": math.inf}
        for col in range(BOARD_NUM_COLS):
            if not isValidCell(col):
                continue
            row = calculateRowFromCol(col, board)
            newBoard = [line.copy() for line in board]
            make_turn(row, col, 1, newBoard)
            eval = minimax(depth-1, alpha, beta, True, newBoard, evaluation)
            if eval["score"] < minEval["score"]:
                minEval = {"score": eval["score"], "play": (row, col)}
            beta = min(beta, eval["score"])
            if beta <= alpha:
                break

        return minEval

def play():
    while True:
        showState()

        if state["turn"] == 1:
            (row, col) = getPlayerInput()
        else:
            (row, col) = minimax(5, -math.inf, math.inf, True, state["board"], evalF4)["play"]

        make_turn(row, col, state["turn"], state["board"])

        if endGame(state["board"], state["turn"]):
            showBoard()
            print("Player", state["turn"], " Won the game!")
            return
        state["turn"] = 3 - state["turn"]


if __name__ == '__main__':
    play()
