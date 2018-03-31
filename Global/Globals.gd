extends Node

const TILE_X = 243
const TILE_Y = 210
const TILE_VECTOR = Vector2(31,17)

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
	
	
