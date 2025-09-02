extends Node3D

var cliveHasPlayedMusic = false

@onready var player = $Player
@onready var foyerDoubleDoors = %FoyerDoubleDoors
@onready var hallwayDoubleDoors = %HallwayDoubleDoors
@onready var navRegion = %NavigationRegion3D

func _ready() -> void:
	print('Starting game...')
	
func _physics_process(_delta):
	get_tree().call_group("npcs", "update_target_location", self.player.global_transform.origin)
	
func _on_player_player_got_tickets() -> void:
	self.foyerDoubleDoors.open()
	self.hallwayDoubleDoors.open()
	self.foyerDoubleDoors.playSound()
	await get_tree().create_timer(5).timeout
	navRegion.bake_navigation_mesh(0)
	
func areFoyerHallwayDoorsOpen() -> bool:
	return self.foyerDoubleDoors.isOpen() and self.hallwayDoubleDoors.isOpen()

func _on_clive_looking_at_clive(text: String, personName: String) -> void:
	var displayedLastFrame = $UI/Dialog.display_line(text, personName)
	# TTS Starts speaking on the previous frame, so increment on the next frame when it's started talking
	if (DisplayServer.tts_is_speaking() && displayedLastFrame):
		$Clive.incrementSpeech()

func _on_clive_finished_speaking() -> void:
	if !$MusicalMusic.playing && !self.cliveHasPlayedMusic && !DisplayServer.tts_is_speaking():
		$Clive.start_moving()
		self.cliveHasPlayedMusic = true
		$MusicalMusic.play()
