extends Node


var family : String
var trait : String
var job : String
var motivation : String

var SaveMenu : bool

var FirstLaunch : bool = true

var Intelligence : int
var Agility : int
var Strength : int
var Stamina : int
var Charisma : int
var Luck : int

var TextSpeed = 200
signal exit_menu

#Plater info
var player_hp = 100
var player_stamina = 100


var player_stat_stamina = 5
var player_stat_strength = 5
var player_stat_agility = 5

#Player weapon info
var weapon_atk = 15
var weapon_stamina = 10
var weapon_stat_stamina = 5
var weapon_stat_strength = 5
var weapon_optimal_distance = 1.5
var weapon_unusable_low = 0.5
var weapon_unusable_high = 2

#Battle
var battle_goto_win = "res://assets/Scenes/Scene0/Scene00.tscn"
var battle_goto_lose = "res://assets/Scenes/Scene0/Scene00.tscn"

#Usable
var healing_potion = 1
