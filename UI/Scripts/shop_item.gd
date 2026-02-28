extends PanelContainer
class_name ShopItem

const SHOP_ITEM = preload("uid://d1mom0agerkky")

signal clicked(shop_item : ShopItem)

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer/TextureRect
@onready var label_name: Label = $MarginContainer/VBoxContainer/HBoxContainer/LabelName
@onready var label_price: Label = $MarginContainer/VBoxContainer/LabelPrice

var module : ResourceModule
var current_price : float = 0

static func instantiate(module_res : ResourceModule) -> ShopItem:
	var new_item : ShopItem = SHOP_ITEM.instantiate()
	new_item.module = module_res
	return new_item

func _ready() -> void:
	texture_rect.texture = module.icon_texture
	label_name.text = module.module_name
	current_price = module.basic_price
	label_price.text = "Price: %0.2f$" % module.basic_price

func increment_pricing():
	current_price = current_price * module.price_mult
	label_price.text = "Price: %0.2f$" % current_price

func decrement_pricing():
	current_price = current_price / module.price_mult
	label_price.text = "Price: %0.2f$" % current_price

func get_last_price() -> float:
	return (current_price/ module.price_mult)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		clicked.emit(self)

func _on_mouse_entered() -> void:
	self_modulate.a = 0.4


func _on_mouse_exited() -> void:
	self_modulate.a = 1
