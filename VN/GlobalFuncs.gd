extends Node

func smallest_id(var arr, var arrlen):
	var i=0
	var smallest = 99999
	var smallestid = 99999
	while(i<arrlen):
		if(arr[i]<smallest):
			smallest = arr[i]
			smallestid = i
		i=i+1
	return smallestid
