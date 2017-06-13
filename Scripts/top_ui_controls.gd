
extends Control

var indicator

func _ready():
	indicator = find_node("Indicator")
	set_process(true)

func _process(delta):
	var orbCount = get_tree().get_nodes_in_group("enemyOrbs").size()
	if(orbCount > 0):
		setOrbCount(orbCount)
	else:
		displayShieldsNotice()

func setOrbCount(count):
	if(count != 1):
		indicator.set_text(str(count) + " ORBS LEFT")
	else:
		indicator.set_text(str(count) + " ORB LEFT")

func displayShieldsNotice():
	indicator.set_text("ENEMY SHIELDS DOWN!")