extends PanelContainer
class_name ShopItem

const SHOP_ITEM = preload("uid://d1mom0agerkky")

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer/TextureRect
@onready var label_name: Label = $MarginContainer/VBoxContainer/HBoxContainer/LabelName
@onready var label_price: Label = $MarginContainer/VBoxContainer/LabelPrice

var module : ResourceModule

static func instantiate(module_res : ResourceModule) -> ShopItem:
	var new_item : ShopItem = SHOP_ITEM.instantiate()
	new_item.module = module_res
	return new_item

func _ready() -> void:
	texture_rect.texture = module.icon_texture
	label_name.text = module.module_name
	label_price.text = "Price: %s$" % module.basic_price

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if GameManager.game_state == GameManager.GameStates.NONE:
			GameManager.build_module(module.module_scene.instantiate(), module.basic_price)

func _on_mouse_entered() -> void:
	self_modulate.a = 0.4


func _on_mouse_exited() -> void:
	self_modulate.a = 1
