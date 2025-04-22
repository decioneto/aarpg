class_name HitBox extends Area2D

signal damage(hurt_box: HurtBox)

func TakeDamage(hurt_box: HurtBox) -> void:
  damage.emit(hurt_box)
