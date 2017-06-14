
extends Node2D

var level1 = load("res://Scenes/level_1.tscn")
var level2 = load("res://Scenes/level_2.tscn")
var level3 = load("res://Scenes/level_3.tscn")

var enemiesLeft
var currentLevel

func _ready():
	#print("level controls ready")
	currentLevel = get_node("/root/globals").getCurrentLevel()
	if(currentLevel == 1):
		var newLevel = level1.instance()
		add_child(newLevel)
		move_child(newLevel, 5)
	elif(currentLevel == 2):
		var newLevel = level2.instance()
		add_child(newLevel)
		move_child(newLevel, 5)
	elif(currentLevel == 3):
		var newLevel = level3.instance()
		add_child(newLevel)
		move_child(newLevel, 5)
	set_process(true)

func _process(delta):
	enemiesLeft = get_tree().get_nodes_in_group("enemies").size()
	if(enemiesLeft <= 0):
		nextLevel()

func nextLevel():
	if(currentLevel == 1):
		get_node("/root/globals").setCurrentLevel(2)
		get_tree().reload_current_scene()
	elif(currentLevel == 2):
		get_node("/root/globals").setCurrentLevel(3)
		get_tree().reload_current_scene()
	elif(currentLevel == 3):
		#print("You won!")
		get_node("/root/globals").setCurrentLevel(1)
		#Prevent orbs from making sounds
		for normalOrb in get_tree().get_nodes_in_group("normalOrbs"):
			normalOrb.find_node("Area2D").disableHandler()
		for enemyOrb in get_tree().get_nodes_in_group("enemyOrbs"):
			enemyOrb.find_node("Area2D").disableHandler()
		var gameWinMenu = get_tree().get_root().get_node("Game").find_node("GameWinMenu")
		gameWinMenu.toggle()
		get_tree().set_pause(true)