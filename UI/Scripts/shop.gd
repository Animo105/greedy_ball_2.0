extends PanelContainer

@onready var shop_panel: VBoxContainer = $VBoxContainer/ScrollContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for module : ResourceModule in DataManager.loaded_resource_modules.values():
		var shop_item = ShopItem.instantiate(module.icon_texture, module.module_name, module.basic_price)
		shop_panel.add_child(shop_item)
