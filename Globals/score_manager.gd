extends Node

signal score_changed(new_value : int)
signal combo_changed(new_value : float)
signal money_changed(new_value : int)
signal round_score_changed(new_value : int)

var round_score : int = 0:
	set(value):
		round_score = value
		round_score_changed.emit(value)

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
	reset_combo()

func finish_round():
	money += int(round_score/100.0)
	score_value += round_score
	round_score = 0
	reset_combo()

func reset_combo():
	combo_mult = 1

func increment_combo(amount : int = 1):
	combo_mult += 0.01 * amount

func increment_score(amount : int = 1):
	round_score += int(amount * combo_mult)
