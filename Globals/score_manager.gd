extends Node

signal score_changed(new_value : int)
signal combo_changed(new_value : float)
signal money_changed(new_value : int)

var score_value : int = 0:
	set(value):
		score_value = value
		score_changed.emit(value)

var combo_mult : float = 1:
	set(value):
		combo_mult = value
		combo_changed.emit(value)

var money : int = 0:
	set(value):
		money = value
		money_changed.emit(value)

func reset():
	score_value = 0
	combo_mult = 0

func reset_combo():
	combo_mult = 0

func increment_combo(amount : int = 1):
	combo_mult += 0.01 * amount

func increment_score(amount : int = 1):
	score_value += int(amount * combo_mult)
