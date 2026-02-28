extends Control

@onready var shop_panel: VBoxContainer = $PanelContainer/VBoxContainer/ScrollContainer/ShopPanel


const OPENED_SIZE : Vector2 = Vector2(240, 720)
const CLOSED_SIZE : Vector2 = Vector2(0, 720)

var tween : Tween = null

var _shop_item_ref : ShopItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for module : ResourceModule in DataManager.loaded_resource_modules.values():
		var shop_item : ShopItem = ShopItem.instantiate(module)
		shop_item.clicked.connect(_shop_item_clicked)
		shop_panel.add_child(shop_item)
		
	GameManager.round_started.connect(close)
	GameManager.round_ended.connect(open)
	GameManager.build_module_placed.connect(_item_builded)
	GameManager.build_module_canceled.connect(_canceled_build)
	GameManager.deleted_module.connect(_delete_module)
 
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
	tween.set_parallel()
	tween.tween_property(self, "visible", true, 0)
	tween.tween_property(self,"size", OPENED_SIZE, 0.1)

func _shop_item_clicked(shop_item : ShopItem):
	if GameManager.game_state != GameManager.GameStates.NONE: return
	if ScoreManager.money < shop_item.current_price: return
	_shop_item_ref = shop_item
	GameManager.build_module(shop_item.module.module_scene.instantiate(), shop_item.module.module_id)

func _item_builded():
	if not _shop_item_ref: return
	ScoreManager.money -= _shop_item_ref.current_price
	_shop_item_ref.increment_pricing()

func _canceled_build():
	if not _shop_item_ref: return
	_shop_item_ref = null

func _delete_module(type : String):
	var shop_item : ShopItem = null
	for child : ShopItem in shop_panel.get_children():
		if child.module.module_id == type:
			shop_item = child
			break
	if not shop_item: return
	ScoreManager.money += shop_item.get_last_price() * GameManager.difficulty_sell_percentage
	print(shop_item.get_last_price())
	shop_item.decrement_pricing()
