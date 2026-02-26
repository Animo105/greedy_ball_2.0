extends Area2D
class_name AreaModulePlacement

const COLOR_YELLOW : Color = Color(0.918, 0.784, 0.216, 0.365)
const COLOR_GREEN : Color = Color(0.0, 0.863, 0.235, 0.365)
const COLOR_RED : Color = Color(0.843, 0.09, 0.173, 0.365)

@export var collision_shape : CollisionShape2D
var parent_module : Module

func is_placable() -> bool:
	var placeable : bool = false
	for area : Area2D in get_overlapping_areas():
		if area is AreaModulePlacement:
			return false
		if area is AreaPlacable:
			placeable = true
	return placeable

func _ready() -> void:
	if !collision_shape:
		var col = get_child(0)
		if not col is CollisionShape2D:
			push_error("First child of ModuleArea is not a CollisionShade2D")
			queue_free()
			return
		collision_shape = col
	collision_layer = 4
	collision_mask = 4
	area_entered.connect(_on_area_enter)
	area_exited.connect(_on_area_exit)

func show_preview():
	collision_shape.shape.draw.call_deferred(get_canvas_item(), COLOR_YELLOW)

func show_placing_preview():
	hide_preview()
	var color : Color = COLOR_GREEN if is_placable() else COLOR_RED
	collision_shape.shape.draw.call_deferred(get_canvas_item(), color)
		

func hide_preview():
	queue_redraw()

func _on_area_exit(area : Area2D):
	if area is AreaModulePlacement:
		area.hide_preview()

func _on_area_enter(area : Area2D):
	if area is AreaModulePlacement:
		area.show_preview()
