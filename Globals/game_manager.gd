extends Node

signal game_state_changed(value : GameStates)
signal round_ended
signal round_started
signal build_module_placed
signal build_module_canceled
signal delete_mode_entered
signal delete_mode_exited
signal deleted_module(module_type : String)

enum GameStates {
	NONE,
	BUILDING,
	REMOVING,
	PLAYING,
}

var difficulty_sell_percentage : float = 1.0
var difficulty_money_gain_percentage : float = 1.0
var difficulty_score_gain_percentage : float = 1.0

var game_state : GameStates = GameStates.NONE:
	set(value):
		game_state = value
		game_state_changed.emit(value)

func _process(_delta: float) -> void:
	match game_state:
		GameStates.BUILDING:
			if not module_in_building:
				cancel_build()
				return
			module_in_building.global_position = get_viewport().get_mouse_position()
			module_in_building.area_placement.show_placing_preview()

func _unhandled_input(event: InputEvent) -> void:
	if game_state == GameStates.NONE : return
	if event is InputEventMouseButton && event.is_pressed():
		if event.button_index == 1:
			if game_state == GameStates.BUILDING:
				place_module()
			elif game_state == GameStates.REMOVING:
				delete_module()

# PLAYING VARIABLES AND FUNCTIONS
var starting_ball_positon : Vector2 = Vector2.ZERO
var balls : Array[Ball]
var ball_type : String = ""

func remove_ball(ball : Ball) -> bool:
	var idx = balls.find(ball)
	if idx == -1:
		return false
	ball.queue_free()
	balls.remove_at(idx)
	if balls.is_empty():
		end_round()
	return true

func add_ball(ball : Ball) -> bool:
	if game_state != GameStates.PLAYING:
		return false
	balls.append(ball)
	return true

func start_round() -> void:
	if game_state == GameStates.NONE:
		var ball : Ball = null
		if ball_type.is_empty():
			ball = DataManager.basic_ball.instantiate()
		else:
			ball = DataManager.loaded_resource_balls[ball_type].ball_scene.instantiate()
		get_tree().current_scene.add_child(ball)
		balls.append(ball)
		ball.global_position = starting_ball_positon
		game_state = GameStates.PLAYING
		round_started.emit()

func end_round() -> void:
	if game_state == GameStates.PLAYING:
		for ball in balls:
			ball.queue_free()
		balls = []
		game_state = GameStates.NONE
		ScoreManager.finish_round()
		round_ended.emit()


# BUILDING VARIABLES AND FUNCTIONS
var modules : Dictionary[Module, String]
var module_in_building : Module = null
var module_in_building_id : String = ""
var can_build : bool = false

func build_module(module : Module, module_id : String):
	if game_state != GameStates.NONE: return
	if !module.area_placement: return
	module_in_building = module
	module_in_building_id = module_id
	get_tree().current_scene.add_child(module)
	module_in_building.area_placement.show_placing_preview()
	game_state = GameStates.BUILDING

func place_module():
	if module_in_building && module_in_building.area_placement.is_placable():
		module_in_building.area_placement.hide_preview()
		modules[module_in_building] = module_in_building_id
		module_in_building.area_placement.module_mouse_entered.connect(_hover_module_in)
		module_in_building.area_placement.module_mouse_exited.connect(_hover_module_out)
		module_in_building = null
		module_in_building_id = ""
		game_state = GameStates.NONE
		build_module_placed.emit()

func cancel_build():
	if game_state != GameStates.BUILDING: return
	module_in_building.queue_free()
	module_in_building = null
	module_in_building_id = ""
	game_state = GameStates.NONE
	build_module_canceled.emit()


# DELETION VARIABLES AND FUNCTIONS
var hovered_module : Module = null

func delete_module():
	if not hovered_module: return
	if not modules.has(hovered_module): return
	var module_id = modules[hovered_module]
	modules.erase(hovered_module)
	hovered_module.queue_free()
	hovered_module = null
	deleted_module.emit(module_id)

func enter_delete_mode():
	if game_state == GameStates.NONE:
		game_state = GameStates.REMOVING
		for module in modules.keys():
			module.area_placement.show_preview()
		delete_mode_entered.emit()

func exit_delete_mode():
	if game_state == GameStates.REMOVING:
		game_state = GameStates.NONE
		for module in modules.keys():
			module.area_placement.hide_preview()
		delete_mode_exited.emit()

func _hover_module_in(module : Module):
	if game_state != GameStates.REMOVING: return
	module.modulate = Color.ORANGE_RED
	hovered_module = module

func _hover_module_out(module : Module):
	if game_state != GameStates.REMOVING: return
	module.modulate = Color.WHITE
	hovered_module = null
