extends PanelContainer
@onready var score: Label = $VBoxContainer/Score
@onready var combo: Label = $VBoxContainer/Combo
@onready var money: Label = $VBoxContainer/Money

func _ready() -> void:
	ScoreManager.score_changed.connect(update_score)
	ScoreManager.combo_changed.connect(update_combo)
	ScoreManager.money_changed.connect(update_money)

func update_score(value : int):
	score.text = "Score: %s" % value

func update_combo(value : float):
	combo.text = "Combo: %0.2fx" % value

func update_money(value : float):
	money.text = "Money: %s$" % value
