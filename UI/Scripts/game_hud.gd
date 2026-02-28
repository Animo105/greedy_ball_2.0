extends CanvasLayer

@onready var trash_button: Button = $TrashButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.delete_mode_entered.connect(_on_delete_mode_start)
	GameManager.delete_mode_exited.connect(_on_delete_mode_exit)

func _input(event: InputEvent) -> void:
	if event.is_action("cancel"):
		_on_trash_button_pressed()

func _on_trash_button_pressed() -> void:
	if GameManager.game_state == GameManager.GameStates.BUILDING:
		GameManager.cancel_build()
	elif GameManager.game_state == GameManager.GameStates.REMOVING:
		GameManager.exit_delete_mode()
	elif GameManager.game_state == GameManager.GameStates.NONE:
		GameManager.enter_delete_mode()

func _on_delete_mode_start():
	trash_button.text = "Qitter Deletion Mode"

func _on_delete_mode_exit():
	trash_button.text = "TRASH!!!"
