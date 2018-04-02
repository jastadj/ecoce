extends Node2D

var tile_pos_x
var tile_pos_y

var objDict

func setType(tname):
	
	var odict = Globals._objDict
	objDict = null
		
	for o in odict:
		if o["name"] == tname:
				objDict = o
				add_child(load("res://SurfaceObjs/" + o["scene"]).instance())
				name = tname
	
	if objDict == null:
		print("Error setting object type, " + tname + " not found!")
	

func _process(delta):
	
	var mousepos = get_global_mouse_position()
	var tpos = Globals.worldToIso(mousepos.x, mousepos.y)
	
	if tpos.x == tile_pos_x && tpos.y == tile_pos_y:
		get_node("Sprite").modulate = Color(1,1,1,0.3)
	else:
		get_node("Sprite").modulate = Color(1,1,1,1)