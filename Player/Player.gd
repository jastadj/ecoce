extends Node2D

var panMode = false
var camera
var cameraPos

var panningStart = Vector2(0,0)
var panningOffset = Vector2(0,0)

var cursor

func _ready():
	
	camera = get_node("Camera2D")
	cameraPos = camera.position
	
	cursor = get_node("Cursor")
	#cursor.hide()
	
	set_process_input(true)

func _process(delta):
	
	# if panning, update camera position to pan offset
	if panMode:
		camera.position = cameraPos - panningOffset
		cursor.hide()
	# else draw cursor if cursor is over a valid tile
	else:
		var mousepos = get_global_mouse_position()
		var cpos = Globals.worldToIso(mousepos.x, mousepos.y)
		if get_parent().isValidPosition(cpos.x, cpos.y):
			cursor.setIsoPosition(cpos.x, cpos.y)
			cursor.show()
		else:
			cursor.hide()
		
	

func _input(event):
	
	# if panning with middle mouse button
	if event.is_action("ui_pan"):
		if event.is_pressed():
			panMode = true
			panningStart = get_viewport().get_mouse_position()
			panningOffset = Vector2(0,0)
		else:
			panMode = false
			cameraPos = camera.position
	
	if panMode && event is InputEventMouseMotion:
		panningOffset = get_viewport().get_mouse_position() - panningStart