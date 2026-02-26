extends Node

signal game_state_changed(value : GameStates)
signal round_ended
signal round_started
signal module_placed

enum GameStates {
	NONE,
	BUILDING,
	REMOVING,
	PLAYING,
}

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
				if module_in_building.area_placement.is_placable():
					module_in_building.area_placement.hide_preview()
					module_in_building = null
					game_state = GameStates.NONE
					module_placed.emit()
			elif game_state == GameStates.REMOVING:
				pass

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
		round_ended.emit()


# BUILDING VARIABLES AND FUNCTIONS
var modules : Array[Module]
var module_in_building : Module = null
var can_build : bool = false

func build_module(module : Module, price : float):
	if game_state != GameStates.NONE: return
	if !module.area_placement: return
	module_in_building = module
	get_tree().current_scene.add_child(module)
	module_in_building.area_placement.show_placing_preview()
	game_state = GameStates.BUILDING

func cancel_build():
	if game_state != GameStates.BUILDING: return
	module_in_building.queue_free()
	module_in_building = null
	game_state = GameStates.NONE
