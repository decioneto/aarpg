class_name EnemyStateDestroy extends EnemyState

@export var anim_name: String = "Destroy"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

@export_category("AI")

var _diretion: Vector2

func init() -> void:
  enemy.enemy_destroyed.connect(on_enemy_destroy)
  pass

func enter() -> void:
  enemy.invulnerable = true
  _diretion = enemy.global_position.direction_to(enemy.player.global_position)
  enemy.SetDirection(_diretion)
  enemy.velocity = _diretion * -knockback_speed
  enemy.update_animation(anim_name)
  enemy.animation_player.animation_finished.connect(_on_animation_finished)
  pass

func exit() -> void:
  pass

#Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> EnemyState:
  enemy.velocity -= enemy.velocity * decelerate_speed * _delta
  return null

func _physics(_delta: float) -> EnemyState:
  return null

func on_enemy_destroy() -> void:
  enemy.state_machine.ChangeState(self)

func _on_animation_finished(_a: String):
  enemy.queue_free()
