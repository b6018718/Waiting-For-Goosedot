extends GutTest

var PlayerObject = load('res://addons/proto_controller/proto_controller.gd')
var BoxOffice = load('res://game/npcs/BoxOffice/box_office.gd')

var player;

func before_each():
	player = partial_double(PlayerObject).new()
	
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
