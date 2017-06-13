
extends Area2D

var player

func _ready():
	player = get_tree().get_nodes_in_group("players")[0]
	set_fixed_process(true)

func _fixed_process(delta):
	if(self.get_overlapping_bodies().size() > 0):
		for body in self.get_overlapping_bodies():
			if(body.is_in_group("normalOrbs") or body.is_in_group("enemyProjectiles") or body.is_in_group("enemyOrbs")):
				if(body.is_in_group("normalOrbs")):
					player.regenEnergy()
				if(body.is_in_group("normalOrbs") or body.is_in_group("enemyOrbs")):
					body.find_node("Area2D").disableHandler()
				get_node("/root/sound_effects").play("blackhole_absorb")
				body.queue_free()