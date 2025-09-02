extends CharacterBody3D

signal lookingAtClive

signal finishedSpeaking

var skipDialogue = true

var personName = 'Clive'
var speechCounter = 0
var clive_can_move = false
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

enum FollowBehaviour {
	DIRECT,
	ASTAR
}

var walkBehaviour = FollowBehaviour.ASTAR

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

func insidePlayerRaycast(_player):
	if (!self.skipDialogue and !self.queue_is_empty()):
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
		if (willDirectWalk()):
			var direction = global_position.direction_to(nav_agent.target_position)
			self.velocity = direction * self.SPEED
		elif (willAStarWalk()):
			var current_location = global_transform.origin
			var next_location = nav_agent.get_next_path_position()
			self.velocity = (next_location - current_location).normalized() * self.SPEED
		self.move_and_slide()
	
func update_target_location(target_location: Vector3):
	# Menacing Clives
	self.look_at(target_location)
	if (willDirectWalk()):
		nav_agent.set_target_position(target_location)
	elif (willAStarWalk()):
		nav_agent.target_position = target_location

func start_moving():
	self.clive_can_move = true
	
func willDirectWalk():
	return (walkBehaviour == FollowBehaviour.DIRECT)
	
func willAStarWalk():
	return (walkBehaviour == FollowBehaviour.ASTAR)
