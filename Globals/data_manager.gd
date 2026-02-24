extends Node

const MODULES_RESOURCE_FOLDER_PATH : String = "res://Modules/Resources/"
const BALLS_RESOURCE_FOLDER_PATH : String = "res://Balls/Resources/"

var loaded_resource_balls : Array[ResourceBall]
var loaded_resource_modules : Array[ResourceModule]

func _ready() -> void:
	# Check before anything, crash if it doesn't work
	assert(DirAccess.dir_exists_absolute(MODULES_RESOURCE_FOLDER_PATH) && DirAccess.dir_exists_absolute(BALLS_RESOURCE_FOLDER_PATH))
	# Load Modules
	for file_name in DirAccess.get_files_at(MODULES_RESOURCE_FOLDER_PATH):
		var resource = load(MODULES_RESOURCE_FOLDER_PATH+file_name)
		if resource is ResourceModule:
			loaded_resource_modules.append(resource)
		else:
			push_error("Resource '"+file_name+"' is not a ResourceModule")
	# Load Balls
	for file_name in DirAccess.get_files_at(BALLS_RESOURCE_FOLDER_PATH):
		var resource = load(BALLS_RESOURCE_FOLDER_PATH+file_name)
		if resource is ResourceModule:
			loaded_resource_balls.append(resource)
		else:
			push_error("Resource '"+file_name+"' is not a ResourceBall")
