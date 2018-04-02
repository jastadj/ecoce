extends TextureButton

export(int) var tilenum = 0
var tileButton

func _ready():

	tileButton = get_parent().get_parent().get_node("TileButton")
	

	connect("mouse_entered", self, "mouseEntered")
	connect("mouse_exited", self, "mouseExited")
	connect("pressed", self, "doPressed")

func update():
	get_node("TileSprite").frame = tilenum

func mouseEntered():
	
	modulate = Color(1,1,0,1)
	

func mouseExited():
	
	modulate = Color(1,1,1,1)
	
func doPressed():
	tileButton.value = tilenum
	tileButton.update()
	tileButton.closeMenu()