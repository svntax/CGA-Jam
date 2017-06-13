
extends KinematicBody2D

var pathFollow
var MOVE_SPEED = 0.8

var shieldsUp = true

var shotTimer = 0
var maxShotTimerList = [2, 3, 4, 5]
var currentShotTimer
var shotOffsetY = 8
var SHOT_MAGNITUDE = 240

var enemyProjectileScene = load("res://Scenes/enemy_projectile.tscn")

func _ready():
	randomizeTimer()
	pathFollow = get_parent()
	if(pathFollow == null):
		print("Error: enemy could not find parent PathFollow2D node")
	set_fixed_process(true)

func randomizeTimer():
	currentShotTimer = maxShotTimerList[(randi() % maxShotTimerList.size())]

func isShieldsUp():
	return shieldsUp

func _fixed_process(delta):
	if(shieldsUp):
		var enemyOrbsLeft = get_tree().get_nodes_in_group("enemyOrbs").size()
		if(enemyOrbsLeft <= 0):
			shieldsUp = false
			var shield1 = find_node("Shield1")
			shield1.set_emitting(false)
			shield1.hide()
			shield1.queue_free()
			var shield2 = find_node("Shield2")
			shield2.set_emitting(false)
			shield2.hide()
			shield2.queue_free()

	pathFollow.set_offset(get_parent().get_offset() + MOVE_SPEED)

	shotTimer += delta
	if(shotTimer > currentShotTimer):
		shotTimer = 0
		var projectile = enemyProjectileScene.instance()
		var h = find_node("Sprite").get_texture().get_height()
		var spawnPos = self.get_global_pos() + Vector2(0, h*2 + shotOffsetY)
		get_parent().get_parent().add_child(projectile)
		projectile.set_global_pos(spawnPos)
		projectile.apply_impulse(Vector2(), Vector2(0, SHOT_MAGNITUDE))
		randomizeTimer()

func _on_Area2D_body_exit( body ):
	var enemyOrbsLeft = get_tree().get_nodes_in_group("enemyOrbs").size()
	if(enemyOrbsLeft <= 0 and body.is_in_group("normalOrbs")):
		#TODO increase score?
		get_node("/root/sound_effects").play("enemy_destroyed")
		self.queue_free()
