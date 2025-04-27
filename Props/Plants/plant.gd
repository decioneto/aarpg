class_name Plant extends Node2D

func _ready() -> void:
  $HitBox.damage.connect(TakeDamage)
  pass

func TakeDamage(_damage: HurtBox) -> void:
  queue_free()
  pass
