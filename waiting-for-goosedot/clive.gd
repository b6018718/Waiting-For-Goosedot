extends CharacterBody3D

signal lookingAtClive

signal finishedSpeaking

var personName = 'Clive'
var speechCounter = 0
var clive_can_move = false
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

var speech = [
	"Oh I'm so excited to see Looking for Alaska 2, the sequel to the award winning young adult fiction novel written by my favourite author John Green.",
	"I just can't wait to see if they find Alaska.",
	"In a metaphorical sense.",
	"Or a literal one, who knows!",
	"I've heard the sequel focuses on Lara Buterskya as the main character.",
	"I'm expecting it to be a deconstruction of the #genre, you know what I mean?"
]


func incrementSpeech():
	self.speechCounter = self.speechCounter + 1

func insidePlayerRaycast():
	if (!self.queue_is_empty()):
		emit_signal("lookingAtClive", self.speech[self.speechCounter], self.personName)
	else:
		emit_signal("finishedSpeaking")
		
		
func queue_is_empty() -> bool:
	return (self.speechCounter >= self.speech.size())
	

# Navigation
var SPEED = 0.5

func _physics_process(_delta: float) -> void:
	#Unit vector pointing at the target position from the characters position
	if (self.clive_can_move):
		var direction = global_position.direction_to(nav_agent.target_position)
		
		self.velocity = direction * self.SPEED
		self.move_and_slide()
	
func update_target_location(target_location: Vector3):
	# Menacing Clives
	self.look_at(target_location)
	nav_agent.set_target_position(target_location)

func start_moving():
	self.clive_can_move = true
