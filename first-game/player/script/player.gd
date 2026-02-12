class_name  Player extends CharacterBody2D

@export var move_speed : float = 150

#region /// state 
var states : Array[Playerstate]
var current_state : Playerstate : 
	get : return states.front()
var previous_state : Playerstate:
	get : return states[1]
#endregion
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980

func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handled_input(event))
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_states()
	pass # Replace with function body.

func  _process(delta: float) -> void:
	updata_direction()
	change_state(current_state.process(delta))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()
	change_state(current_state.physics_process(delta))
	pass
	
func init_states() -> void:
	states = []
	for c in $states.get_children():
		if c is Playerstate:
			states.append(c)
			c.player = self
			pass
			
	for state in states:
		state.init()
	
	change_state(current_state)
	current_state.enter()
	$Label.text = current_state.name
	pass
	
func change_state(new_state : Playerstate) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
		
	if current_state:
		current_state.exit()
	
	states.push_front(new_state)
	current_state.enter()
	states.resize(3)
	$Label.text = current_state.name
	pass
	
func updata_direction() -> void:
	var prev_direction : Vector2 = direction
	direction = Input.get_vector("left","right","up","down")
	pass
	
