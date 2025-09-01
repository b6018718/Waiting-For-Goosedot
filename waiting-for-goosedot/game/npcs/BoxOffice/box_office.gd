extends CSGBox3D

var userHasTickets = false

func insidePlayerRaycast(player):
	self.giveTicket(player)

func giveTicket(player):
	if  !player.getUserHasTickets():
		player.setUserHasTickets(true)
