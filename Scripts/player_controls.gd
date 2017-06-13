
extends KinematicBody2D

var energyMeter
var healthMeter
var ORB_COST = 1
var GRAVITY_ORB_COST = 2

var MOVE_SPEED = 2
var shotMagnitude = 512
var gravityShotMagnitude = 256
var shotOffset = Vector2(0, -20)

var normalOrbScene = load("res://Scenes/normal_orb.tscn")
var gravityOrbScene = load("res://Scenes/gravity_orb.tscn")

func _ready():
	var musicHandler = get_node("/root/music_handler")
	if(!musicHandler.is_playing()):
		musicHandler.play()

	energyMeter = get_parent().find_node("EnergyMeter")
	healthMeter = get_parent().find_node("HealthMeter")
	if(energyMeter == null):
		print("Error: player could not find energy meter node")
	if(healthMeter == null):
		print("Error: player could not find health meter node")
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == BUTTON_LEFT && event.pressed):
			if(energyMeter.getEnergyCount() >= ORB_COST):
				shootOrb(event.pos)
		if(event.button_index == BUTTON_RIGHT && event.pressed):
			if(energyMeter.getEnergyCount() >= GRAVITY_ORB_COST):
				shootGravityOrb(event.pos)

func _fixed_process(delta):
	if(Input.is_action_pressed("UI_PAUSE")):
		if(!get_tree().is_paused()):
			var pauseMenu = get_parent().find_node("PauseMenuPopup")
			pauseMenu.toggle()
			get_tree().set_pause(true)

	var velX = 0
	if(Input.is_action_pressed("LEFT")):
		velX -= MOVE_SPEED
		if(velX < -MOVE_SPEED):
			velX = -MOVE_SPEED
	if(Input.is_action_pressed("RIGHT")):
		velX += MOVE_SPEED
		if(velX > MOVE_SPEED):
			velX = MOVE_SPEED
	self.move(Vector2(velX, 0))
	"""
	if(is_colliding()):
		#print("Is colliding")
		var other = get_collider()
		#Damaged if hit by enemy projectile
		if(other.get_name() == "EnemyProjectile"):
			other.queue_free()
			healthMeter.dealDamage()
	"""

func damage():
	get_node("/root/sound_effects").play("player_hit")
	get_parent().find_node("Camera2D").startScreenShake(0.5, 4)
	healthMeter.dealDamage()

func regenEnergy():
	energyMeter.regenerate(ORB_COST)

func regenGravityEnergy():
	energyMeter.regenerate(GRAVITY_ORB_COST)

func shootOrb(targetPos):
	get_node("/root/sound_effects").play("shoot01")
	var dir = (get_global_mouse_pos() - self.get_global_pos()).normalized()
	var normalOrb = normalOrbScene.instance()
	normalOrb.set_pos(self.get_global_pos() + shotOffset)
	normalOrb.apply_impulse(Vector2(), dir * shotMagnitude)
	get_parent().add_child(normalOrb)
	energyMeter.useEnergy(ORB_COST)
	energyMeter.resetRecoverTimer()

func shootGravityOrb(targetPos):
	get_node("/root/sound_effects").play("shoot02")
	var dir = (get_global_mouse_pos() - self.get_global_pos()).normalized()
	var gravityOrb = gravityOrbScene.instance()
	gravityOrb.set_pos(self.get_global_pos() + shotOffset)
	gravityOrb.apply_impulse(Vector2(), dir * gravityShotMagnitude)
	get_parent().add_child(gravityOrb)
	energyMeter.useEnergy(GRAVITY_ORB_COST)
	energyMeter.resetRecoverTimer()