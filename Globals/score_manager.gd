extends Node

signal score_changed(new_value : int)
signal combo_changed(new_value : float)
signal money_changed(new_value : float)
signal round_score_changed(new_value : int)

var round_score : float = 0:
	set(value):
		round_score = value
		round_score_changed.emit(int(value))

var score_value : int = 0:
	set(value):
		score_value = value
		score_changed.emit(value)

var combo_mult : float = 1:
	set(value):
		combo_mult = value
		combo_changed.emit(value)

var money : float = 0:
	set(value):
		money = value
		money_changed.emit(value)

func reset():
	score_value = 0
	reset_combo()

func finish_round():
	money += round_score/100.0 * GameManager.difficulty_money_gain_percentage
	score_value += int(round_score)
	round_score = 0
	reset_combo()

func reset_combo():
	combo_mult = 1

func increment_combo(amount : int = 1):
	combo_mult += 0.01 * amount

func increment_score(amount : int = 1):
	round_score += amount * combo_mult * GameManager.difficulty_score_gain_percentage
