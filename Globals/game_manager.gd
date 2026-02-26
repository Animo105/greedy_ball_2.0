extends Node

signal game_state_changed(value : GameStates)
signal round_ended
signal round_started

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
