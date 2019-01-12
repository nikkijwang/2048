import pygame

pygame.init()

dwidth = 800
dheight = 600
tsize = 100

black = (0, 0, 0)
white = (255, 255, 255)
red = (255, 0, 0)

display = pygame.display.set_mode((dwidth, dheight))
pygame.display.set_caption("Sliding Block")

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

def slide(speed):
    movex = 0
    movey = 0
    base = display.copy()

    moveLeft, moveTop = getPos(movex, movey)
    pygame.draw.rect(base, black, (moveLeft, moveTop, tsize, tsize))

    for i in range(0, tsize * 3 + 1, speed):
        display.blit(base, (0,0))
        drawTile(movex, movey, i, 0)
        update()

def reset():
    display.fill(white)
    drawBoard()
    drawTile(0, 0)

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
                slide(2)

        update()
