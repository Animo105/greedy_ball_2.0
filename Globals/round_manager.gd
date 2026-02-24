extends Node

signal game_state_changed(value : GameStates)

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

func start_round():
	if game_state == GameStates.BUILDING:
		game_state = GameStates.PLAYING
