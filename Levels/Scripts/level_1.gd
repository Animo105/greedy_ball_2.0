extends Node2D
@onready var start_ball_position: Marker2D = $Level1Ig/StartBallPosition


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RoundManager.starting_ball_positon = start_ball_position.global_position


func _on_start_pressed() -> void:
	RoundManager.start_round()


func _on_end_pressed() -> void:
	RoundManager.end_round()


func _on_static_body_2d_body_entered(body: Node2D) -> void:
	if body is Ball:
		RoundManager.remove_ball(body)


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		RoundManager.ball_type = "money_ball"
	else:
		RoundManager.ball_type = ""
