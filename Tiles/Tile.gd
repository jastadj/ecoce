extends Node2D

var tileDict = {"name":"unk",
				"frame":0,
				"color":Color(1,1,1,1)}



func emit():
	
	var p = get_node("Particles2D")
	p.modulate = tileDict["color"]
	p.set_emitting(true)

func setType(ntype):
	
	var globaldict = Globals._tileDict
	
	tileDict = null
	
	# tile definitions
	for t in globaldict:
		if t["name"] == ntype:
			tileDict = t
			get_node("Sprite").frame = tileDict["frame"]
			name = ntype
	
	if tileDict == null:
		print("Error setting tile type to " + ntype + ", not found in dict")