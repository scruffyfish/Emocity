class_name Playerstate extends Node

var player : Player
var next_state : Playerstate

#region /// state reference
@onready var run: Playerstaterun = %run
@onready var idle: Playerstateidle = %idle
@onready var jump: Playerstatejump = %jump
@onready var fall: Playerstatefall = %fall
#endregion

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
	
	return next_state

func physics_process(delta: float) -> Playerstate:
		return next_state
