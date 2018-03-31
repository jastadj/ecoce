extends Node

var tileMap = []
var mapWidth = 8
var mapHeight = 16

var tileScene
var tiles

func _ready():
	tileScene = load("res://Tiles/Tile.tscn")
	tiles = get_node("Tiles")
	
	# init tile map
	for y in range(mapHeight):
		
		tileMap.append([])
		
		var row = []
		
		for x in range(mapWidth):
			
			var newtile = tileScene.instance()
			tiles.add_child(newtile)
			
			newtile.z_index = tiles.get_child_count()
			
			newtile.position = Globals.isoToWorld(x,y)
			
			row.append(newtile)
		
		tileMap[y].append(row)

# determine if an iso x,y position is in bounds of game map
func isValidPosition(x,y):
	if x < 0 || x >= mapWidth:
		return false
	if y < 0 || y >= mapHeight:
		return false
		
	return true