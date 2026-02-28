extends PanelContainer
@onready var score: Label = $VBoxContainer/HBoxContainer/Score
@onready var combo: Label = $VBoxContainer/Combo
@onready var money: Label = $VBoxContainer/Money
@onready var round_score: Label = $VBoxContainer/HBoxContainer/round_score

var _target_score : int = 0:
	set(value):
		_target_score = value
		_target_score_changed.emit()
var _target_round_score : int = 0:
	set(value):
		_target_round_score = value
		_target_round_score_changed.emit()

signal _target_score_changed
signal _target_round_score_changed

var tween_score : Tween
var tween_round_score : Tween

func _ready() -> void:
	_target_round_score_changed.connect(_update_round_score)
	_target_score_changed.connect(_update_score)
	ScoreManager.score_changed.connect(_set_target_score)
	ScoreManager.round_score_changed.connect(_set_target_round_score)
	ScoreManager.combo_changed.connect(_update_combo)
	ScoreManager.money_changed.connect(_update_money)

func _set_target_score(value : int):
	if tween_score:
		tween_score.kill()
	tween_score = create_tween()
	tween_score.tween_property(self, "_target_score", value, 0.1)

func _set_target_round_score(value : int):
	if tween_round_score:
		tween_round_score.kill()
	tween_round_score = create_tween()
	tween_round_score.tween_property(self, "_target_round_score", value, 0.1)

func _update_round_score():
	if _target_round_score == 0: 
		round_score.text = ""
		return
	round_score.text = "+ %s" % _target_round_score

func _update_score():
	score.text = "Score: %s" % _target_score

func _update_combo(value : float):
	combo.text = "Combo: %0.2fx" % value

func _update_money(value : float):
	money.text = "Money: %s$" % value
