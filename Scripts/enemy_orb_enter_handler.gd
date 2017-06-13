
extends Area2D

var canPlaySound = true

func _ready():
	pass

func disableHandler():
	canPlaySound = false

func _on_Area2D_body_exit( body ):
	if(canPlaySound):
		if(self.get_instance_ID() != body.get_instance_ID()):
			if(body.is_in_group("normalOrbs") or body.is_in_group("enemyOrbs")):
				get_node("/root/sound_effects").play("orb_hits_orb")
			elif(body.is_in_group("enemies")):
				if(body.isShieldsUp()):
					#get_node("/root/sound_effects").play("deflect")
					pass

func _on_Area2D_body_enter( body ):
	if(canPlaySound):
		if(self.get_instance_ID() != body.get_instance_ID()):
			if(body.is_in_group("walls")):
				get_node("/root/sound_effects").play("wall_hit")