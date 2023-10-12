@tool
extends HBoxContainer

func _on_remove_button_down() -> void:
	queue_free()
