extends CharacterBody3D

signal lookingAtClive

signal finishedSpeaking

var personName = 'Clive'
var speechCounter = 0
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

'''
var speech = [
	"Oh I'm so excited to see Looking for Alaska 2, the sequel to the award winning young adult fiction novel written by my favourite author John Green.",
	"I just can't wait to see if they find Alaska.",
	"In a metaphorical sense.",
	"Or a literal one, who knows!",
	"I've heard the sequel focuses on Lara Buterskya as the main character.",
	"I'm expecting it to be a deconstruction of the #genre, you know what I mean?"
]
'''

var speech = [
	"I have to go"
]

func incrementSpeech():
	self.speechCounter = self.speechCounter + 1

func _on_clive_rect_obj_looking_at_clive() -> void:
	if (self.speechCounter < self.speech.size()):
		emit_signal("lookingAtClive", self.speech[self.speechCounter], self.personName)
	else:
		emit_signal("finishedSpeaking")

# Navigation
var SPEED = 0.5

func _physics_process(_delta: float) -> void:
	print(1)
	#var current_location = global_transform.origin
	#var next_location = nav_agent.get_next_path_position()
	#var new_velocity = (next_location - current_location).normalized() * self.SPEED
	
	#self.velocity = Vector3(0.1,0.0,0.0) #new_velocity
	#print(new_velocity)
	
	#var destination = nav_agent.get_next_path_position()
	#var local_destination = destination - global_position
	#var direction = local_destination.normalized()
	
	#self.velocity = direction * SPEED
	
	var target_position: Vector3 #set this to the target coordinate
	var speed: float #set this to whatever you want, 5ish is a good start
	
	#Unit vector pointing at the target position from the characters position
	#var direction = global_position.direction_to(nav_agent.target_position)
	var direction = Vector3(0,0,0)
	
	self.velocity = direction * speed
	self.move_and_slide()
	
func update_target_location(target_location: Vector3):
	target_location = Vector3(0,0,0)
	nav_agent.set_target_position(target_location)
