extends Control

@onready var shop_panel: VBoxContainer = $PanelContainer/VBoxContainer/ScrollContainer/ShopPanel


const OPENED_SIZE : Vector2 = Vector2(240, 720)
const CLOSED_SIZE : Vector2 = Vector2(0, 720)

var tween : Tween = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size = OPENED_SIZE
	for module : ResourceModule in DataManager.loaded_resource_modules.values():
		var shop_item : ShopItem = ShopItem.instantiate(module.icon_texture, module.module_name, int(module.basic_price))
		shop_panel.add_child(shop_item)
	GameManager.round_started.connect(close)
	GameManager.round_ended.connect(open)

func close():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self,"size", CLOSED_SIZE, 0.1)
	tween.tween_property(self, "visible", false, 0)

func open():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "visible", true, 0)
	tween.tween_property(self,"size", OPENED_SIZE, 0.1)
