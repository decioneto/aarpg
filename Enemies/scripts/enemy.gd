class_name Enemy extends CharacterBody2D

signal DirectionChanged(new_direction: Vector2)
signal enemy_damage(hurt_box: HurtBox)
signal enemy_destroyed(hurt_box: HurtBox)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp: int = 3

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var hit_box: HitBox = $HitBox
@onready var state_machine: EnemyStateMachine = $EnemyStateMachine

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var player: Player
var invulnerable: bool = false

func _ready():
  state_machine.initialize(self)
  player = PlayerManager.player
  hit_box.Damaged.connect(_take_damage)

func _process(_delta):
  pass

func _physics_process(_delta: float) -> void:
  move_and_slide()

func SetDirection(new_direction: Vector2) -> bool:
  direction = new_direction
  if direction == Vector2.ZERO:
    return false

  var direction_id = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
  var new_dir = DIR_4[direction_id]

  if new_dir == cardinal_direction:
    return false

  cardinal_direction = new_dir
  DirectionChanged.emit(new_dir)
  sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1

  return true

func update_animation(state: String) -> void:
  animation_player.play(state + "_" + AnimationDirection())

func AnimationDirection() -> String:
  if cardinal_direction == Vector2.DOWN:
    return "down"
  elif cardinal_direction == Vector2.UP:
    return "up"
  else:
    return "side"

func _take_damage(hurt_box: HurtBox) -> void:
  if invulnerable == true:
    return
  hp -= hurt_box.damage
  if hp > 0:
    enemy_damage.emit(hurt_box)
  else:
    enemy_destroyed.emit(hurt_box)
