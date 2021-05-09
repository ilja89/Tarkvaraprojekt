extends Node

# Scenes where to go in cases:
var goto_win = "res://assets/Scenes/Main scenes/9/4/Scene.tscn"
var goto_lose = "res://assets/Scenes/Endings/0022/Scene.tscn"

# Player variables
var p_max_hp #Max hp
var p_hp #Current hp
var p_max_stamina #Max stamina
var p_stamina #Current stamina
var p_stat_stamina #Stamina stat
var p_stat_strength #Strength stat
var p_stat_agility #Agility stat
var p_atk #Player attack
var p_atk_mod #Player attack modifier
var p_atk_stamina_loss #Player stamina loss on attack
var p_optimal_distance #Optimal distance for attcking
var p_weapon_unusable_high #Higher distance limit for weapon unusability
var p_weapon_unusable_low #Lower distance limit for weapon unusability
var protected #If player protected

# Enemy variables
var e_name = "BANDIT LEADER"
var e_max_hp = 120 #Enemy max hp
var e_hp = e_max_hp #Enemy current hp
var e_max_stamina = 100 #Enemy max stamina
var e_stamina = e_max_stamina #Enemy current stamina
var e_atk = 15 #Enemy attack
var e_atk_mod = 1
var e_atk_stamina_loss = 15 #Enemy stamina loss on attack
var e_optimal_distance=1.5 #Enemy optimal attack distance
var e_weapon_unusable_high=2 #Higher distance limit for weapon unusability
var e_weapon_unusable_low=1 #Lower distance limit for weapon unusability
var e_stat_stamina = 4
var e_stat_agility = 4

#Other variables
var distance = 10 #Current distance between player and enemy
var skip_act = false #Should action phase be skipped
var turn=0
var sound #for sound what should be played
signal sound_finished
signal t

# Initialize all variables
func _ready():
	
	randomize()	
	p_max_hp = CharacterStats.player_hp
	p_hp = p_max_hp
	p_max_stamina = CharacterStats.player_stamina
	p_stamina = p_max_stamina
	p_atk = ((CharacterStats.weapon_atk/CharacterStats.weapon_stat_strength)*(CharacterStats.player_stat_strength))
	p_atk_stamina_loss = ((CharacterStats.weapon_stamina/CharacterStats.weapon_stat_stamina)*CharacterStats.player_stat_stamina)
	p_stat_stamina = CharacterStats.player_stat_stamina
	p_stat_agility = CharacterStats.player_stat_agility
	p_optimal_distance = CharacterStats.weapon_optimal_distance
	p_weapon_unusable_high = CharacterStats.weapon_unusable_high
	p_weapon_unusable_low = CharacterStats.weapon_unusable_low
	$base/UI/Enemy_Label.text=e_name
	
	$base/btn/atk.get_popup().add_item("Simple Attack")
	$base/btn/atk.get_popup().add_item("Medium Attack")
	$base/btn/atk.get_popup().add_item("Strong Attack")
	$base/btn/atk.get_popup().connect("id_pressed",self,"_on_atk_pressed")
	
	$base/btn/act.get_popup().add_item("Relax")
	$base/btn/act.get_popup().add_item("Protect")
	$base/btn/act.get_popup().add_item("Move again")
	if(CharacterStats.healing_potion>0):
		$base/btn/act.get_popup().add_item("Drink potion")
	$base/btn/act.get_popup().connect("id_pressed",self,"_on_act_pressed")
		
	$base/btn/use.get_popup().add_item("Nothing now")
	$base/btn/use.get_popup().connect("id_pressed",self,"_on_use_pressed")
	
	set_start_chars()
	player_movement()
	
func random(from,to):
	var rand=randi()%(to-from+1)+from
	return rand
func wait(minimal,maximal):
	yield(get_tree().create_timer(randf()*(maximal-minimal)+minimal),"timeout")
	emit_signal("t")
func wait_exact(time:float):
	time=time/1000
	yield(get_tree().create_timer(time),"timeout")
	emit_signal("t")

func set_start_chars():
	#HP initialization
	$base/UI/PlayerHP.value = p_hp
	$base/UI/PlayerHP.max_value = p_max_hp
	$base/UI/PlayerHPLabel.text = str(p_hp)
	
	#Stamina initialization
	$base/UI/PlayerStamina.value = p_stamina
	$base/UI/PlayerStamina.max_value = p_max_stamina
	$base/UI/PlayerStaminaLabel.text = str(p_stamina)
	upd()
	

func _on_player_finished():
	emit_signal("sound_finished")

func playsound(group,id):
	var rand
	if(group=="sword"):
		if(id==1):
			rand=random(1,3)
			sound=load("res://assets/Sounds/windy/"+str(rand)+".wav")
			print("playing res://assets/Sounds/windy/"+str(rand)+".wav")
			$base/player.set_stream(sound)
			$base/player.play(0)
			yield($base/player,"finished")
			playsound("random_clang",0)
			yield($base/player,"finished")
			emit_signal("sound_finished")
		elif(id==2):
			playsound("random_clang",0)
			yield($base/player,"finished")
			emit_signal("sound_finished")
	elif(group=="random_clang"):
		rand=random(1,5)
		sound=load("res://assets/Sounds/clang/"+str(rand)+".wav")
		print("res://assets/Sounds/clang/"+str(rand)+".wav")
		$base/player.set_stream(sound)
		$base/player.play(0)
	elif(group=="random_enemy"):
		rand=random(1,3)
		if(rand==1):
			playsound("sword",1)
		elif(rand==2):
			playsound("sword",2)
		else:
			playsound("random_clang",0)
	elif(group=="player_movement"):
		rand=0
		while(rand<id):
			sound=load("res://assets/Sounds/steps/1.wav")
			print("playing res://assets/Sounds/Sound/steps/1.wav")
			$base/player.set_stream(sound)
			$base/player.play(0)
			yield($base/player,"finished")
			rand=rand+1
		emit_signal("sound_finished")
	elif(group=="enemy_movement"):
		rand=0
		while(rand<id):
			sound=load("res://assets/Sounds/steps/1.wav")
			print("playing res://assets/Sounds/steps/1.wav")
			$base/enemy.set_stream(sound)
			$base/enemy.play(0)
			yield($base/enemy,"finished")
			rand=rand+1
		emit_signal("sound_finished")
	elif(group=="enemy_jump"):
		rand=random(1,3)
		sound=load("res://assets/Sounds/jump/"+str(rand)+".wav")
		print("playing res://assets/Sounds/jump/"+str(rand)+".wav")
		$base/enemy.set_stream(sound)
		$base/enemy.play(0)
		yield($base/enemy,"finished")
		emit_signal("sound_finished")
	elif(group=="player_jump"):
		rand=random(1,3)
		sound=load("res://assets/Sounds/jump/"+str(rand)+".wav")
		print("res://assets/Sounds/jump/"+str(rand)+".wav")
		$base/player.set_stream(sound)
		$base/player.play(0)
		yield($base/player,"finished")
		emit_signal("sound_finished")
	
	
func player_movement():
	if(skip_act==false):
		turn=turn+1
	_show_mov_btn()
	_hide_act_btn()
	
func player_act():
	if(skip_act==false):
		_hide_mov_btn()
		_show_act_btn()
	else:
		skip_act=false
		enemy_movement()

func move_optimal():
	var distance_delta=[0,0,0,0,0,0]
	var stamina_left=[0,0,0,0,0,0]
	var i = 0
	var max_usable_stamina
	var minimalid=0
	distance_delta[0]=(clamp(distance-6,e_weapon_unusable_low,10)-e_optimal_distance)
	distance_delta[1]=(clamp(distance+6,e_weapon_unusable_low,10)-e_optimal_distance)
	distance_delta[2]=(clamp(distance-2.5,e_weapon_unusable_low,10)-e_optimal_distance)
	distance_delta[3]=(clamp(distance+2.5,e_weapon_unusable_low,10)-e_optimal_distance)
	distance_delta[4]=(clamp(distance-1,e_weapon_unusable_low,10)-e_optimal_distance)
	distance_delta[5]=(clamp(distance+1,e_weapon_unusable_low,10)-e_optimal_distance)
	
	if(randi()%2>0):
		distance_delta[0]=999
		distance_delta[1]=999
		max_usable_stamina = e_stamina - e_atk_stamina_loss*0.5
	else:
		max_usable_stamina = e_stamina
		
	
	stamina_left[0]=max_usable_stamina-((10-e_stat_agility)/10)*20-20
	stamina_left[1]=max_usable_stamina-((10-e_stat_agility)/10)*20-20
	stamina_left[2]=max_usable_stamina-((10-e_stat_agility)/10)*35-30
	stamina_left[3]=max_usable_stamina-((10-e_stat_agility)/10)*35-30
	stamina_left[4]=max_usable_stamina-((10-e_stat_agility)/10)*10-10
	stamina_left[5]=max_usable_stamina-((10-e_stat_agility)/10)*10-10
	
	while(i<6):
		if(distance_delta[i]<0):
			distance_delta[i]=distance_delta[i]*(-1)
		
		if(stamina_left[i]<0):
			distance_delta[i]=999
		i=i+1
	i=0
	while(i<6):
		if(distance_delta[i]<distance_delta[minimalid]):
			minimalid=i
		i=i+1
	if(distance_delta.min()==999):
		minimalid=10
	
	if(minimalid==0):
		distance = clamp(distance-6,e_weapon_unusable_low,10)
		e_stamina = clamp(e_stamina - ((10-e_stat_agility)/10)*20-20,0,e_max_stamina)
		skip_act=true
		$base/UI/RichTextLabel.newline()
		$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+" runs to you")
		playsound("enemy_movement",4)
		yield(self,"sound_finished")
	elif(minimalid==1):
		distance = clamp(distance+6,e_weapon_unusable_low,10)
		e_stamina = clamp(e_stamina - ((10-e_stat_agility)/10)*20-20,0,e_max_stamina)
		$base/UI/RichTextLabel.newline()
		$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+" runs from you")
		playsound("enemy_movement",4)
		yield(self,"sound_finished")
		skip_act=true
	elif(minimalid==2):
		distance = clamp(distance-2.5,e_weapon_unusable_low,10)
		e_stamina = clamp(e_stamina - ((10-e_stat_agility)/10)*35-30,0,e_max_stamina)
		$base/UI/RichTextLabel.newline()
		$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+" is jumping on you")
		playsound("enemy_jump",0)
		yield(self,"sound_finished")
	elif(minimalid==3):
		distance = clamp(distance+2.5,e_weapon_unusable_low,10)
		e_stamina = clamp(e_stamina - ((10-e_stat_agility)/10)*35-30,0,e_max_stamina)
		$base/UI/RichTextLabel.newline()
		$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+" is jumping from you")
		playsound("enemy_jump",0)
		yield(self,"sound_finished")
	elif(minimalid==4):
		distance = clamp(distance-1,e_weapon_unusable_low,10)
		e_stamina = clamp(e_stamina - ((10-e_stat_agility)/10)*10-10,0,e_max_stamina)
		$base/UI/RichTextLabel.newline()
		$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+" moves closer to you")
		playsound("enemy_movement",2)
		yield(self,"sound_finished")
	elif(minimalid==5):
		distance = clamp(distance+1,e_weapon_unusable_low,10)
		e_stamina = clamp(e_stamina - ((10-e_stat_agility)/10)*10-10,0,e_max_stamina)
		$base/UI/RichTextLabel.newline()
		$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+" moves away from you")
		playsound("enemy_movement",2)
		yield(self,"sound_finished")
	elif(minimalid==10):
		e_stamina = clamp(e_stamina + 0.2*e_max_stamina + 0.6*e_max_stamina*e_stat_stamina/10,0,e_max_stamina)
	
	upd()
	
	if(skip_act==false):
		enemy_act()
	else:
		skip_act=false
		player_movement()

func enemy_movement():
	_hide_act_btn()
	_hide_mov_btn()
	if((distance>=(e_weapon_unusable_low+e_optimal_distance)/2)&&(distance<=(e_weapon_unusable_high+e_optimal_distance)/2)):
		#Optimal distance for attack
		e_stamina = clamp(e_stamina + 0.2*e_max_stamina + 0.6*e_max_stamina*e_stat_stamina/10,0,e_max_stamina)
		enemy_act()
	elif(distance>=e_weapon_unusable_low&&distance<=e_weapon_unusable_high):
		if(randi()%1+0)==0:
			e_stamina = clamp(e_stamina + 0.2*e_max_stamina + 0.6*e_max_stamina*e_stat_stamina/10,0,e_max_stamina)
			enemy_act()
		else:
			move_optimal()
	else:
		move_optimal()

func enemy_act():
	var stamina_left = [0,0,0]
	var i=0;
	var min_acceptable_id=0
	var e_p_atk_mod=1
	if(protected==true):
		e_p_atk_mod=0.5
		protected=false
	
	stamina_left[0] = e_stamina - e_atk_stamina_loss*0.5
	stamina_left[1] = e_stamina - e_atk_stamina_loss
	stamina_left[2] = e_stamina - e_atk_stamina_loss*2
	while(i<3):
		if(stamina_left[i]<0):
			stamina_left[i]=999
		i=i+1
	i=0
	while(i<3):
		if(stamina_left[i]<stamina_left[min_acceptable_id]):
			min_acceptable_id=i
		i=i+1
	if(stamina_left.min()==999):
		min_acceptable_id=10
		
	if(distance<=e_weapon_unusable_high&&distance>=e_weapon_unusable_low):
		if(min_acceptable_id==0):
			p_hp = clamp(p_hp - p_atk*0.65*e_p_atk_mod*e_atk_mod,0,p_max_hp)
			e_stamina = clamp(e_stamina - e_atk_stamina_loss*0.5,0,e_max_stamina)
			$base/UI/RichTextLabel.newline()
			$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+" weakly hits you")
			$base/enemy.set_volume_db(MusicController.volume)
			playsound("random_enemy",0)
		elif(min_acceptable_id==1):
			p_hp = clamp(p_hp - p_atk*e_p_atk_mod*e_atk_mod,0,p_max_hp)
			e_stamina = clamp(e_stamina - e_atk_stamina_loss,0,e_max_stamina)
			$base/UI/RichTextLabel.newline()
			$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+ " hits you")
			$base/enemy.set_volume_db(MusicController.volume+2.5)
			playsound("random_enemy",0)
		elif(min_acceptable_id==2):
			p_hp = clamp(p_hp - p_atk*1.5*e_p_atk_mod*e_atk_mod,0,p_max_hp)
			e_stamina = clamp(e_stamina - e_atk_stamina_loss*2,0,e_max_stamina)
			$base/UI/RichTextLabel.newline()
			$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+ " strongly hits you")
			$base/enemy.set_volume_db(MusicController.volume+5)
			playsound("random_enemy",0)
		elif(min_acceptable_id==10):
			if(p_stamina>((10-p_stat_agility)/10)*35+30+p_atk_stamina_loss*0.5&&distance<=2.5+e_weapon_unusable_high):
				protected==true
				e_stamina = clamp(e_stamina + 0.5*(0.2*e_max_stamina + 0.6*e_max_stamina*e_stat_stamina/10),0,e_max_stamina)
				$base/UI/RichTextLabel.newline()
				$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+" is protecting from your attack")
				$base/player.set_volume_db(MusicController.volume-10)
				playsound("random_enemy",0)
			else:
				e_stamina = clamp(e_stamina + 0.2*e_max_stamina + 0.6*e_max_stamina*e_stat_stamina/10,0,e_max_stamina)
	else:
		if(e_stamina<e_max_stamina*0.5):
			e_stamina = clamp(e_stamina + 0.2*e_max_stamina + 0.6*e_max_stamina*e_stat_stamina/10,0,e_max_stamina)
		else:
			protected==true
			e_stamina = clamp(e_stamina + 0.5*(0.2*e_max_stamina + 0.6*e_max_stamina*e_stat_stamina/10),0,e_max_stamina)
			$base/UI/RichTextLabel.newline()
			$base/UI/RichTextLabel.add_text(str(turn)+": "+e_name+" is protecting from your attack")
			$base/player.set_volume_db(MusicController.volume-10)
			playsound("random_enemy",0)
			
	
	upd()
	player_movement()

func upd():
	#Reset volume
	$base/player.set_volume_db(MusicController.volume)
	$base/enemy.set_volume_db(MusicController.volume)
	#Upd HP
	$base/UI/PlayerHP.value = p_hp
	$base/UI/PlayerHPLabel.text = str(p_hp)
	
	#Upd Stamina
	$base/UI/PlayerStamina.value = p_stamina
	$base/UI/PlayerStaminaLabel.text = str(p_stamina)
	
	#Enemy condition upd
	if(0.9*e_max_hp<=e_hp&&e_hp<=e_max_hp):
		$base/UI/Enemy_condition.text = "EXCELLENT"
		$base/UI/Enemy_condition.add_color_override("font_color",Color(0.223529, 1, 0))
	elif(0.7*e_max_hp<=e_hp&&e_hp<0.9*e_max_hp):
		$base/UI/Enemy_condition.text = "VERY GOOD"
		$base/UI/Enemy_condition.add_color_override("font_color",Color(0.733333, 1, 0))
	elif(0.55*e_max_hp<=e_hp&&e_hp<0.7*e_max_hp):
		$base/UI/Enemy_condition.text = "GOOD"
		$base/UI/Enemy_condition.add_color_override("font_color",Color(0.87451, 1, 0))
	elif(0.4*e_max_hp<=e_hp&&e_hp<0.55*e_max_hp):
		$base/UI/Enemy_condition.text = "COULD BE BETTER"
		$base/UI/Enemy_condition.add_color_override("font_color",Color(1, 0.866667, 0))
	elif(0.2*e_max_hp<=e_hp&&e_hp<0.4*e_max_hp):
		$base/UI/Enemy_condition.text = "BAD"
		$base/UI/Enemy_condition.add_color_override("font_color",Color(1, 0.023529, 0))
	elif(0<e_hp&&e_hp<0.2*e_max_hp):
		$base/UI/Enemy_condition.text = "CLOSE TO DEATH"
		$base/UI/Enemy_condition.add_color_override("font_color",Color(0, 0, 0))
		
	#Distance upd
	if(distance>=0&&distance<1):
		$base/UI/Distance/Distance.text = "0-1 M"
		$base/UI/Distance/Distance.add_color_override("font_color",Color(1, 0.070588, 0))
	elif(distance>=1&&distance<2):
		$base/UI/Distance/Distance.text = "1-2 M"
		$base/UI/Distance/Distance.add_color_override("font_color",Color(1, 0.513726, 0))
	elif(distance>=2&&distance<3):
		$base/UI/Distance/Distance.text = "2-3 M"
		$base/UI/Distance/Distance.add_color_override("font_color",Color(0.968627, 1, 0))
	elif(distance>=3&&distance<6):
		$base/UI/Distance/Distance.text = "3-6 M"
		$base/UI/Distance/Distance.add_color_override("font_color",Color(0.266667, 1, 0))
	elif(distance>=6&&distance<=10):
		$base/UI/Distance/Distance.text = "6-10 M"
		$base/UI/Distance/Distance.add_color_override("font_color",Color(0, 0.486275, 1))
	
	#Player damage effeciency upd
	if(distance>p_weapon_unusable_high||distance<p_weapon_unusable_low):
		$base/btn/atk.disabled = true
		$base/UI/Distance/DamageCondition.text = "NONE"
		$base/UI/Distance/DamageCondition.add_color_override("font_color",Color(0.482353, 0.482353, 0.482353))
	else:
		$base/btn/atk.disabled = false
		if(distance<(p_optimal_distance+p_weapon_unusable_low)/2||distance>(p_optimal_distance+p_weapon_unusable_high)/2):
			$base/UI/Distance/DamageCondition.text = "REDUCED"
			$base/UI/Distance/DamageCondition.add_color_override("font_color",Color(1, 0.984314, 0))
			p_atk_mod=0.75
		elif(distance>=(p_optimal_distance+p_weapon_unusable_low)/2&&distance<=(p_optimal_distance+p_weapon_unusable_high)/2):
			$base/UI/Distance/DamageCondition.text = "OPTIMAL"
			$base/UI/Distance/DamageCondition.add_color_override("font_color",Color(0.733333, 1, 0))
			p_atk_mod=1
		elif(distance==p_optimal_distance):
			$base/UI/Distance/DamageCondition.text = "EXCELLENT!"
			$base/UI/Distance/DamageCondition.add_color_override("font_color",Color(1, 0.023529, 0))
			p_atk_mod=1.2
	
	
	#Enemy damage effeciency upd
	if(distance>e_weapon_unusable_high||distance<e_weapon_unusable_low):
		$base/UI/Distance/EnemyDamageCondition.text = "NONE"
		$base/UI/Distance/EnemyDamageCondition.add_color_override("font_color",Color(0.733333, 1, 0))
	else:
		if(distance<(e_optimal_distance+e_weapon_unusable_low)/2||distance>(e_optimal_distance+e_weapon_unusable_high)/2):
			$base/UI/Distance/EnemyDamageCondition.text = "REDUCED"
			$base/UI/Distance/EnemyDamageCondition.add_color_override("font_color",Color(1, 0.984314, 0))
			e_atk_mod=0.75
		elif(distance>=(e_optimal_distance+e_weapon_unusable_low)/2&&distance<=(e_optimal_distance+e_weapon_unusable_high)/2):
			$base/UI/Distance/EnemyDamageCondition.text = "OPTIMAL"
			$base/UI/Distance/EnemyDamageCondition.add_color_override("font_color",Color(1, 0.866667, 0))
			e_atk_mod=1
		elif(distance==e_optimal_distance):
			$base/UI/Distance/EnemyDamageCondition.text = "EXCELLENT!"
			$base/UI/Distance/EnemyDamageCondition.add_color_override("font_color",Color(0.290196, 1, 0))
			e_atk_mod=1.2
		
	$base/UI/RichTextLabel.scroll_to_line($base/UI/RichTextLabel.get_line_count()-1)
	
	if(p_hp==0):
		get_tree().change_scene(goto_lose)
	elif(e_hp==0):
		get_tree().change_scene(goto_win)
	

func _on_atk_pressed(id):
	var itm_name = $base/btn/atk.get_popup().get_item_text(id)
	var act = false
	var p_p_atk_mod=1
	if(protected==true):
		p_p_atk_mod=0.5
		protected=false
		
	if(itm_name=="Simple Attack"):
		if(p_stamina>p_atk_stamina_loss*0.5):
			e_hp = clamp(e_hp - p_atk*0.65*p_atk_mod*p_p_atk_mod,0,e_max_hp)
			p_stamina = clamp(p_stamina - p_atk_stamina_loss*0.5,0,p_max_stamina)
			act = true
			$base/UI/RichTextLabel.newline()
			$base/UI/RichTextLabel.add_text(str(turn)+ ": " + "You weakly attack "+e_name)
			$base/player.set_volume_db(MusicController.volume)
			_hide_act_btn()
			playsound("sword",2)
			yield(self,"sound_finished")
	elif(itm_name=="Medium Attack"):
		if(p_stamina>p_atk_stamina_loss):
			e_hp = clamp(e_hp - p_atk*p_atk_mod*p_p_atk_mod,0,e_max_hp)
			p_stamina = clamp(p_stamina - p_atk_stamina_loss,0,p_max_stamina)
			act = true
			$base/UI/RichTextLabel.newline()
			$base/UI/RichTextLabel.add_text(str(turn)+ ": " +"You attack "+e_name)
			$base/player.set_volume_db(MusicController.volume+2.5)
			_hide_act_btn()
			playsound("sword",1);
			yield(self,"sound_finished")
	elif(itm_name=="Strong Attack"):
		if(p_stamina>p_atk_stamina_loss*2):
			e_hp = clamp(e_hp - p_atk*1.5*p_atk_mod*p_p_atk_mod,0,e_max_hp)
			p_stamina = clamp(p_stamina - p_atk_stamina_loss*2,0,p_max_stamina)
			act = true
			$base/UI/RichTextLabel.newline()
			$base/UI/RichTextLabel.add_text(str(turn)+ ": " +"You strongly attack "+e_name)
			$base/player.set_volume_db(MusicController.volume+5)
			_hide_act_btn()
			playsound("sword",1);
			yield(self,"sound_finished")
	upd()
	if(act == true):
		enemy_movement()

func _on_act_pressed(id):
	var itm_name = $base/btn/act.get_popup().get_item_text(id)
	if(itm_name=="Relax"):
		p_stamina = clamp(p_stamina + 0.2*p_max_stamina + 0.6*p_max_stamina*p_stat_stamina/10,0,p_max_stamina)
		$base/UI/RichTextLabel.newline()
		$base/UI/RichTextLabel.add_text(str(turn)+ ": " +"You relax, restoring "+str(0.2*p_max_stamina + 0.6*p_max_stamina*p_stat_stamina/10) +" stamina")
	elif(itm_name=="Protect"):
		protected = true
		p_stamina = clamp(p_stamina + 0.5*(0.2*p_max_stamina + 0.6*p_max_stamina*p_stat_stamina/10),0,p_max_stamina)
		$base/UI/RichTextLabel.newline()
		$base/UI/RichTextLabel.add_text(str(turn)+ ": " +"You are protecting from next enemy attack")
	elif(itm_name== "Drink potion"):
		p_hp = clamp(p_hp+0.75*p_max_hp,0,p_max_hp)
		CharacterStats.healing_potion -= 1
		if(CharacterStats.healing_potion==0):
			$base/btn/act.get_popup().remove_item(id)
		$base/UI/RichTextLabel.newline()
		$base/UI/RichTextLabel.add_text(str(turn)+ ": " +"You are drinking healing potion, restoring " + str(0.75*p_max_hp) + " HP")
	elif(itm_name == "Move again"):
		skip_act=true
		player_movement()
	upd()
	if(itm_name!="Move again"):
		enemy_movement()

func _hide_act_btn():
	$base/btn/atk.visible = false
	$base/btn/act.visible = false
	$base/btn/use.visible = false
	
func _show_act_btn():
	$base/btn/atk.visible = true
	$base/btn/act.visible = true
	
func _hide_mov_btn():
	$base/btn/go_backward.visible = false
	$base/btn/go_forward.visible = false
	$base/btn/jump_backward.visible = false
	$base/btn/jump_forward.visible = false
	$base/btn/run_backward.visible = false
	$base/btn/run_forward.visible = false
	$base/btn/skip.visible = false
	
func _show_mov_btn():
	if(p_stamina>((10-p_stat_agility)/10)*10+10):
		$base/btn/go_backward.visible = true
		$base/btn/go_forward.visible = true
	if(p_stamina>((10-p_stat_agility)/10)*35+30):
		$base/btn/jump_backward.visible = true
		$base/btn/jump_forward.visible = true
	if(p_stamina>((10-p_stat_agility)/10)*20+20):
		$base/btn/run_backward.visible = true
		$base/btn/run_forward.visible = true
	$base/btn/skip.visible = true



func _on_run_forward_pressed():
	distance = clamp(distance-6,p_weapon_unusable_low,10)
	p_stamina = clamp(p_stamina - ((10-p_stat_agility)/10)*20-20,0,p_max_stamina)
	$base/UI/RichTextLabel.newline()
	$base/UI/RichTextLabel.add_text(str(turn)+": "+"You are running to the enemy")
	_hide_mov_btn()
	playsound("player_movement",4)
	yield(self,"sound_finished")
	upd()
	enemy_movement()

func _on_run_backward_pressed():
	print("Run backward")
	distance = clamp(distance + 6,p_weapon_unusable_low,10)
	p_stamina = clamp(p_stamina - ((10-p_stat_agility)/10)*20-20,0,p_max_stamina)
	$base/UI/RichTextLabel.newline()
	$base/UI/RichTextLabel.add_text(str(turn)+": "+"You are running from the enemy")
	_hide_mov_btn()
	playsound("player_movement",4)
	yield(self,"sound_finished")
	upd()
	enemy_movement()

func _on_jump_forward_pressed():
	print("Jump forward")
	distance = clamp(distance - 2.5,p_weapon_unusable_low,10)
	p_stamina = clamp(p_stamina - ((10-p_stat_agility)/10)*35-30,0,p_max_stamina)
	$base/UI/RichTextLabel.newline()
	$base/UI/RichTextLabel.add_text(str(turn)+": "+"You are jumping on enemy")
	_hide_mov_btn()
	playsound("player_jump",0)
	yield(self,"sound_finished")
	upd()
	player_act()

func _on_jump_backward_pressed():
	print("Jump backward")
	distance = clamp(distance + 2.5,p_weapon_unusable_low,10)
	p_stamina = clamp(p_stamina - ((10-p_stat_agility)/10)*35-30,0,p_max_stamina)
	$base/UI/RichTextLabel.newline()
	$base/UI/RichTextLabel.add_text(str(turn)+": "+"You are jumping from enemy")
	_hide_mov_btn()
	playsound("player_jump",0)
	yield(self,"sound_finished")
	upd()
	player_act()

func _on_go_forward_pressed():
	print("Go forward")
	distance = clamp(distance - 1,p_weapon_unusable_low,10)
	p_stamina = clamp(p_stamina - ((10-p_stat_agility)/10)*10-10,0,p_max_stamina)
	$base/UI/RichTextLabel.newline()
	$base/UI/RichTextLabel.add_text(str(turn)+": "+"You step nearer to enemy")
	_hide_mov_btn()
	playsound("player_movement",2)
	yield(self,"sound_finished")
	upd()
	player_act()

func _on_go_backward_pressed():
	print("Go backward")
	distance = clamp(distance + 1,p_weapon_unusable_low,10)
	p_stamina = clamp(p_stamina - ((10-p_stat_agility)/10)*10-10,0,p_max_stamina)
	$base/UI/RichTextLabel.newline()
	$base/UI/RichTextLabel.add_text(str(turn)+": "+"You move away from enemy")
	_hide_mov_btn()
	playsound("player_movement",2)
	yield(self,"sound_finished")
	upd()
	player_act()

func _on_skip_pressed():
	p_stamina = clamp(p_stamina + 0.2*p_max_stamina + 0.6*p_max_stamina*p_stat_stamina/10,0,p_max_stamina)
	$base/UI/RichTextLabel.newline()
	$base/UI/RichTextLabel.add_text(str(turn)+": "+"You relax, restoring "+str(0.6*p_max_stamina*p_stat_stamina/10)+" stamina")
	upd()
	player_act()


func _on_VideoPlayer_finished():
		$base/VideoPlayer.set_stream_position(0)
		$base/VideoPlayer.play()

