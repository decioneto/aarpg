class_name Level extends Node2D

#Called when the node enters the scene tree for the first time.
func _ready():
  self.y_sort_enabled = true
  PlayerManager.set_as_parent(self)
  pass
