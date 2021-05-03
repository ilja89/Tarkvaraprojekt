extends Node

var choices : Dictionary
var endings : Dictionary


func _ready():
	choices = {
		"village_steal": false,
		"village_tavern_hungry": false,
		"village_work": false,
		"village_steal_wallet": false,
		"village_tavern_beer": false,
		"village_necromancer": false,
		"tavern_accomplice_friend": false,
		"lich_sword": false,
		"town_walk": false,
	}
	endings = {
			"0": false,
			"1": false,
			"2": false,
			"3": false,
			"4": false,
			"5": false,
			"6": false,
			"7": false,
			"8": false,
			"9": false,
			"10": false,
			"11": false,
			"12": false,
			"13": false,
			"14": false,
			"15": false,
			"16": false,
			"17": false,
			"18": false,
			"19": false,
			"20": false,
			"21": false,
			"22": false,
			"23": false,
			"24": false,
			"25": false,
			"26": false,
			"27": false,
			"28": false,
			"29": false,
			"30": false,
			"31": false,
			"32": false,
			"33": false,
			"34": false,
			"35": false,
			"36": false,
			"42": false,
			"43": false,
			"46": false,
			"47": false,
			"48": false,
			"49": false,
			"50": false,
			"51": false,
			"52": false,
			"53": false,
			"54": false,
			"55": false,
			"56": false,
			"57": false,
			"58": false,
		} 

func numofendings():
	var sum = 0
	for i in endings:
		if endings[i] == true:
			sum += 1
	return sum

func clear():
	for i in endings:
		endings[i] = false
