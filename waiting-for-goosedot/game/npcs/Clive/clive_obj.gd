extends CSGCombiner3D

signal lookingAtClive 

func interactWithObj():
	emit_signal("lookingAtClive", "What are you looking at?")
