
extends Sprite

func _ready():
	set_process_input(true)

func _input(event):
	if(event.type == InputEvent.MOUSE_MOTION):
		self.set_global_pos(event.pos)
