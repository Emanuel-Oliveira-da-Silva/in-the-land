extends Inv_Item
class_name  Inv_Consumable

@export var Health : float = 10

func use(player : Player):
	player.life += Health
