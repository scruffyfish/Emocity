class_name Playerstatecrouch extends Playerstate

@export var	jiansu_rate : float = 10

func	 init() -> void:
	
	pass
	
func enter() -> void:
	player.collisionstand.disabled = true
	player.collisioncrouch.disabled = false
	player.sprite_2d.scale.y = 0.625
	player.sprite_2d.position.y = -15
	pass

func exit() -> void:
	player.collisionstand.disabled = false
	player.collisioncrouch.disabled = true
	player.sprite_2d.scale.y = 1
	player.sprite_2d.position.y = -24
	#player.position.y += 4 #摁蹲直接下跳下面那个是摁住蹲在跳再下跳
	pass

func	  handled_input(_event : InputEvent) -> Playerstate:
	if _event.is_action_pressed("jump"):
		if player.oneway_ray_cast_2d.is_colliding() == true:
			player.position.y += 4
			return fall
		return jump
	return next_state
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> Playerstate:
	if player.direction.y <= 0:
		return idle
	
	return next_state

func physics_process(delta: float) -> Playerstate:
	player.velocity.x -= player.velocity.x * jiansu_rate * delta
	if player.is_on_floor() == false:
		return fall
	return next_state
