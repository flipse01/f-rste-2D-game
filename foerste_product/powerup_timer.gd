extends Timer

var PowerUpDiff = preload("res://icon.svg")


func _on_timeout() -> void:
	randomize()
	var PowerUps = [PowerUpDiff]
	var kinds = PowerUps[randi()% PowerUps.size()]
	var PowerUp = kinds.instance()
	PowerUp.position = Vector2(randi_range(10,720), randi_range(10,470))
	add_child(PowerUp)
	wait_time = randi_range(0,1)
