extends TextureButton

var value = 0

var menuOpen = false
signal open_menu
signal close_menu
signal update_button


var tileSelectorScene
var tileSelectors

func _ready():
	
	tileSelectorScene = load("res://UI/TileSelector.tscn")
	tileSelectors = get_parent().get_node("TileSelectors")
	
	var tdict = Globals._tileDict
	var tcount = 0
	for t in tdict:
		var newsel = tileSelectorScene.instance()
		newsel.tilenum = t["frame"]
		newsel.update()
		newsel.hide()
		tileSelectors.add_child(newsel)
		newsel.rect_position = rect_position + Vector2(0, -12 - 64 - 64 * tcount)
		tcount += 1
	

	connect("mouse_entered", self, "mouseEntered")
	connect("mouse_exited", self, "mouseExited")
	connect("pressed", self, "doPressed")
	
	connect("open_menu",self,"openMenu")
	connect("close_menu", self, "closeMenu")
	connect("update_button", self, "update")

func update():
	get_node("TileSprite").frame = value

func mouseEntered():
	#get_node("TileSprite").modulate = Color(1,1,0,1)
	modulate = Color(1,1,0,1)
	
func mouseExited():
	#get_node("TileSprite").modulate = Color(1,1,1,1)
	modulate = Color(1,1,1,1)

func doPressed():
	if menuOpen == false:
		emit_signal("open_menu")
	else:
		emit_signal("close_menu")


func openMenu():
	for t in tileSelectors.get_children():
		t.show()
	menuOpen = true	

func closeMenu():
	for t in tileSelectors.get_children():
		t.hide()
	menuOpen = false