extends CanvasLayer

var hearts: Array[HeartGUI] = []

#Called when the node enters the scene tree for the first time.
func _ready():
  for child in $Control/HFlowContainer.get_children():
    if child is HeartGUI:
      hearts.append(child)
      child.visible = false
  pass

func update_hp(_hp: int, _maxHp: int) -> void:
  update_max_hp(_maxHp)
  for i in _maxHp:
    update_heart(i, _hp)

  pass

func update_heart(_index: int, _hp: int) -> void:
  var _value: int = clampi(_hp - _index * 2, 0, 2);
  hearts[_index].value = _value
  pass

func update_max_hp(_maxHp: int) -> void:
  var _heart_count: int = roundi(_maxHp * 0.5)
  for i in hearts.size():
    if i < _heart_count:
      hearts[i].visible = true
    else:
      hearts[i].visible = false
  pass
