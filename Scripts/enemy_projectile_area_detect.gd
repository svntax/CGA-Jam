
extends Area2D

var player

func _ready():
	#Enemy projectiles should not collide with enemy-related objects
	#Nodes in enemyObjects group MUST be PhysicsBody2D nodes
	for enemyObject in get_tree().get_nodes_in_group("enemyObjects"):
		get_parent().add_collision_exception_with(enemyObject)
	player = get_tree().get_nodes_in_group("players")[0]

func _on_Area2D_body_enter( body ):
	if(body.get_instance_ID() == player.get_instance_ID()):
		body.damage()
	if(!body.is_in_group("enemyObjects")):
		if(body.is_in_group("normalOrbs")):
			get_node("/root/sound_effects").play("projectile_hit")
		get_parent().queue_free()
