@tool
extends Control

# imports
var field_scene = preload("res://addons/easy_interfaces/components/card_interface/removable_line_edit/removable_line_edit.tscn")

@onready var interface_name: LineEdit = $Panel/PanelContainer/MarginContainer/VBoxContainer/InterfaceName

@onready var property_container: VBoxContainer = $Panel/PanelContainer/MarginContainer/VBoxContainer/PropertyContainer
@onready var function_container: VBoxContainer = $Panel/PanelContainer/MarginContainer/VBoxContainer/FunctionContainer
@onready var signal_container: VBoxContainer = $Panel/PanelContainer/MarginContainer/VBoxContainer/SignalContainer

func set_values(values: Dictionary) -> void:
	interface_name.text = values['name']
	position = values['position']
	property_container.set_values(values['property'])
	function_container.set_values(values['function'])
	signal_container.set_values(values['signal'])

func get_values():
	return {
		'name': interface_name.text,
		'position': position,
		'property': property_container.get_values(),
		'function': function_container.get_values(),
		'signal': signal_container.get_values()
	}

func _on_new_property_button_down() -> void:
	property_container.add()

func _on_new_function_button_down() -> void:
	function_container.add()

func _on_new_signal_button_down() -> void:
	signal_container.add()
