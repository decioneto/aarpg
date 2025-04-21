class_name EnemyState extends Node

var enemy: Enemy
var state_machine = EnemyStateMachine

func init() -> void:
  pass

func enter() -> void:
  pass

func exit() -> void:
  pass

#Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> EnemyState:
  return null

func _physics(_delta: float) -> EnemyState:
  return null