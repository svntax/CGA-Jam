
extends Node

var currentLevel = 1

func _ready():
	pass

func getCurrentLevel():
	return currentLevel

func setCurrentLevel(level):
	currentLevel = level

func resetLevel():
	currentLevel = 1