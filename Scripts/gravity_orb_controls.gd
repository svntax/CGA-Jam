
extends RigidBody2D

var player
var lifetimer = 0
var maxLifetime = 3

func _ready():
	player = get_tree().get_nodes_in_group("players")[0]
	set_fixed_process(true)

func _fixed_process(delta):
	if(lifetimer < maxLifetime):
		lifetimer += delta
	if(lifetimer > maxLifetime):
		player.regenGravityEnergy()
		self.queue_free()