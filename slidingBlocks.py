import numpy as np
import pygame
import random

pygame.init()

dwidth = 800
dheight = 600
tsize = 100

black = (0, 0, 0)
white = (255, 255, 255)
red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)

UP = 'up'
LEFT = 'left'
DOWN = 'down'
RIGHT = 'right'

gameDisplay = pygame.display.set_mode((dwidth, dheight))
pygame.display.set_caption("Slide Animation")

clock = pygame.time.Clock()

row = 4
col = 4
data = np.full([row,col], None)
dataMove = np.zeros([row, col])

font = pygame.font.SysFont("impact", 20)

def pickColor(data):
    color = {
        2: red,
        4: green,
        8: blue,
    }

    return color.get(data, black)

def shiftData(iloop, i, j, availspace, tile, openspace):
    if str(iloop) == "row" or str(iloop) == "row - 1":
        space = i
    else:
        space = j

    if not availspace and tile == None:
        openspace = space
        availspace = True
    elif availspace and tile != None:
        if str(iloop) == "row" or str(iloop) == "row - 1":
            data[i][openspace] = tile
            dataMove[i][j] += abs(openspace - i)
        else:
            data[i][openspace] = data
            dataMove[i][j] += abs(openspace - j)

        data[i][j] = None

        if str(iloop) == "row" or str(iloop) == "col":
            openspace += 1
        else:
            openspace -= 1

    return availspace, openspace

def getTilePosition(i, j):
    left = (i * tsize) + i - 1
    top = (j * tsize) + j - 1
    return left, top

def drawTile(x, y, adjx = 0, adjy = 0):
    left, top = getTilePosition(x, y)
    tile = data[x][y]
    color = pickColor(tile)
    pygame.draw.rect(gameDisplay, color, (left, top, tsize, tsize))
    textSurf, textRect = textObjects(str(tile))
    textRect.center = (left + (tsize/2), top + (tsize/2))
    gameDisplay.blit(textSurf, textRect)

def clrMoves():
    for i in range(row):
        for j in range(col):
            dataMove[i][j] = 0

def animateUp(base, speed):
    for j in range(col):
        for i in range(row):
            moves = dataMove[i][j]
            if moves != 0:
                for k in range(0, int(moves*tsize), speed):
                    gameDisplay.blit(base, (0, 0))
                    drawTile(i, j, 0, -k)
                    pygame.display.update()
                    clock.tick(60)

    clrMoves()


def slideAnimation(direction, animationSpeed):
    # Copy the current board
    drawBoard()
    baseSurf = gameDisplay.copy()

    # Shift data
    if direction == UP:
        slideup()
    elif direction == LEFT:
        slideleft()
    elif direction == DOWN:
        slidedown()
    elif direction == RIGHT:
        slideright()

    # Draw blank space over moving tile
    for i in range(row):
        for j in range(col):
            if data[i][j] == None:
                left, top = getTilePosition(i, j)
                pygame.draw.rect(baseSurf, black, (left, top, tsize, tsize))

    # Animate sliding blocks
    if direction == UP:
        animateUp(baseSurf, animationSpeed)

def slideup():
    openrow = None
    for j in range(col):
        availspace = False
        for i in range(row):
            availspace, openrow = shiftData("row", i, j, availspace, data[i][j], openrow)

    for j in range(col):
        for i in range(row - 1):
            if data[i][j] == data[i + 1][j] and data[i][j] != None:
                data[i][j] *= 2
                dataMove[i + 1][j] += 1
                data[i + 1][j] = None

                for k in range(i + 1, row - 1):
                    data[k][j] = data[k + 1][j]
                    dataMove[k + 1][j] += 1
                    data[k + 1][j] = None

    print(dataMove)

def slideleft():
    opencol = None
    for i in range(row):
        availspace = False
        for j in range(col):
            availspace, opencol = shiftData("col", i, j, availspace, data[i][j], opencol)
            
    for i in range(row):
        for j in range(col -1):
            if data[i][j] == data[i][j + 1] and data[i][j] != None:
                data[i][j] *= 2
                dataMove[i][j + 1] += 1
                data[i][j+ 1] = None

                for k in range(j + 1, col - 1):
                    data[i][k] = data[i][k + 1]
                    dataMove[i][k + 1] += 1
                    data[i][k + 1] = None

def slidedown():
    openrow = None
    for j in range(col):
        availspace = False
        for i in range(row - 1, -1, -1):
            availspace, openrow = shiftData("row - 1", i, j, availspace, data[i][j], openrow)

        for j in range(col):
            for i in range(row - 1, 0, -1):
                if data[i][j] == data[i - 1][j] and data[i][j] != None:
                    data[i][j] *= 2
                    dataMove[i - 1][j] += 1
                    data[i - 1][j] = None

                    for k in range(i - 1, 0, -1):
                        data[k][j] = data[k - 1][j]
                        dataMove[k - 1][j] += 1
                        data[k - 1][j] = None

def slideright():
    opencol = None
    for i in range(row):
        availspace = False
        for j in range(col - 1, -1, -1):
            availspace, opencol = shiftData("col - 1", i, j, availspace, data[i][j], opencol)

    for i in range(row):
        for j in range(col - 1, 0, -1):
            if data[i][j] == data[i][j - 1] and data[i][j] != None:
                data[i][j] *= 2
                dataMove[i][j - 1] += 1
                data[i][j - 1] = None

                for k in range(j - 1, 0, -1):
                    data[i][k] = data[i][k - 1]
                    dataMove[i][k - 1] += 1
                    data[i][k - 1] = None

def genNewBlk():
    tile = random.randint(1,2) * 2
    foundPos = False

    while not foundPos:
        row = random.randint(0, 3)
        col = random.randint(0, 3)
        if data[row][col] == None:
            data[row][col] = tile
            foundPos = True

    drawBoard()

def textObjects(text):
    textSurface = font.render(text, True, white)
    return textSurface, textSurface.get_rect()

def drawBoard():
    gameDisplay.fill(white)
    pygame.draw.rect(gameDisplay, black, ((dwidth/2) - 200, (dheight/2) - 200, 400, 400), 3)
    for i in range(row):
        for j in range(col):
            x = (dwidth/2) + ((j - 2) * tsize)
            y = (dheight/2) + ((i - 2) * tsize)
            tile = data[i][j]

            if tile is not None:
                color = red
                text = tile
            else:
                color = black
                text = ' '

            pygame.draw.rect(gameDisplay, color, (x, y, tsize, tsize))
            tileSurf, tileRect = textObjects(str(text))
            tileRect.center = (x + (tsize/2), y + (tsize/2))
            gameDisplay.blit(tileSurf,tileRect)


gameDisplay.fill(white)
while True:
    drawBoard()
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            quit()

        if event.type == pygame.KEYUP:
            if event.key == pygame.K_SPACE:
                genNewBlk()
            elif event.key == pygame.K_w or event.key == pygame.K_UP:
                slideAnimation(UP, 2)

    pygame.display.update()
    clock.tick(60)

pygame.quit()
quit()
