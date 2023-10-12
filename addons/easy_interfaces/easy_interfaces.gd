@tool
extends EditorPlugin

var main_panel_scene = preload("res://addons/easy_interfaces/components/inspector/main_panel.tscn")
var main_panel_instance: VBoxContainer

func _enter_tree() -> void:
	main_panel_instance = main_panel_scene.instantiate()
	get_editor_interface().get_editor_main_screen().add_child(main_panel_instance)
	main_panel_instance.load_data()
	main_panel_instance.run_validation()
	_make_visible(false)


func _has_main_screen() -> bool:
	return true
	
func _make_visible(visible: bool):
	if main_panel_instance:
		main_panel_instance.visible = visible
	
func _get_plugin_name() -> String:
	return "Easy Interfaces"
	
func _get_plugin_icon() -> Texture2D:
	return preload("res://addons/easy_interfaces/icons/icon_16x16.svg")

func _exit_tree() -> void:
	if main_panel_instance:
		main_panel_instance.queue_free()
