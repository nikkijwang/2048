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

# ---------- Added Items ---------- #
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
c2048 = bright_blue
# --------------------------------- #

gameDisplay = pygame.display.set_mode((display_width, display_height))
pygame.display.set_caption("2048")
clock = pygame.time.Clock()

class game_2048:
	def __init__(self, row, col):
		self.row = row
		self.col = col
		self.gameData = np.full([row, col], None)
		self.gameOver = False
		self.tilesize = 100
		self.margin = 1
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

		self.drawBoard()

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
		# print("enters checkValid")
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

		# print("exit checkValid")
		return valid

	# -------------------- Modified Items -------------------- #
	def makeMove(self, choice):
		valid = False
		#print("Enter makeMove")
		if self.checkValid(choice):
			if choice == 'w':
				self.slideUp()
			elif choice == 'a':
				self.slideLeft()
			elif choice == 's':
				self.slideDown()
			elif choice == 'd':
				self.slideRight()

			self.genNewBlk()
			self.checkContinue()
		# while not valid and not self.gameOver:
		# 	# choice = input("Slide Direction: ")

		# 	if self.checkValid(choice):
		# 		valid = True

		# 		if choice == 'w':
		# 			self.slideUp()
		# 		elif choice == 'a':
		# 			self.slideLeft()
		# 		elif choice == 's':
		# 			self.slideDown()
		# 		elif choice == 'd':
		# 			self.slideRight()

		# 		self.genNewBlk()
		# 		self.checkContinue()
		#print("exit makeMove")

	def checkContinue(self):
		movePossible = False

		for i in range(self.row):
			for j in range(self.col - 1):
				# if self.gameData[i][j] is not None:
				# 	print("gameData[%d][%d] = %d" % (i, j, self.gameData[i][j]))
				# else:
				# 	print("gameData[%d][%d] = %s" % (i, j, self.gameData[i][j]))
				# if self.gameData[i][j + 1] is not None:
				# 	print("gameData[%d][%d] = %d" % (i, j + 1, self.gameData[i][j + 1]))
				# else:
				# 	print("gameData[%d][%d] = %s" % (i, j + 1, self.gameData[i][j + 1]))
				# if i != self.row - 1 and self.gameData[i + 1][j] is not None:
				# 	print("gameData[%d][%d] = %d" % (i + 1, j, self.gameData[i + 1][j]))
				# elif i != self.row - 1:
				# 	print("gameData[%d][%d] = %s" % (i + 1, j, self.gameData[i + 1][j]))

				if self.gameData[i][j] == self.gameData[i][j + 1] or self.gameData[i][j] == None or self.gameData[i][j + 1] == None:
					movePossible = True
					break


				if i != self.row - 1:
					if self.gameData[i][j] == self.gameData[i + 1][j] or self.gameData[i + 1][j] == None:
						movePossible = True
						break
			if movePossible:
				break

		# print(str(movePossible))
		if not movePossible:
			self.gameOver = True
	
	# ---------------- Added Items -------------------- #
	def drawGrid(self):
		pygame.draw.rect(gameDisplay, black, ((display_width/2) - (self.tilesize * 2), (display_height/2) - (self.tilesize * 2), self.tilesize * self.col, self.tilesize * self.row), 3)
		pygame.draw.rect(gameDisplay, black, ((display_width/2) - (self.tilesize * 2), (display_height/2) - (self.tilesize * 2), self.tilesize * 4, self.tilesize), 3)
		pygame.draw.rect(gameDisplay, black, ((display_width/2) - (self.tilesize * 2), (display_height/2), self.tilesize * 4, self.tilesize), 3)
		pygame.draw.rect(gameDisplay, black, ((display_width/2) - (self.tilesize * 2), (display_height/2) - (self.tilesize * 2), self.tilesize, self.tilesize * 4), 3)
		pygame.draw.rect(gameDisplay, black, ((display_width/2), (display_height/2) - (self.tilesize * 2), self.tilesize, self.tilesize * 4), 3)

	def pickColor(self, data):
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

	def drawBoard(self):
		gameDisplay.fill(white)
		drawGameTitle()
		self.drawGrid()
		for i in range(self.row):
			for j in range(self.col):
				x = (display_width / 2) + ((j - 2) * self.tilesize) + self.margin
				y = (display_height / 2) + ((i - 2) * self.tilesize) + self.margin
				data = self.gameData[i][j]

				if data is not None:
					text = data
				else:
					text = ' '

				font = pygame.font.SysFont("impact", 20)
				color = self.pickColor(data)
				if data is not None:
					pygame.draw.rect(gameDisplay, color, (x, y, self.tilesize - self.margin, self.tilesize - self.margin))
				else:
					pygame.draw.rect(gameDisplay, color, (x, y, self.tilesize, self.tilesize), self.margin)
				tileSurf, tileRect = textObjects(str(text), font, black)
				tileRect.center = (x + (self.tilesize / 2), y + (self.tilesize / 2))
				gameDisplay.blit(tileSurf, tileRect)

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

# -------------------- Added Item -------------------- #
def drawGameTitle():
	largeText = pygame.font.SysFont("goudystout", 115)
	TitleSurf, TitleRect = textObjects("2048", largeText, black)
	TitleRect.center = ((display_width/2), 50)
	gameDisplay.blit(TitleSurf, TitleRect)

# -------------------- Updated item -------------------- #
def gameLoop():
	if pygame.mixer.music.get_busy():
		pygame.mixer.music.stop()

	bgm = pygame.mixer.music.load("C:/Users/Nikki Wang/Music/OK/Tobu - Infectious.mp3")
	pygame.mixer.music.play(-1)

	gameExit = False
	
	row = 4
	col = 4
	game = game_2048(row, col)

	while not gameExit and not game.gameOver:
		for event in pygame.event.get():
			if event.type == pygame.QUIT:
				pygame.quit()
				quit()

			if event.type == pygame.KEYUP:
				# print(event)
				if event.key == pygame.K_w or event.key == pygame.K_UP:
					game.makeMove('w')
				elif event.key == pygame.K_a or event.key == pygame.K_LEFT:
					game.makeMove('a')
				elif event.key == pygame.K_s or event.key == pygame.K_DOWN:
					game.makeMove('s')
				elif event.key == pygame.K_d or event.key == pygame.K_RIGHT:
					game.makeMove('d')

		pygame.display.update()
		clock.tick(60)

	if game.gameOver:
		gameOver(game)

# -------------------- Added Item -------------------- #
def gameOver(game):
	gameover = True

	if pygame.mixer.music.get_busy():
		pygame.mixer.music.stop()

	end_bgm = pygame.mixer.music.load("C:/Users/Nikki Wang/Music/OK/Wiz Khalifa - See You Again (ft. Charlie Puth).mp3")
	pygame.mixer.music.play(-1, 10)

	while gameover:
		for event in pygame.event.get():
			if event.type == pygame.QUIT:
				pygame.quit()
				quit()

		game.drawBoard()
		largeText = pygame.font.SysFont("vinerhanditc", 115)
		textSurf, textRect = textObjects("GAMEOVER", largeText, bright_red)
		textRect.center = ((display_width/2), (display_height/2))
		gameDisplay.blit(textSurf, textRect)

		button("Play Again", 150, 450, 100, 50, green, bright_green, gameLoop)
		button("Quit", 550, 450, 100, 50, red, bright_red, quitgame)

		pygame.display.update()
		clock.tick(15)

# ------------------------------------------------------ #

gameIntro()
gameLoop()
pygame.quit()
quit()