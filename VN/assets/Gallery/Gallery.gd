extends Node

var fname = ["string"]
var data = ["string"]
var file : File
var current=1
var maximal=1

func _ready():
	file = File.new()
	file.open("res://assets/Gallery/data.dat",File.READ)
	parse()
	upd()

func upd():
	print("UPDATE")
	print(str(current)+" - "+str(fname) + " - " + str(fname[current]))
	$author.text = data[current]
	$picture.texture = load("res://assets/Scenes/Backgrounds/"+str(fname[current])+".png")
	$current_number.text = (str(current)+" of "+str(maximal))

func parse():
	var i=1;
	fname.resize(i+1)
	data.resize(i+1)
	while(file.eof_reached()==false):
		fname[i]=file.get_line()
		if(fname[i]!=""&&file.eof_reached()==false):
			data[i]=file.get_line()
			i=i+1
		fname.resize(i+1)
		data.resize(i+1)
	maximal=i-1

func next():
	print("NEXT PRESSED")
	if(current<maximal):
		current=current+1
	upd()


func prev():
	print("PREV PRESSED")
	if(current>1):
		current=current-1
	upd()
	


func goto():
	if(int($input.text)>0&&int($input.text)<=maximal):
		current=int($input.text)
		upd()


func hide():
	$goto.visible=false
	$menu.visible=false
	$next.visible=false
	$prev.visible=false
	$input.visible=false
	$current_number.visible=false
	$author.visible=false
	$stretch.visible=false
	$hide.modulate="32ffffff"

func show():
	$goto.visible=true
	$menu.visible=true
	$next.visible=true
	$prev.visible=true
	$input.visible=true
	$current_number.visible=true
	$author.visible=true
	$stretch.visible=true
	$hide.modulate="ffffffff"

func _on_hide_pressed():
	if($hide.pressed==false):
		show()
	else:
		hide()


func stretch():
	if($stretch.pressed==false):
		$picture.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	else:
		$picture.stretch_mode=TextureRect.STRETCH_SCALE


func _on_menu_pressed():
	get_tree().change_scene("res://assets/main_menu/MainMenu.tscn")
