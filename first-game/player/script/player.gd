class_name  Player extends CharacterBody2D

@export var move_speed : float = 150
@export var max_fall_vecolity = 600

const DEBUG_JUMP = preload("uid://ds07lqp6ctdo0")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collisionstand: CollisionShape2D = $Collisionstand
@onready var collisioncrouch: CollisionShape2D = $Collisioncrouch
@onready var oneway_ray_cast_2d: RayCast2D = $onewayRayCast2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#region /// state 
var states : Array[Playerstate]
var current_state : Playerstate : 
	get : return states.front()
var previous_state : Playerstate:
	get : return states[1]
#endregion
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var gravity_mulitplier : float = 1.0

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
	velocity.y += gravity * delta * gravity_mulitplier
	velocity.y = clampf(velocity.y, -2000, max_fall_vecolity)
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
	var x_axis = Input.get_axis("left","right")
	var y_axis = Input.get_axis("up","down")
	direction = Vector2(x_axis,y_axis)
	if prev_direction.x != direction.x:
		if direction.x < 0:
			sprite_2d.flip_h = true
		elif direction.x > 0:
			sprite_2d.flip_h = false
	pass
	
func add_debug(color : Color = Color.RED) -> void:
	var d : Node2D = DEBUG_JUMP.instantiate()
	get_tree().root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer(3).timeout
	d.queue_free()
	pass
