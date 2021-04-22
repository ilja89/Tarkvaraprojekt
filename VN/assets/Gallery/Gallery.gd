extends Node

var fname = ["string"]
var data = ["string"]
var file : File
var current=1
var maximal=1
var mouse_prev_position: Vector2
var picture_size: Vector2 = Vector2(1280,720)
var picture_prev_size: Vector2

func _ready():
	file = File.new()
	file.open("res://assets/Gallery/data.dat",File.READ)
	parse()
	upd()

func upd():
	print("UPDATE")
	print(str(current)+" - " + str(fname[current])+".png")
	if(str(data[current])!="-"):
		$author.text = data[current]
	else:
		$author.text = ""
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


func _on_input_text_changed(new_text):
	if(int($input.text)<1):
		$input.text="1"
	elif(int($input.text)>maximal):
		$input.text=str(maximal)

func _input(event):
	if Input.is_action_just_pressed("mouse_right"):
		mouse_prev_position=get_viewport().get_mouse_position()
	elif Input.is_action_pressed("mouse_right"):
		var move:Vector2 = mouse_prev_position - get_viewport().get_mouse_position()
		$picture.rect_position-=move
		mouse_prev_position=get_viewport().get_mouse_position()
	if Input.is_action_pressed("scroll_up"):
		picture_prev_size=$picture.rect_size
		$picture.rect_size=$picture.rect_size*1.1
		$picture.rect_position=$picture.rect_position+(picture_prev_size-$picture.rect_size)/2
	if Input.is_action_pressed("scroll_down"):
		picture_prev_size=$picture.rect_size
		$picture.rect_size=$picture.rect_size*0.9
		$picture.rect_position=$picture.rect_position+(picture_prev_size-$picture.rect_size)/2
	if Input.is_action_pressed("ui_accept"):
		$picture.rect_size=picture_size
		$picture.rect_position=Vector2(0,0)
	if Input.is_action_just_pressed("hide"):
		if($hide.pressed==false):
			$hide.pressed=true
			_on_hide_pressed()
		else:
			$hide.pressed=false
			_on_hide_pressed()
