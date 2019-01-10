import pygame
import numpy as np
import random

pygame.init()

display_width = 800
display_height = 600
tilesize = 100

black = (0, 0, 0)
white = (255, 255, 255)

c2 = (66, 206, 244)
c4 = (66, 188, 244)
c8 = (66, 164, 244)
c16 = (66, 137, 244)
c32 = (66, 98, 244)
c64 = (75, 66, 244)
c128 = (60, 43, 242)
c256 = (59, 15, 255)
c512 = (49, 31, 244)
c1024 = (57, 14, 247)
c2048 = (0, 0, 255)

gameDisplay = pygame.display.set_mode((display_width, display_height))
pygame.display.set_caption("Sliding Blocks")

font = pygame.font.SysFont("impact", 20)

clock = pygame.time.Clock()

row = 4
col = 4
gameData = np.full([row, col], None)
dataMove = np.zeros([row, col], dtype = int)
gameOver = False

def drawGrid():
    pygame.draw.rect(gameDisplay, black, ((display_width/2) - 200, (display_height/2) - 200, 400, 400), 3)
    pygame.draw.rect(gameDisplay, black, ((display_width/2) - 200, (display_height/2) - 200, 400, 100), 3)
    pygame.draw.rect(gameDisplay, black, ((display_width/2) - 200, (display_height/2), 400, 100), 3)
    pygame.draw.rect(gameDisplay, black, ((display_width/2) - 200, (display_height/2) - 200, 100, 400), 3)
    pygame.draw.rect(gameDisplay, black, ((display_width/2), (display_height/2) - 200, 100, 400), 3)

def textObjects(text):
    textSurface = font.render(text, True, black)
    return textSurface, textSurface.get_rect()

def pickColor(data):
    color = {
        2: c2,
        4: c4,
        8: c8,
        16: c16,
        32: c32,
        64: c64,
        128: c128,
        256: c256,
        512: c512,
        1024: c1024,
        2048: c2048,
        }

    return color.get(data, black)

def shiftData(iLoop, i, j, availSpace, data, openSpace):
    #print(iLoop)
    if str(iLoop) == "row" or str(iLoop) == "row - 1":
        space = i
    else:
        space = j

    if not availSpace and data == None:
        openSpace = space
        availSpace = True
    elif availSpace and data != None:
        if str(iLoop) == "row" or str(iLoop) == "row - 1":
            gameData[openSpace][j] = data
            dataMove[i][j] += abs(openSpace - i)
        else:
            # print("col or col - 1")
            gameData[i][openSpace] = data
            dataMove[i][j] += abs(openSpace - j)

        gameData[i][j] = None

        if str(iLoop) == "row" or str(iLoop) == "col":
            openSpace += 1
        else:
            openSpace -= 1
    return availSpace, openSpace

def slideUp():
    openRow = None
    for j in range(col):
        availSpace = False
        for i in range(row):
            #if not availSpace and gameData[i][j] == None:
            #    openRow = i
            #    availSpace = True
            #elif availSpace and gameData[i][j] != None:
            #    gameData[openRow][j] = gameData[i][j]
            #    openRow += 1
            #    gameData[i][j] = None
            availSpace, openRow = shiftData("row", i, j, availSpace, gameData[i][j], openRow)

    for j in range(col):
        for i in range(row - 1):
            if gameData[i][j] == gameData[i + 1][j] and gameData[i][j] != None:
                gameData[i][j] *= 2
                dataMove[i + j][j] += 1
                gameData[i + 1][j] = None

                for k in range(i + 1, row - 1):
                    gameData[k][j] = gameData[k + 1][j]
                    dataMove[k + 1][j] += 1
                    gameData[k + 1][j] = None
    print(dataMove)

def slideLeft():
    openCol = None
    for i in range(row):
        availSpace = False
        for j in range(col):
            availSpace, openCol = shiftData("col", i, j, availSpace, gameData[i][j], openCol)

    for i in range(row):
        for j in range(col - 1):
            if gameData[i][j] == gameData[i][j + 1] and gameData[i][j] != None:
                gameData[i][j] *= 2
                gameData[i][j + 1] = None

                for k in range(j + 1, col - 1):
                    gameData[i][k] = gameData[i][k + 1]
                    gameData[i][k + 1] = None

def slideDown():
    openRow = None
    for j in range(col):
        availSpace = False
        for i in range(row - 1, -1, -1):
            availSpace, openRow = shiftData("row - 1", i, j, availSpace, gameData[i][j], openRow)

    for j in range(col):
        for i in range(row - 1, 0, -1):
            if gameData[i][j] == gameData[i - 1][j] and gameData[i][j] != None:
                gameData[i][j] *= 2
                gameData[i - 1][j] = None

                for k in range(i - 1, 0, -1):
                    gameData[k][j] = gameData[k - 1][j]
                    gameData[k - 1][j] = None

def slideRight():
    openCol = None
    for i in range(row):
        availSpace = False
        for j in range(col - 1, -1, -1):
            availSpace, openCol = shiftData("col - 1", i, j, availSpace, gameData[i][j], openCol)

    for i in range(row):
        for j in range(col - 1, 0, -1):
            if gameData[i][j] == gameData[i][j - 1] and gameData[i][j] != None:
                gameData[i][j] *= 2
                gameData[i][j - 1] = None

                for k in range(j - 1, 0, -1):
                    gameData[i][k] = gameData[i][k - 1]
                    gameData[i][k - 1] = None

def genNewBlk():
    global gameData

    data = random.randint(1,2) * 2

    foundPos = False

    while not foundPos:
        row = random.randint(0, 3)
        col = random.randint(0, 3)
        if (gameData[row][col] == None):
            gameData[row][col] = data
            foundPos = True

    x = (display_width / 2) + ((col - 2) * tilesize)
    y = (display_height / 2) + ((row - 2) * tilesize)
 
    # pygame.draw.rect(gameDisplay, color, (x, y, tilesize, tilesize))
    # tileSurf, tileRect = textObjects(str(data))
    # tileRect.center = (x + (tilesize/2), y + (tilesize/2))
    # gameDisplay.blit(tileSurf, tileRect)
    drawBoard()

def drawBoard():
    global gameData
    gameDisplay.fill(white)
    for i in range(row):
        for j in range(col):
            x = (display_width / 2) + ((j - 2) * tilesize)
            y = (display_height / 2) + ((i - 2) * tilesize)
            data = gameData[i][j]
            color = pickColor(data)

            if data is not None:
                text = data
            else:
                text = ' '
                
            pygame.draw.rect(gameDisplay, color, (x, y, tilesize, tilesize))
            tileSurf, tileRect = textObjects(str(text))
            tileRect.center = (x + (tilesize/2), y + (tilesize/2))
            gameDisplay.blit(tileSurf, tileRect)

def checkData(i, j, pv, nbn, sameNum):
    if gameData[i][j] == None:
        pv = None
    elif pv == None:
        nbn = True
        pv = gameData[i][j]
    elif gameData[i][j] == pv:
        sameNum = True
    else:
        pv = gameData[i][j]

    return pv, nbn, sameNum

def checkValid(choice):
    valid = False

    nbn = False
    sameNum = False

    if choice == 'w':
        for j in range(col):
            pv = 1
            for i in range(row):
                pv, nbn, sameNum = checkData(i, j, pv, nbn, sameNum)

            if nbn or sameNum:
                valid = True
                break
    elif choice == 'a':
        for i in range(row):
            pv = 1
            for j in range(col):
                pv, nbn, sameNum = checkData(i, j, pv, nbn, sameNum)

            if nbn or sameNum:
                valid = True
                break
    elif choice == 's':
        for j in range(col):
            pv = 1
            for i in range(row - 1, -1, -1):
                pv, nbn, sameNum = checkData(i, j, pv, nbn, sameNum)

            if nbn or sameNum:
                valid = True
                break
    elif choice == 'd':
        for i in range(row):
            pv = 1
            for j in range(col - 1, -1, -1):
                pv, nbn, sameNum = checkData(i, j, pv, nbn, sameNum)

            if nbn or sameNum:
                valid = True
                break

    return valid

def checkContinue():
    movePossible = False

    for i in range(row):
        for j in range(col - 1):
            if gameData[i][j] == None or gameData[i][j + 1] == None or gameData[i][j] == gameData[i][j + 1]:
                movePossible = True
                break

            if i != row - 1:
                if gameData[i + 1][j] == None or gameData[i][j] == gameData[i + 1][j]:
                    movePossible = True
                    break
        if movePossible:
            break

    if not movePossible:
        gameOver = True

def slideAnimation(board, direction, animationSpeed):
    None

def makeMove(choice):
    valid = False

    if checkValid(choice):
        board = gameData
        if choice == 'w':
            slideUp()
        elif choice == 'a':
            slideLeft()
        elif choice == 's':
            slideDown()
        elif choice == 'd':
            slideRight()

        genNewBlk()
        checkContinue()

def initGame():
    for i in range(2):
        genNewBlk()

gameDisplay.fill(white)
initGame()
while True:
    # gameDisplay.fill(white)
    drawGrid()
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            quit()

        if event.type == pygame.KEYUP:
            if event.key == pygame.K_w or event.key == pygame.K_UP:
                makeMove('w')
            elif event.key == pygame.K_a or event.key == pygame.K_LEFT:
                makeMove('a')
            elif event.key == pygame.K_s or event.key == pygame.K_DOWN:
                makeMove('s')
            elif event.key == pygame.K_d or event.key == pygame.K_RIGHT:
                makeMove('d')

    pygame.display.update()
    clock.tick(60)

pygame.quit()
quit()
