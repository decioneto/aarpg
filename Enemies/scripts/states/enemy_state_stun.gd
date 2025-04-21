class_name EnemyStateStun extends EnemyState

@export var anim_name: String = "Stun"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

@export_category("AI")
@export var next_state: EnemyState

var _diretion: Vector2
var _animation_finished: bool = false

func init() -> void:
  enemy.enemy_damage.connect(on_enemy_damage)
  pass

func enter() -> void:
  enemy.invulnerable = true
  _animation_finished = false
  _diretion = enemy.global_position.direction_to(enemy.player.global_position)
  enemy.SetDirection(_diretion)
  enemy.velocity = _diretion * -knockback_speed
  enemy.update_animation(anim_name)
  enemy.animation_player.animation_finished.connect(_on_animation_finished)
  pass

func exit() -> void:
  enemy.invulnerable = false
  enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
  pass

#Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> EnemyState:
  if _animation_finished == true:
    return next_state
  
  enemy.velocity -= enemy.velocity * decelerate_speed * _delta
  return null

func _physics(_delta: float) -> EnemyState:
  return null

func on_enemy_damage() -> void:
  enemy.state_machine.ChangeState(self)

func _on_animation_finished(_a: String):
  _animation_finished = true
