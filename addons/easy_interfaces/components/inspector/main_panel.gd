@tool
extends VBoxContainer

@export var dirs_to_check: Array[String] = ["res://"]

var card_interface_scene: PackedScene = preload("res://addons/easy_interfaces/components/card_interface/card_interface.tscn")


@onready var scroll_panel: ScrollContainer = $Control/ScrollPanel
@onready var container: Container = $Control/ScrollPanel/Container


var spawn_offset := Vector2(50, 50)


const IGNORED_FILE_NAMES = ['.git', '.godot', 'imported', 'addons', 'shader_cache', '.', '..']
const IGNORED_PROPERTIES = []
const IGNORED_FUNCTIONS = ['_ready', '_process']
const IGNORED_SIGNALS = []


func run_validation() -> void:
	var data = get_data_to_validation()
	var paths: Array[String] = []
	
	for dir in dirs_to_check:
		paths.append_array(get_files(dir))

	for path in paths:
		var script: Script = load(path)
		var consts = script.get_script_constant_map()

		if consts.has('INTERFACES'):
			var has_error = false
			for interface in consts['INTERFACES']:
				if data.has(interface):
					var in_interface: Dictionary = data[interface]
					var in_script := {
						'properties': get_set_name_of_variants(script.get_script_property_list()),
						'functions': get_set_name_of_variants(script.get_script_method_list()),
						'signals': get_set_name_of_variants(script.get_script_signal_list()),
					}
					
					for key in in_script['properties'].keys():
						if key.ends_with(".gd"):
							in_script['properties'].erase(key)
					
					for value in IGNORED_PROPERTIES:
						in_script['properties'].erase(value)
						
					for value in IGNORED_FUNCTIONS:
						in_script['functions'].erase(value)
						
					for value in IGNORED_SIGNALS:
						in_script['signals'].erase(value)
						
					left_erase_sets(in_interface['property'], in_script['properties'])
					left_erase_sets(in_interface['function'], in_script['functions'])
					left_erase_sets(in_interface['signal'], in_script['signals'])
					
					
					for key in in_interface['property']:
						has_error = true
						printerr('EasyInterface: Error in "%s": %s - Property "%s" not found in script' % [path, interface, key])
						
					for key in in_interface['function']:
						has_error = true
						printerr('EasyInterface: Error in "%s": %s - Function "%s" not found in script' % [path, interface, key])
						
					for key in in_interface['signal']:
						has_error = true
						printerr('EasyInterface: Error in "%s": %s - Signal "%s" not found in script' % [path, interface, key])

				else:
					push_warning(interface + ' interface not configured')

			if has_error:
				assert(false, 'EasyInterface: Make adjustments and check again')
			else:
				print('EasyInterface: Everything ok for now...')

func left_erase_sets(left_set: Dictionary, right_set: Dictionary):
	for key in right_set.keys():
		left_set.erase(key)


func get_set_name_of_variants(variants):
	var set = {}
	
	for value in variants:
		set[value['name']] = null
		
	return set


func get_files(path : String) -> Array:
	var files: Array = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()

		while file_name != "":
			if file_name in IGNORED_FILE_NAMES:
				file_name = dir.get_next()
				continue
			if dir.current_is_dir():
				files.append_array(get_files(path.path_join(file_name)))
			else:
				if file_name.ends_with(".gd"):
					files.append(path.path_join(file_name))

			file_name = dir.get_next()

	return files


func load_data() -> void:
	var file = FileAccess.open("res://addons/easy_interfaces/data/data.easy_interface", FileAccess.READ)
	var data = file.get_var()

	set_data(data)


func save() -> void:
	var file = FileAccess.open("res://addons/easy_interfaces/data/data.easy_interface", FileAccess.WRITE)
	var data = get_data_to_save()
	
	file.store_var(data)


func get_values_in_canvas() -> Array:
	var values = []
	for card in container.get_children():
		values.append(card.get_values())
	
	return values


func get_data_to_save() -> Dictionary:
	return {
		'canvas_size': container.custom_minimum_size,
		'interfaces': get_values_in_canvas()
	}


func get_data_to_validation() -> Dictionary:
	var data := {}
	for interface in get_values_in_canvas():
		data[interface['name']] = {
			'property': array_to_set(interface['property']),
			'function': array_to_set(interface['function']),
			'signal': array_to_set(interface['signal']),
		}
		
	return data


func array_to_set(array):
	var set = {}
	
	for item in array:
		set[item] = null
	
	return set


func set_data(data: Dictionary) -> void:
	if 'canvas_size' in data:
		var minimum_size =  data['canvas_size']
		if minimum_size:
			container.custom_minimum_size = minimum_size
	
	if 'interfaces' in data:
		var interfaces = data['interfaces']
		if interfaces:
			for interface in interfaces:
				var new_card = card_interface_scene.instantiate()
				container.add_child(new_card)
				new_card.set_values(interface)


func _on_new_interface_button_down() -> void:
	var new_card = card_interface_scene.instantiate()
	
	container.add_child(new_card)
	
	new_card.position = spawn_offset  + Vector2(scroll_panel.scroll_horizontal, scroll_panel.scroll_vertical)


func _on_x_value_changed(value: float) -> void:
	container.custom_minimum_size.x = value


func _on_y_value_changed(value: float) -> void:
	container.custom_minimum_size.y = value


func _on_save_button_down() -> void:
	save()


func _on_validate_button_down() -> void:
	run_validation()
