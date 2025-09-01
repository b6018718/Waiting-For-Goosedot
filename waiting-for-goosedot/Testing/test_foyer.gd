extends GutTest

var PlayerObject = load('res://addons/proto_controller/player.gd')
var BoxOffice = load('res://game/npcs/BoxOffice/box_office.gd')
var Door = load('res://game/npcs/DoubleDoors/Door/door_container.gd')
var DoorScene = load('res://game/npcs/DoubleDoors/Door/door.tscn')
var WorldScript = load('res://main_game_scene.gd')
var World = load('res://MainGameScene.tscn')

var player;

func before_each():
	player = partial_double(PlayerObject).new()
	
func start_world():
	return await start_scene(World)
	
func start_scene(Scene):
	var sceneInstance = Scene.instantiate()
	add_child(sceneInstance)
	await wait_until(func ():
		return sceneInstance.is_inside_tree()
	, 5)
	return sceneInstance
	
func test_player_starts_with_no_tickets():
	assert_eq(player.getUserHasTickets(), false)

func test_player_can_interact_with_box_office():
	var office = partial_double(BoxOffice).new()
	stub(player, '_getSightCollision').to_return(office)
	player.checkCollision()
	assert_called(office, 'insidePlayerRaycast')
	
func test_player_can_get_ticket_from_office():
	var office = partial_double(BoxOffice).new()
	office.insidePlayerRaycast(player)
	assert_eq(player.getUserHasTickets(), true)
	
func test_player_can_not_get_tickets_twice():
	var office = partial_double(BoxOffice).new()
	office.insidePlayerRaycast(player)
	office.insidePlayerRaycast(player)
	assert_eq(player.getUserHasTickets(), true)

func test_player_emits_user_got_tickets():
	watch_signals(player)
	var office = partial_double(BoxOffice).new()
	office.insidePlayerRaycast(player)
	assert_signal_emitted(player, 'playerGotTickets')
	
func test_door_starts_closed():
	var door = partial_double(Door).new()
	assert_eq(door.isOpen(), false)
	
func test_door_can_open():
	var doorScene = await self.start_scene(self.DoorScene)
	doorScene.open()
	assert_eq(doorScene.isOpen(), true)
	
func test_foyer_world_door_starts_closed():
	var worldInstance = await self.start_world()
	assert_eq(worldInstance.areFoyerHallwayDoorsOpen(), false)
	
func test_door_opens_on_player_got_tickets():
	var worldInstance = await self.start_world()
	worldInstance._on_player_player_got_tickets()
	assert_eq(worldInstance.areFoyerHallwayDoorsOpen(), true)
