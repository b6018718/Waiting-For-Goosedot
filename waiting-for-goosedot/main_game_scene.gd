extends Node3D

func _ready() -> void:
	print('Ready')


func _on_clive_looking_at_clive(text: String, personName: String) -> void:
	$UI/Dialog.display_line(text, personName)
