## Represents a room in the ship.
tool
class_name Room
extends Area2D

## Room size in `TileMap` cells.
# We'll use the setter function to resize the room's collision shapes.
export var size := Vector2.ONE setget set_size

# We store a reference to the ship's `TileMap` to convert from world to map 
# positions and the other way around.
var _tilemap: TileMap = null

## We'll update this node with the `set_size()` setter function.
onready var collision_shape: CollisionShape2D = $CollisionShape2D

## Initializes the room's properties in the `tilemap`'s coordinates.
func setup(tilemap: TileMap) -> void:
	_tilemap = tilemap
	_setup_extents()


func _setup_extents() -> void:
	# Since we run this code in the editor, we first make sure that `_tilemap`
	# is an actual reference to the `TileMap` node.
	if _tilemap != null:
		# `RectangleShape2D.extents` is half the desired rectangle's size.
		collision_shape.shape.extents = 0.5 * _tilemap.map_to_world(size)


## This setter function gets called whenever we change the _Size_ property
## in the _Inspector_.
func set_size(value: Vector2) -> void:
	# This operation ensures the size never goes below `Vector2(1, 1)`.
	for axis in [Vector2.AXIS_X, Vector2.AXIS_Y]:
		# We make sure to not let the value go below 
		size[axis] = max(1, value[axis])
	# Every time we change the size, we update the collision shape's extents.
	_setup_extents()
