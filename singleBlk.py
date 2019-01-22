import pygame
import numpy as np

pygame.init()

dwidth = 800
dheight = 600
tsize = 100

black = (0, 0, 0)
white = (255, 255, 255)
red = (255, 0, 0)

display = pygame.display.set_mode((dwidth, dheight))
pygame.display.set_caption("Sliding Block")

# Moves
moves = np.zeros([4, 4], dtype = int)

def update():
    pygame.display.update()

def drawBoard():
    x = (dwidth/2) - (2 * tsize)
    y = (dheight/2) - (2 * tsize)
    pygame.draw.rect(display, black, (x, y, 4*tsize, 4*tsize))

def getPos(x, y):
    left = (dwidth/2) + ((x - 2) * tsize)
    top = (dheight/2) + ((y - 2) * tsize)
    return left, top

def drawTile(x, y, adjx = 0, adjy = 0):
    left, top = getPos(x, y)
    pygame.draw.rect(display, red, (left + adjx, top + adjy, tsize, tsize))

def slide(direction, speed):
    # movex = 0
    # movey = 0
    # base = display.copy()

    # moveLeft, moveTop = getPos(movex, movey)
    # pygame.draw.rect(base, black, (moveLeft, moveTop, tsize, tsize))

    # for i in range(0, tsize * 3 + 1, speed):
    #     display.blit(base, (0,0))
    #     drawTile(movex, movey, i, 0)
    #     update()

    # test for multiple blocks
    for row in range(4):
    	for col in range(4):
    		movex = row
    		movey = col
    		base = display.copy()
    		move = moves[row][col]
    		moveLeft, moveTop = getPos(movex, movey)
    		pygame.draw.rect(base, black, (moveLeft, moveTop, tsize, tsize))
    		if move != 0:
    			for i in range(0, tsize * move + 1, speed):
    				display.blit(base, (0, 0))
    				if direction == 'up':
    					drawTile(movex, movey, 0, -i)
    				elif direction == 'left':
    					drawTile(movex, movey, -i, 0)
    				elif direction == 'down':
    					drawTile(movex, movey, 0, i)
    				elif direction == 'right':
    					drawTile(movex, movey, i, 0)
    				update()
    			moves[row][col] = 0

def reset():
    display.fill(white)
    moves[0][0] = 3
    moves[1][1] = 2
    drawBoard()
    drawTile(0, 0)
    drawTile(1, 1)

reset()
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            quit()

        if event.type == pygame.KEYUP:
            print(event)
            if event.key == pygame.K_SPACE:
                reset()
            elif event.key == pygame.K_RIGHT:
                slide('right', 1)
            elif event.key == pygame.K_UP:
            	slide('up', 1)
            elif event.key == pygame.K_LEFT:
            	slide('left', 1)
            elif event.key == pygame.K_DOWN:
            	slide('down', 1)

        update()
