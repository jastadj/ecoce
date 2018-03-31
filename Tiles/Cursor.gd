extends Node2D

func setIsoPosition(x, y):
	
	var newpos = Globals.isoToWorld(x,y)
	
	position = newpos
