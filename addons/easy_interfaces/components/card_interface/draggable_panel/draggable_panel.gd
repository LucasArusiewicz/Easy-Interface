@tool
extends VBoxContainer

func _on_close_button_down() -> void:
	queue_free()
