extends PanelContainer
@onready var score: Label = $VBoxContainer/HBoxContainer/Score
@onready var combo: Label = $VBoxContainer/Combo
@onready var money: Label = $VBoxContainer/Money
@onready var round_score: Label = $VBoxContainer/HBoxContainer/round_score

func _ready() -> void:
	ScoreManager.score_changed.connect(update_score)
	ScoreManager.round_score_changed.connect(update_round_score)
	ScoreManager.combo_changed.connect(update_combo)
	ScoreManager.money_changed.connect(update_money)

func update_round_score(value : int):
	if value == 0: 
		round_score.text = ""
		return
	round_score.text = "+ %s" % value

func update_score(value : int):
	score.text = "Score: %s" % value

func update_combo(value : float):
	combo.text = "Combo: %0.2fx" % value

func update_money(value : float):
	money.text = "Money: %s$" % value
