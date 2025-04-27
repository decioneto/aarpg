@tool
class_name LevelTransition extends Area2D

enum SIDE {LEFT, RIGHT, TOP, BOTTOM}

@export_file("*.tscn") var level
@export var target_transition_area: String = "LevelTransition"
@export_category("Colision Area Settings")
@export_range(1, 12, 1, "or_greater") var size: int = 2:
  set(_v):
    size = _v
    update_area()
@export var side: SIDE = SIDE.LEFT:
  set(_v):
    side = _v
    update_area()
@export var snap_to_grid: bool = false:
  set(_v):
    _snap_to_grid()

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

#Called when the node enters the scene tree for the first time.
func _ready():
  update_area()
  if Engine.is_editor_hint():
    return

  monitoring = false
  place_player()
  await LevelManager.level_loaded
  monitoring = true

  body_entered.connect(_player_entered)
  pass

func _player_entered(_p: Node2D) -> void:
  LevelManager.load_new_level(level, target_transition_area, get_offset())
  pass

func place_player() -> void:
  if name != LevelManager.target_transition:
    return
  
  PlayerManager.set_player_position(global_position + LevelManager.position_offset)

func get_offset() -> Vector2:
  var offset := Vector2.ZERO
  var player_pos := PlayerManager.player.global_position

  if side == SIDE.LEFT || side == SIDE.RIGHT:
    offset.y = player_pos.y - global_position.y
    offset.x = 16
    if side == SIDE.LEFT:
      offset.x *= -1
  else:
    offset.x = player_pos.x - global_position.x
    offset.y = 16
    if side == SIDE.TOP:
      offset.y *= -1

  return offset

func update_area() -> void:
  var new_react: Vector2 = Vector2(32, 32)
  var new_pos: Vector2 = Vector2.ZERO

  if side == SIDE.TOP:
    new_react.x *= size
    new_pos.y -= 16
  elif side == SIDE.BOTTOM:
    new_react.x *= size
    new_pos.y += 16
  elif side == SIDE.LEFT:
    new_react.y *= size
    new_pos.x -= 16
  elif side == SIDE.RIGHT:
    new_react.y *= size
    new_pos.x += 16

  if collision_shape == null:
    collision_shape = get_node("CollisionShape2D")
  
  collision_shape.shape.size = new_react
  collision_shape.position = new_pos

func _snap_to_grid() -> void:
  position.x = round(position.x / 16) * 16
  position.y = round(position.y / 16) * 16
  pass
