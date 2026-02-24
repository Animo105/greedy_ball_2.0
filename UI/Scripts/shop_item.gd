extends PanelContainer
class_name ShopItem

const SHOP_ITEM = preload("uid://d1mom0agerkky")

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer/TextureRect
@onready var label_name: Label = $MarginContainer/VBoxContainer/HBoxContainer/LabelName
@onready var label_price: Label = $MarginContainer/VBoxContainer/LabelPrice

var texture : Texture2D
var label_text : String
var item_price : int

static func instantiate(icon : Texture2D, text : String, price : int) -> ShopItem:
	var new_item : ShopItem = SHOP_ITEM.instantiate()
	new_item.texture = icon
	new_item.label_text = text
	new_item.item_price = price
	return new_item

func _ready() -> void:
	texture_rect.texture = texture
	label_name.text = label_text
	label_price.text = "Price: %s$" % item_price
	
