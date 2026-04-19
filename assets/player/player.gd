extends CharacterBody3D

@onready var spawn_transform = transform
const SPEED = 4.0
const JUMP_VELOCITY = 1.7

var achievments = {
	"Finish the maze" : false,
	"Find the apple" : false,
	"Find the box" : false,
	"Find the circle" : false,
	"Find the dime" : false,
	"Fall into the void" : false,
	"Finish the maze in 40 seconds" : false,
}
var bonus_achievs = {
	"Find the egg" : false,
	"Finish the bonus maze in 40 seconds" : false,
}
var misc_data = {
	"b2_secret_exit" : false,
	"has_died" : false
}

var player_data = {
	"inventory" : [],
	"achievments" : achievments,
	"bonus_achievs" : bonus_achievs,
	"misc_data" : misc_data
	
}
var pdialboxopen = false

const MOUSE_SENSITIVITY = 0.005

var gravity = 9.8

######### exit
func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()
#####################@@@@@@@@@@@@@@###connect other stuff and camera
@onready var neck = $neck
@onready var camera = $neck/camera
#capture mouse if button clicked and rotate neck
func _unhandled_input(event: InputEvent):
	#if event is InputEventMouseButton:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("exit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:
		#if pdialboxopen == false:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			neck.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
			camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
			##stop from breaking neck
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
#################@@@@@@@@@@@@$$$$$$$$$#######################

func _process(_delta: float) -> void:
	if position.y < -20:
		player_data["achievments"]["Fall into the void"] = true
		death()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("fake", "fake", "fake", "fake")
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		#velocity.x = move_toward(velocity.x, 0, SPEED/10)
		#velocity.z = move_toward(velocity.z, 0, SPEED/10)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func death():
	reset_position()

func _on_dialoguebox_dialboxstatus(dialboxopen):
	pdialboxopen = dialboxopen


func reset_position():
	global_transform = spawn_transform
	neck.rotation_degrees.y = 0.0
