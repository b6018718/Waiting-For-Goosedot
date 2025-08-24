extends Control

@onready var _speaker: Label = $VBoxContainer/Speaker
@onready var _dialogText: RichTextLabel = $VBoxContainer/DialogText

var voices = DisplayServer.tts_get_voices_for_language("en")
#var voices = DisplayServer.tts_get_voices()

# ToDo: Seach for David, add try catches
var cliveVoiceActor = voices[1]
var character_1 = voices[0]

var prevSpokenLine = ''

func display_line(dialog: String, speaker: String = '') -> bool:
	if (self.prevSpokenLine == dialog):
		self.prevSpokenLine = dialog
		return true
		
	if (DisplayServer.tts_is_speaking()):
		return false
		
	self.prevSpokenLine = dialog
	
	self.speak(dialog)
	
	# Display the text on the text box
	_speaker.visible = (speaker != '')
	_speaker.text = speaker + ':'
	_dialogText.text = dialog
	self.open()
	
	return false
	
func speak(text: String):
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(text, cliveVoiceActor)
	
func open():
	#print(voices)
	self.visible = true

func close():
	self.visible = false
	self.prevSpokenLine = ''
