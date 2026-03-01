extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.difficulty_money_gain_percentage = 1.0
	GameManager.difficulty_score_gain_percentage = 1.0
	GameManager.difficulty_sell_percentage = 1.0
