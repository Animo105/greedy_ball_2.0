extends Module

enum directions { UP, DOWN, LEFT, RIGHT, NONE }
var direction : directions = directions.NONE
var timer = Timer.new()
var health: int = 5
@onready var camera: Camera2D = get_tree().get_first_node_in_group("camera")

func _ready():
	add_child(timer)
	timer.wait_time = 5.0
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _process(delta):
	match(direction):
		directions.UP:
			position.y += 1
		directions.DOWN:
			position.y -= 1
		directions.LEFT:
			position.x += 1
		directions.RIGHT:
			position.x -= 1

func collision(ball : Ball):
	ball.apply_impulse((self.global_position - ball.global_position).normalized() * -force_value)
	camera.screen_shake()
	health -= ball.ball_damage
	if health <= 0:
		queue_free()

func _on_timer_timeout():
	print("timer")
