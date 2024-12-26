extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


@onready var stair_checker : ShapeCast3D = $StairChecker
@onready var floor_checker : RayCast3D = $FloorChecker

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	var forced_y_position : float = 0
	var stair_lerp_rate : float = 12.0

	var whatever = false

	for i in stair_checker.collision_result:
		var distance_to_y_point = Vector3(0,global_position.y, 0).distance_to(Vector3(0,i.point.y,0))
		if distance_to_y_point < .6 and input_dir != Vector2.ZERO:
			if is_heading_toward(i.point):
				forced_y_position = lerp(global_position.y, i.point.y, delta * stair_lerp_rate)
				if velocity.y < 0:
					velocity.y = 0
			elif floor_checker.get_collider():
				var point = floor_checker.get_collision_point()
				forced_y_position = lerp(global_position.y, point.y, delta * stair_lerp_rate)
				whatever = true

	if whatever:
		print(stair_checker.collision_result)

	move_and_slide()
	
	if forced_y_position != 0:
		global_position.y = forced_y_position

func is_heading_toward(dest : Vector3) -> bool:
	# Calculate the vector from object_a to object_b
	var direction_to_b = (dest - global_position).normalized()
	
	# Normalize the velocity vector
	var velocity_direction = velocity.normalized()
	
	# Check if the velocity points towards object_b
	return velocity_direction.dot(direction_to_b) > 0.0
