extends Node

var tileMap = []
var objectMap = []
var mapWidth = 8
var mapHeight = 16

var tileScene
var tiles

var surfaceObjScene
var surfaceObjects

func _ready():
	
	tileScene = load("res://Tiles/Tile.tscn")
	tiles = get_node("Tiles")
	
	surfaceObjScene = load("res://SurfaceObjs/SurfaceObject.tscn")
	surfaceObjects = get_node("SurfaceObjects")
	
	# init tile map
	tileMap.resize(mapHeight)
	objectMap.resize(mapHeight)
	for y in range(tileMap.size()):
		tileMap[y] = []
		tileMap[y].resize(mapWidth)
		objectMap[y] = []
		objectMap[y].resize(mapWidth)
		
	
	for y in range(mapHeight):
		
		for x in range(mapWidth):
			
			var newtile = tileScene.instance()
			tiles.add_child(newtile)
			
			newtile.z_index = tiles.get_child_count()
			
			newtile.position = Globals.isoToWorld(x,y)
			if x >= 6:
				newtile.setType("water")
			elif x == 5:
				newtile.setType("sand")
			elif x == 0 && y == 0:
				newtile.setType("grass")
			else:
				newtile.setType("mud")
			
			tileMap[y][x] = newtile
			objectMap[y][x] = null
		
	print("TileMap rows : " + str(tileMap.size()) )
	print("TileMap cols : " + str(tileMap[0].size()) )
	
	# test
	addObject(0,0,"tree")

# determine if an iso x,y position is in bounds of game map
func isValidPosition(x,y):
	if x < 0 || x >= mapWidth:
		return false
	if y < 0 || y >= mapHeight:
		return false
		
	return true
	
func convertTile(x,y,tname):
	
	# if tile position is invalid, return
	if !isValidPosition(x,y):
		return
	
	# if tile is already target tile, return
	if tileMap[y][x].tileDict["name"] == tname:
		return
	
	tileMap[y][x].setType(tname)
	
	tileMap[y][x].emit()

func addObject(x,y,objname):
	
	if !isValidPosition(x,y):
		return
	
	if objectMap[y][x] != null:
		return
	
	var pos = Globals.isoToWorld(x,y) + Vector2(0,-32)
	var tileType = tileMap[y][x].tileDict["name"]
	
	var newobj = surfaceObjScene.instance()
	newobj.setType(objname)
	newobj.get_node("Sprite").position = pos
	newobj.z_index = tileMap[y][x].z_index + Globals.MAX_TILES
	newobj.tile_pos_x = x
	newobj.tile_pos_y = y
	
	# object can be placed on tile
	if newobj.objDict["requiresTile"] == tileType || newobj.objDict["requiresTile"] == null:
		surfaceObjects.add_child(newobj)
		objectMap[y][x] = newobj
	else:
		newobj.queue_free()
	
	