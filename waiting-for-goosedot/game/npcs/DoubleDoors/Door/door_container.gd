extends Node3D

var doorIsOpen = false

func isOpen():
	return self.doorIsOpen
	
func open():
	%AnimationPlayer.play("open")
	self.doorIsOpen = true
