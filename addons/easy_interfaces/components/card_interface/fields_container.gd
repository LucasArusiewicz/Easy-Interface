@tool
extends VBoxContainer


@export var type : Type


# imports
var field_scene: PackedScene = preload("res://addons/easy_interfaces/components/card_interface/removable_line_edit/removable_line_edit.tscn")
var property_theme: Theme = preload("res://addons/easy_interfaces/components/card_interface/themes/property_field.tres")
var function_theme: Theme = preload("res://addons/easy_interfaces/components/card_interface/themes/function_field.tres")
var signal_theme: Theme = preload("res://addons/easy_interfaces/components/card_interface/themes/signal_field.tres")


enum Type {
	PROPERTY,
	FUNCTION,
	SIGNAL,
}


var _themes: Array[Theme] = [property_theme, function_theme, signal_theme]
var _placeholders: Array[String] = ['New Property', 'New Function', 'New Signal']


func add(text='') -> void:
	var new_field = field_scene.instantiate()
	var line_edit = new_field.get_child(0) as LineEdit
	
	new_field.theme = _themes[type]
	line_edit.placeholder_text = _placeholders[type]
	
	if text.length():
		line_edit.text = text

	add_child(new_field)


func get_values() -> Array[String]:
	var values: Array[String] = []

	for child in get_children():
		var line_edit = child.get_child(0) as LineEdit
		if line_edit.text.length():
			values.append(line_edit.text)

	return values

func set_values(values: Array):
	for value in values:
		add(value)
	
