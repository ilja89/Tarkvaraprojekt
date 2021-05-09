extends TextureButton

export(String) var choice
export(String) var button_text

func _ready():
	$RichTextLabel.bbcode_text = button_text
