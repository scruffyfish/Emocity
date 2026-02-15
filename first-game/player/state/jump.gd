class_name Playerstatejump extends Playerstate

@export var jump_velocity : float = 450.0

func	 init() -> void:
	
	pass
	
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	player.add_debug(Color.GREEN)
	player.velocity.y = -jump_velocity
	pass

func exit() -> void:
	player.add_debug(Color.YELLOW)
	pass

func	  handled_input(event : InputEvent) -> Playerstate:
	if event.is_action_released("jump"):
		player.velocity.y *= 0.535
		return fall
	return next_state
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> Playerstate:
	set_jump_farme()
	return next_state

func physics_process(delta: float) -> Playerstate:
	if player.is_on_floor():
		return idle
	if player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state

func set_jump_farme() -> void:
	var farme : float = remap(player.velocity.y,-jump_velocity,0.0,0.0,0.5)
	player.animation_player.seek(farme,true)
	pass
