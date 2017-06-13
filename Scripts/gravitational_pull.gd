
extends RigidBody2D

var G_CONSTANT = .3674

func _ready():
	var player = get_tree().get_nodes_in_group("players")[0]
	add_collision_exception_with(player)
	set_fixed_process(true)

func _fixed_process(delta):
    calcNetForce()

func _integrate_forces(state):
    pass

func gravityEquation(G, m1, m2, r):
	return (G * m1 * m2) / (r * r)

func calcNetForce():
	var rigidbodies = get_tree().get_nodes_in_group("rigidbodies")
	var m1 = self.get_mass()
	var netForce = Vector2()
	for body in rigidbodies:
		if body == self or get_mode() != MODE_RIGID:
			pass
		else:
			var r = body.get_global_pos().distance_to(self.get_global_pos())
			var m2 = body.get_mass()
			var magnitude = G_CONSTANT * (m1 * m2) / (1 + r)
			var F = (body.get_global_pos() - self.get_global_pos()).normalized() * magnitude
			netForce += F
		#netForce += (body.get_pos() - self.get_pos()).normalized() * G_CONSTANT
	#NOTE: WILL NOT WORK IF MODE IS "Character" (when it can't rotate)
	self.apply_impulse(Vector2(), netForce)