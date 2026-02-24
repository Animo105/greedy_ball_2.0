extends PanelContainer
@onready var score: Label = $VBoxContainer/Score
@onready var combo: Label = $VBoxContainer/Combo

func _ready() -> void:
	ScoreManager.score_changed.connect(update_score)
	ScoreManager.combo_changed.connect(update_combo)

func update_score(value : int):
	score.text = "Score: %s" % value

func update_combo(value : float):
	combo.text = "Combo: %0.2fx" % value
