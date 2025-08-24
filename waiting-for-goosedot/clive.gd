extends Node3D

signal lookingAtClive

var personName = 'Clive'

func _on_clive_rect_obj_looking_at_clive(text) -> void:
	emit_signal("lookingAtClive", text, personName)
