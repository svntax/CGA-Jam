
extends Camera2D

var isShaking = false
var shakeTimer = 0
var duration = 2
var intensity = 1

func _ready():
	set_process(true)

func _process(delta):
	if(isShaking):
		shakeTimer += delta
		shakeCamera()
		if(shakeTimer > duration):
			shakeTimer = 0
			isShaking = false
			set_offset(Vector2(0, 0))

func startScreenShake(shakeLength, shakeIntensity):
	isShaking = true
	if(shakeLength <= 0):
		duration = 2
	else:
		duration = shakeLength
	if(shakeIntensity <= 0):
		shakeIntensity = 1
	else:
		intensity = shakeIntensity

func shakeCamera():
	set_offset(Vector2(rand_range(-1, 1) * intensity, rand_range(-1, 1) * intensity))