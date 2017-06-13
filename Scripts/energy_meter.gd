
extends Node2D

var energyBar
var energyBars = []
var MAX_ENERGY = 12
var energyCount = MAX_ENERGY
var offset = 0
var recoverTimer = 0
var maxRecoverTimer = 0.5

func _ready():
	energyBar = find_node("Sprite")
	var startX = energyBar.get_pos().x
	var startY = energyBar.get_pos().y
	var w = energyBar.get_texture().get_width()
	for i in range(MAX_ENERGY):
		energyBars.append(energyBar.duplicate())
		energyBars[i].show()
		energyBars[i].set_pos(Vector2(startX + i * (2 * w + offset), startY))
		add_child(energyBars[i])
	#set_process(true)

func _process(delta):
	if(energyCount < MAX_ENERGY):
		recoverTimer += delta
		if(recoverTimer > maxRecoverTimer):
			recoverTimer = 0
			energyCount += 1
			updateEnergyDisplay()

func getEnergyCount():
	return energyCount

func regenerate(amount):
	energyCount += amount
	updateEnergyDisplay()

func resetRecoverTimer():
	recoverTimer = 0

func useEnergy(amount):
	energyCount -= amount
	if(energyCount < 0):
		energyCount = 0
	updateEnergyDisplay()

func updateEnergyDisplay():
	#Update energy meter display
	for i in range(0, energyCount):
		energyBars[i].show()
	for i in range(energyCount, MAX_ENERGY):
		energyBars[i].hide()