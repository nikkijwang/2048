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

	# ---------- Edited ---------- #
	if not pygame.mixer.music.get_busy():
		pygame.mixer.music.play(-1, 5)
	# ---------------------------- #

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

# -------------------- updated item -------------------- #
def gameInstr():
	instr = True

	while instr:
		for event in pygame.event.get():
			if event.type == pygame.QUIT:
				pygame.quit()
				quit()

		gameDisplay.fill(white)
		largeText = pygame.font.SysFont("jokerman", 115)
		smallText = pygame.font.SysFont("stencil", 40)
		TitleSurf, TitleRect = textObjects("Instructions", largeText, black)
		instrSurf1, instrRect1 = textObjects("GOAL: Reach the number 2048", smallText, bright_red)
		instrSurf2, instrRect2 = textObjects("W:  Shift Up", smallText, black)
		instrSurf3, instrRect3 = textObjects("A:  Shift Left", smallText, black)
		instrSurf4, instrRect4 = textObjects("S:  Shift Down", smallText, black)
		instrSurf5, instrRect5 = textObjects("D:  Shift Right", smallText, black)
		TitleRect.center = ((display_width/2), 50)
		instrRect1.center = ((display_width/2), (display_height/2 - 150))
		instrRect2.center = ((display_width/2), (display_height/2 - 90))
		instrRect3.center = ((display_width/2), (display_height/2 - 45))
		instrRect4.center = ((display_width/2), (display_height/2 ))
		instrRect5.center = ((display_width/2), (display_height/2 + 45))
		gameDisplay.blit(TitleSurf, TitleRect)
		gameDisplay.blit(instrSurf1, instrRect1)
		gameDisplay.blit(instrSurf2, instrRect2)
		gameDisplay.blit(instrSurf3, instrRect3)
		gameDisplay.blit(instrSurf4, instrRect4)
		gameDisplay.blit(instrSurf5, instrRect5)

		button("Start", 150, 450, 100, 50, green, bright_green, gameLoop)
		button("Quit", 550, 450, 100, 50, red, bright_red, quitgame)

		pygame.display.update()
		clock.tick(15)

# ------------------------------------------------------ #
def gameLoop():
	gameIntro()

gameIntro()
gameLoop()
pygame.quit()
quit()