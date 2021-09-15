tool
extends Node2D

onready var tilemap: TileMap = $TileMap
onready var rooms: Node2D = $Rooms


func _ready() -> void:
	for room in rooms.get_children():
		room.setup(tilemap)
