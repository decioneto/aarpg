class_name EnemyStateWander extends EnemyState

@export var anim_name: String = "Walk"
@export var wander_speed: float = 20.0

@export_category("AI")
@export var state_animation_duration: float = 0.5
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 3
@export var next_state: EnemyState

var _timer: float = 0.0
var _diretion: Vector2

func init() -> void:
  pass

func enter() -> void:
  _timer = randi_range(state_cycles_min, state_cycles_max) * state_animation_duration
  var rand = randi_range(0, 3)
  _diretion = enemy.DIR_4[rand]
  enemy.velocity = _diretion * wander_speed
  enemy.SetDirection(_diretion)
  enemy.update_animation(anim_name)
  pass

func exit() -> void:
  pass

#Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> EnemyState:
  _timer -= _delta
  if _timer <= 0:
    return next_state

  return null

func _physics(_delta: float) -> EnemyState:
  return null