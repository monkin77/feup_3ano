BOARD_NUM_ROWS = 6
BOARD_NUM_COLS = 7

EMPTY_CELL = 0
P1_CELL = 1
P2_CELL = 2

state = {
    "board": [[EMPTY_CELL for x in range(BOARD_NUM_COLS)] for y in range(BOARD_NUM_ROWS)],
    "turn": 1
}


def showState():
    for row in state["board"]:
        print(row)
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
        col =  int( input("Player " + str(state["turn"]) + ", choose The Column\n") )
        if isValidCell(col):
            row = calculateRowFromCol(col)
            return (row, col)
        print("That's an invalid input!")

def make_turn(row, col):
    state["board"][row][col] = P1_CELL if state["turn"] == 1 else P2_CELL
    state["turn"] = 3 - state["turn"]

def endGame():
    # DETECT ENDGAME

def play():
    while True:
        showState()
        endGame()

        (row, col) = getPlayerInput()
        print(row, col)
        make_turn(row, col)


if __name__ == '__main__':
    play()
