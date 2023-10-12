@tool
extends PanelContainer

@export var parent_root : Control


@onready var new_position := position


const LERP_MOVEMENT := 15


var mouse_in_drag := false
var dragging := false
var draggingDistance := 0.0
var direction_drag : Vector2


func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in_drag:
			dragging = true
			
			var mouse_position = get_viewport().get_mouse_position()
			draggingDistance = parent_root.position.distance_to(mouse_position)
			direction_drag = (get_viewport().get_mouse_position() - parent_root.position).normalized()
			new_position = mouse_position - draggingDistance * direction_drag
		else:
			dragging = false

	elif event is InputEventMouseMotion:
		if dragging:
			new_position = get_viewport().get_mouse_position() - draggingDistance * direction_drag


func _physics_process(delta) -> void:
	if dragging:
		parent_root.position = lerp(parent_root.position, new_position, LERP_MOVEMENT * delta)


func _on_close_button_down() -> void:
	parent_root.queue_free()


func _on_move_mouse_entered() -> void:
	mouse_in_drag = true


func _on_move_mouse_exited() -> void:
	mouse_in_drag = false
