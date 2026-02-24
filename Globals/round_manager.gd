extends Node

enum GameStates {
	NONE,
	BUILDING,
	REMOVING,
	PLAYING,
}

var game_state : GameStates = GameStates.NONE
