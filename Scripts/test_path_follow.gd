
extends Sprite

func _ready():
   set_process(true)

func _process(delta):
   get_parent().set_offset(get_parent().get_offset() + 1)
