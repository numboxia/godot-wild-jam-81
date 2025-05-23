extends Area2D

@export var direction: int = 1
@onready var parent: Node2D = $".."
@onready var players_on_it: Array[String] = []
@onready var pad: Sprite2D = $Pad

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("get_player_id"):
			players_on_it.append(body.get_player_id())

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("get_player_id"):
			players_on_it.erase(body.get_player_id())

func _physics_process(delta: float) -> void:
	var is_active = 1 if len(players_on_it) else 0
	# Set triggerer pad color
	pad.modulate = Color(0, 0, 1) if is_active else Color(1, 1, 1)
	if is_active:
		parent.rotatable.rotation_degrees += 50 * delta * direction
