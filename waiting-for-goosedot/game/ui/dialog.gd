extends Control

@onready var _speaker: Label = $VBoxContainer/Speaker
@onready var _dialogText: RichTextLabel = $VBoxContainer/DialogText

#var voices = DisplayServer.tts_get_voices_for_language("en")
var voices = DisplayServer.tts_get_voices()

var cliveVoiceActor = voices[1]
var character_1 = voices[0]

var prevSpokenLine = ''

func display_line(dialog: String, speaker: String = ''):
	print(voices)
	if (DisplayServer.tts_is_speaking() || dialog == ''):
		return
	
	self.speak(dialog)
	
	# Display the text on the text box
	_speaker.visible = (speaker != '')
	_speaker.text = speaker + ':'
	_dialogText.text = dialog
	self.open()
	
func speak(text: String):
	if (self.prevSpokenLine != text):
		self.prevSpokenLine = text
		DisplayServer.tts_stop()
		DisplayServer.tts_speak(text, cliveVoiceActor)
	
func open():
	print(voices)
	self.visible = true

func close():
	self.visible = false
	self.prevSpokenLine = ''
