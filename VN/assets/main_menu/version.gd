extends Label


func _ready():
	text = ProjectSettings.get("application/config/version")
