extends Node2D

var tile_pos_x
var tile_pos_y

var objDict = {"name":"unk",
					  "requiresTile":null}

func setType(tname):
	
	match tname:
		"tree":
			add_child(load("res://SurfaceObjs/Tree.tscn").instance())
			objDict["requiresTile"] = "grass"
		_:
			print("Error setting obj type: unknown type " + tname)
	
	name = tname;
	objDict["name"] = tname
	
	

func _process(delta):
	
	var mousepos = get_global_mouse_position()
	var tpos = Globals.worldToIso(mousepos.x, mousepos.y)
	
	if tpos.x == tile_pos_x && tpos.y == tile_pos_y:
		get_node("Sprite").modulate = Color(1,1,1,0.3)
	else:
		get_node("Sprite").modulate = Color(1,1,1,1)