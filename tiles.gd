extends Resource

class_name Tile

enum TileType { EMPTY, NUMBER, BOMB }

var type: int = TileType.EMPTY
var number: int = 0
var revealed: bool = false
var pos: Vector2
