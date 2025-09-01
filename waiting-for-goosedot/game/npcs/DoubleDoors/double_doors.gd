extends Node3D

var doorOpen = false

func isOpen():
	return doorOpen;
	
func open():
	%Door.open()
	%Door2.open()
	self.doorOpen = true
	
func playSound():	
	%CreakSound.play()
