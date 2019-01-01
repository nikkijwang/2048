import numpy as np
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

# -------------------- Added Item -------------------- #
class game_2048:
	def __init__(self, row, col):
		self.row = row
		self.col = col
		self.gameData = np.full([row, col], None)
		self.gameOver = False
		self.initGame()

	def initGame(self):
		for i in range(2):
			self.genNewBlk()

	def genNewBlk(self):
		data = random.randint(1,2) * 2
		foundPos = False

		while not foundPos:
			row = random.randint(0, 3)
			col = random.randint(0, 3)
			if (self.gameData[row][col] == None):
				self.gameData[row][col] = data
				foundPos = True

	def slideUp(self):
		# Slide all data up
		for j in range(self.col):
			availSpace = False
			for i in range(self.row):
				# If this is the first open spot
				if not availSpace and self.gameData[i][j] == None:
					openRow = i
					availSpace = True
				elif availSpace and self.gameData[i][j] != None:
					self.gameData[openRow][j] = self.gameData[i][j]
					self.gameData[i][j] = None
					openRow += 1

		# Add like numbers together
		for j in range(self.col):
			for i in range(self.row - 1):
				# If the current and next number are the same
				if self.gameData[i][j] == self.gameData[i + 1][j] and self.gameData[i][j] != None:
					self.gameData[i][j] *= 2
					self.gameData[i + 1][j] = None

					# Shift the numbers up
					for k in range(i + 1, self.row - 1):
						self.gameData[k][j] = self.gameData[k + 1][j]
						self.gameData[k + 1][j] = None

	def slideLeft(self):
		# Slide all data left
		for i in range(self.row):
			availSpace = False
			for j in range(self.col):
				# If this is the first open spot
				if not availSpace and self.gameData[i][j] == None:
					openCol = j
					availSpace = True
				elif availSpace and self.gameData[i][j] != None:
					self.gameData[i][openCol] = self.gameData[i][j]
					self.gameData[i][j] = None
					openCol += 1

		# Add like numbers together
		for i in range(self.row):
			for j in range(self.col - 1):
				# If the current and next number are the same
				if self.gameData[i][j] == self.gameData[i][j + 1] and self.gameData[i][j] != None:
					self.gameData[i][j] *= 2
					self.gameData[i][j + 1] = None

					# Shift the numbers left
					for k in range(j + 1, self.col - 1):
						self.gameData[i][k] = self.gameData[i][k + 1]
						self.gameData[i][k + 1] = None

	def slideDown(self):
		# Slide all data down
		for j in range(self.col):
			availSpace = False
			for i in range(self.row - 1, -1, -1):
				# If this is the first open spot
				if not availSpace and self.gameData[i][j] == None:
					openRow = i
					availSpace = True
				elif availSpace and self.gameData[i][j] != None:
					self.gameData[openRow][j] = self.gameData[i][j]
					self.gameData[i][j] = None
					openRow -= 1

		# Add like numbers together
		for j in range(self.col):
			for i in range(self.row - 1, 0, -1):
				# If the current and the next number are the same
				if self.gameData[i][j] == self.gameData[i - 1][j] and self.gameData[i][j] != None:
					self.gameData[i][j] *= 2
					self.gameData[i - 1][j] = None

					# Shift the numbers down
					for k in range(i - 1, 0, -1):
						self.gameData[k][j] = self.gameData[k - 1][j]
						self.gameData[k - 1][j] = None

	def slideRight(self):
		# Slide all data right
		for i in range(self.row):
			availSpace = False
			for j in range(self.col - 1, -1, -1):
				# If this is the first open spot
				if not availSpace and self.gameData[i][j] == None:
					openCol = j
					availSpace = True
				elif availSpace and self.gameData[i][j] != None:
					self.gameData[i][openCol] = self.gameData[i][j]
					self.gameData[i][j] = None
					openCol -= 1

		# Add like numbers together
		for i in range(self.row):
			for j in range(self.col - 1, 0, -1):
				# If the current and next number are the same
				if self.gameData[i][j] == self.gameData[i][j -1] and self.gameData[i][j] != None:
					self.gameData[i][j] *= 2
					self.gameData[i][j -1] = None

					# Shift the numbers right
					for k in range(j - 1, 0, -1):
						self.gameData[i][k] = self.gameData[i][k - 1]
						self.gameData[i][k - 1] = None
	
	def checkData(self, i, j, pv, nbn, sn):
		data = self.gameData[i][j]
		
		if data == None:
			pv = None
		elif pv == None:
			nbn = True
			pv = data
		elif data == pv:
			sn = True
		else:
			pv = data

		return pv, nbn, sn

	def checkValid(self, choice):
		valid = False

		noneBeforeNum = False
		sameNum = False

		if choice == 'w':
			for j in range(self.col):
				prevVal = 1
				for i in range(self.row):
					prevVal, noneBeforeNum, sameNum = self.checkData(i, j, prevVal, noneBeforeNum, sameNum)

				if noneBeforeNum or sameNum:
					valid = True
					break
		elif choice == 'a':
			for i in range(self.row):
				prevVal = 1
				for j in range(self.col):
					prevVal, noneBeforeNum, sameNum = self.checkData(i, j, prevVal, noneBeforeNum, sameNum)

				if noneBeforeNum or sameNum:
					valid = True
					break
		elif choice == 's':
			for j in range(self.col):
				prevVal = 1
				for i in range(self.row - 1, -1, -1):
					prevVal, noneBeforeNum, sameNum = self.checkData(i, j, prevVal, noneBeforeNum, sameNum)

				if noneBeforeNum or sameNum:
					valid = True
					break
		elif choice == 'd':
			for i in range(self.row):
				prevVal = 1
				for j in range(self.col - 1, -1, -1):
					prevVal, noneBeforeNum, sameNum = self.checkData(i, j, prevVal, noneBeforeNum, sameNum)

				if noneBeforeNum or sameNum:
					valid = True
					break

	def makeMove(self):
		valid = False

		while not valid:
			choice = input("Slide Direction: ")

			if self.checkValid(choice.lower()):
				valid = True

				if choice.lower() == 'w':
					self.slideUp()
				elif choice.lower() == 'a':
					self.slideLeft()
				elif choice.lower() == 's':
					self.slideDown()
				elif choice.lower() == 'd':
					self.slideRight()

	def checkContinue(self):
		movePossible = False

		for i in range(self.row):
			for j in range(self.col - 1):
				if self.gameData[i][j] == self.gameData[i][j + 1]:
					movePossible = True
					break
				if i != self.row - 1:
					if self.gameData[i][j] == self.gameData[i + 1][j]:
						movePossible = True
						break
			if movePossible:
				break

		if not movePossible:
			self.gameOver = True
# ---------------------------------------------------- #

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

	if not pygame.mixer.music.get_busy():
		pygame.mixer.music.play(-1, 5)

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

# -------------------- Updated item -------------------- #
def gameLoop():
	if pygame.mixer.music.get_busy():
		pygame.mixer.music.stop()

	bgm = pygame.mixer.music.load("C:/Users/Nikki Wang/Music/OK/Tobu - Infectious.mp3")
	pygame.mixer.music.play(-1)

	gameExit = False

	while not gameExit:
		for event in pygame.event.get():
			if event.type == pygame.QUIT:
				pygame.quit()
				quit()

		gameDisplay.fill(white)

		# Title
		largeText = pygame.font.SysFont("goudystout", 115)
		TitleSurf, TitleRect = textObjects("2048", largeText, black)
		TitleRect.center = ((display_width/2), 50)
		gameDisplay.blit(TitleSurf, TitleRect)

		# Grid box
		pygame.draw.rect(gameDisplay, black, ((display_width/2) - 200, (display_height/2) - 200, 400, 400), 3)
		pygame.draw.rect(gameDisplay, black, ((display_width/2) - 200, (display_height/2) - 200, 100, 400), 3)
		pygame.draw.rect(gameDisplay, black, ((display_width/2), (display_height/2) - 200, 100, 400), 3)
		pygame.draw.rect(gameDisplay, black, ((display_width/2) - 200, (display_height/2) - 200, 400, 100), 3)
		pygame.draw.rect(gameDisplay, black, ((display_width/2) - 200, (display_height/2), 400, 100), 3)

		pygame.display.update()
		clock.tick(60)

# ------------------------------------------------------ #

gameIntro()
gameLoop()
pygame.quit()
quit()