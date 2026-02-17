@tool
class_name guankabianjie extends Node2D
@export_range(480,2048,32,"suffix:px") var width :int =480 : set = _on_width_change
@export_range(270,2048,32,"suffix:px") var hight :int =270 : set = _on_hight_change

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index=256
	if Engine.is_editor_hint():
		return
	var camera : Camera2D = null
	while not camera:
		await get_tree().process_frame
		camera = get_viewport().get_camera_2d()
	camera.limit_left = int(global_position.x)
	camera.limit_top = int(global_position.y)
	camera.limit_right = int(global_position.x) + width
	camera.limit_bottom = int(global_position.y) + hight
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _draw() -> void:
	if Engine.is_editor_hint():
		var r : Rect2 = Rect2(Vector2.ZERO,Vector2(width,hight))
		draw_rect(r,Color(0.0,0.45,1.0),false,3)
	pass
func _on_width_change(new_width : int) -> void:
	width = new_width
	queue_redraw()
	pass
func _on_hight_change(new_hight : int) -> void:
	hight = new_hight
	queue_redraw()
	pass
