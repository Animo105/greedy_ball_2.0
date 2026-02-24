extends Node

const MODULES_RESOURCE_FOLDER_PATH : String = "res://Balls/Resources/"
const BALLS_RESOURCE_FOLDER_PATH : String = "res://Modules/Resources/"

var loaded_balls : Array[ResourceBall]
var loaded_resource_modules : Array[ResourceModule]

func _ready() -> void:
	# Check before anything, crash if it doesn't work
	assert(DirAccess.dir_exists_absolute(MODULES_RESOURCE_FOLDER_PATH) && DirAccess.dir_exists_absolute(BALLS_RESOURCE_FOLDER_PATH))
	
	# Load Modules
	for file_name in DirAccess.get_files_at(MODULES_RESOURCE_FOLDER_PATH):
		print(file_name)
	
	# Load Balls
	
	pass
