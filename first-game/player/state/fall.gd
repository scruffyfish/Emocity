class_name Playerstatefall extends Playerstate

func	 init() -> void:
	
	pass
	
func enter() -> void:
	
	pass

func exit() -> void:
	
	pass

func	  handled_input(_event : InputEvent) -> Playerstate:
	
	return next_state
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> Playerstate:
	if player.direction.x != 0:
		return run
	return next_state

func physics_process(delta: float) -> Playerstate:
	player.velocity.x = 0
	return next_state
