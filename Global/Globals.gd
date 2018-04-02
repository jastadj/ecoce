extends Node

const TILE_X = 243
const TILE_Y = 210
const TILE_VECTOR = Vector2(31,18)
const MAX_TILES = 512

var _tileDict = [
{"name":"default","frame":0,"color":Color(1,1,1,1)},
{"name":"water","frame":1,"color":Color(0,0,1,1)},
{"name":"grass","frame":2,"color":Color(0,1,0,1)},
{"name":"mud","frame":3,"color":Color(0.56,0.33,0.23,1)},
{"name":"sand","frame":4,"color":Color(1,1,0,1)}]

var _objDict = [
{"name":"tree", "scene":"Tree.tscn", "requiresTile":"grass"}
]

func isoToWorld(x, y):
	var rowPos = TILE_X - TILE_VECTOR.x * y
	var colPos = TILE_Y + TILE_VECTOR.y * y
	return Vector2(rowPos, colPos) + (TILE_VECTOR * x)

func worldToIso(x,y):
	
	# normalize x and y positions to 0,0
	x -= TILE_X
	y -= TILE_Y - 27
	
	# create vector from normalized position
	var newpos = Vector2(x,y)
	
	newpos.x = ((y / TILE_VECTOR.y) + (x / TILE_VECTOR.x))/2
	newpos.y = ((x / TILE_VECTOR.x) - (y / TILE_VECTOR.y))/2
	newpos.y = newpos.y * -1
	
	newpos.x = floor(newpos.x)
	newpos.y = floor(newpos.y)
	
	return newpos
	
	
