@abstract extends CollisionObject2D
class_name Module

@export var force_value : int = 0
@export var point_value : int = 0
@export var AreaPlacement : AreaModulePlacement

@abstract func collision(ball : Ball)
