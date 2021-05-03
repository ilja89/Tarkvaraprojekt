extends VBoxContainer



func _ready():
	$Label.text = CharacterStats.family
	$Label2.text = CharacterStats.trait
	$Label3.text = CharacterStats.job
	$Label4.text = CharacterStats.motivation
	$Label5.text = "%d" %SaveGame.savecount
