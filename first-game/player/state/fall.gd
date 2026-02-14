class_name Playerstatefall extends Playerstate

@export var fall_gravity_mulitplier : float = 1.175
@export var coytoe_time : float = 0.3
@export var jump_buffer_time : float = 0.2
var coytoe_timer : float = 0
var buffer_timer : float = 0

func	 init() -> void:
	
	pass
	
func enter() -> void:
	player.animation_player.play("fall")
	player.gravity_mulitplier = fall_gravity_mulitplier
	if player.previous_state == jump:
		coytoe_timer = 0
	else:
		coytoe_timer = coytoe_time
	pass

func exit() -> void:
	player.gravity_mulitplier = 1.0
	pass
  
func	  handled_input(_event : InputEvent) -> Playerstate:
	if _event.is_action_pressed("jump"):
		if coytoe_timer > 0:
			return jump
		else:
			buffer_timer = jump_buffer_time
	return next_state
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> Playerstate:
	coytoe_timer -= delta
	buffer_timer -= delta
	return next_state

func physics_process(delta: float) -> Playerstate:
	if player.is_on_floor():
		player.add_debug(Color.RED)
		if buffer_timer >0:
			return jump
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
