@abstract extends CollisionObject2D
class_name Module

@export var force_value : int = 0
@export var point_value : int = 0
@export var area_placement : AreaModulePlacement

func _ready() -> void:
	if ! area_placement:
		push_error("Module without area: ", self)
		queue_free()
		return
	area_placement.parent_module = self

@abstract func collision(ball : Ball)
