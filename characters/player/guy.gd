extends CharacterBody3D


const SPEED = 1.0
const ROTATE_SPEED = 0.05

@onready var animation_tree: AnimationTree = $AnimationTree

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		#look_at(transform.origin + direction)
		animation_tree["parameters/StateMachine/conditions/is_moving"] = true
		animation_tree["parameters/StateMachine/conditions/idle"] = false
		velocity = transform.basis.z * SPEED * -input_dir[1]
		rotate_y(ROTATE_SPEED * -input_dir[0])
		
	else:
		animation_tree["parameters/StateMachine/conditions/is_moving"] = false
		animation_tree["parameters/StateMachine/conditions/idle"] = true
		velocity.z = move_toward(velocity.z, 0, SPEED)
		velocity = Vector3(0,0,0)

	move_and_slide()
