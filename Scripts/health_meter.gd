
extends Node2D

var healthBar
var healthBars = []
var MAX_HEALTH = 5
var health = MAX_HEALTH
var offset = 2

func _ready():
	healthBar = find_node("Sprite")
	var startX = healthBar.get_pos().x
	var startY = healthBar.get_pos().y
	var w = healthBar.get_texture().get_width()
	for i in range(MAX_HEALTH):
		healthBars.append(healthBar.duplicate())
		healthBars[i].show()
		healthBars[i].set_pos(Vector2(startX + i * (2 * w + offset), startY))
		add_child(healthBars[i])

func getHealth():
	return health

func dealDamage():
	health -= 1
	if(health <= 0):
		health = 0
		updateHealthDisplay()
		#Game over
		get_node("/root/sound_effects").play("player_destroyed")
		#prevent orbs from making sounds
		for normalOrb in get_tree().get_nodes_in_group("normalOrbs"):
			normalOrb.find_node("Area2D").disableHandler()
		for enemyOrb in get_tree().get_nodes_in_group("enemyOrbs"):
			enemyOrb.find_node("Area2D").disableHandler()
		var gameOverMenu = get_tree().get_root().get_node("Game").find_node("GameOverMenu")
		gameOverMenu.toggle()
		get_tree().set_pause(true)
	updateHealthDisplay()

func updateHealthDisplay():
	#Update health meter display
	for i in range(0, health):
		healthBars[i].show()
	for i in range(health, MAX_HEALTH):
		healthBars[i].hide()