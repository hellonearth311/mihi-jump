extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -800.0
const LAUNCH_FORCE = -1500.0	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_kill_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().reload_current_scene()


func _on_jump_pad_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.velocity.y = LAUNCH_FORCE


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$"../CanvasLayer/VBoxContainer".visible = true
