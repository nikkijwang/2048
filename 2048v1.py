import pygame
import time
import random

pygame.init()

intro_bgm = pygame.mixer.music.load("C:/Users/Nikki Wang/Music/OK/Time to love - OCTOBER.mp3")

display_width = 800
display_height = 600

black = (0, 0, 0)
white = (255, 255, 255)

red = (200, 0, 0)
green = (0, 200, 0)
blue = (0, 0, 200)

bright_red = (255, 0, 0)
bright_green = (0, 255, 0)
bright_blue = (0, 0, 255)

gameDisplay = pygame.display.set_mode((display_width, display_height))
pygame.display.set_caption("2048")
clock = pygame.time.Clock()

def textObjects(text, font, color):
	textSurface = font.render(text, True, color)
	return textSurface, textSurface.get_rect()

def button(msg, x, y, w, h, ic, ac, action = None):
	mouse = pygame.mouse.get_pos()
	click = pygame.mouse.get_pressed()

	if x + w > mouse[0] > x and y + h > mouse[1] > y:
		pygame.draw.rect(gameDisplay, ac, (x, y, w, h))
		if click[0] == 1 and action != None:
			action()
	else:
		pygame.draw.rect(gameDisplay, ic, (x, y, w, h))

	smallText = pygame.font.SysFont("impact", 20)
	textSurf, textRect = textObjects(msg, smallText, white)
	textRect.center = ((x + (w/2)), (y + (h/2)))
	gameDisplay.blit(textSurf, textRect)

def quitgame():
	pygame.quit()
	quit()

def gameIntro():
	intro = True

	pygame.mixer.music.play(-1)

	while intro:
		for event in pygame.event.get():
			if event.type == pygame.QUIT:
				pygame.quit()
				quit()

		gameDisplay.fill(black)
		largeText = pygame.font.SysFont("impact", 115)
		TextSurf, TextRect = textObjects("2048", largeText, white)
		TextRect.center = ((display_width/2), (display_height/2))
		gameDisplay.blit(TextSurf, TextRect)

		button("Start", 150, 450, 100, 50, green, bright_green, gameLoop)
		button("Instructions", 325, 450, 150, 50, blue, bright_blue, gameInstr)
		button("Quit", 550, 450, 100, 50, red, bright_red, quitgame)

		pygame.display.update()
		clock.tick(15)

def gameInstr():
	gameIntro()

def gameLoop():
	gameIntro()

gameIntro()
gameLoop()
pygame.quit()
quit()