extends Node2D

var tileDict = {"name":"unk",
				"frame":0,
				"color":Color(1,1,1,1)}

func emit():
	
	var p = get_node("Particles2D")
	p.modulate = tileDict["color"]
	p.set_emitting(true)

func setType(ntype):
	
	# tile definitions
	match ntype:
		"water":
			get_node("Sprite").frame = 1
		"grass":
			get_node("Sprite").frame = 2
			tileDict["color"] = Color(0,1,0,1)
		"mud":
			get_node("Sprite").frame = 3
		"sand":
			get_node("Sprite").frame = 4
		_:
			get_node("Sprite").frame = 0
			print("Unknown tile type " + ntype)
	
	name = ntype
	tileDict["name"] = ntype