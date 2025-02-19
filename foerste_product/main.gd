extends Node

@export var Mob_scene: PackedScene
var score

func _ready() -> void:
	pass

func game_over() -> void:
	$ScoreTimer.stop()
	$MOBTimer.stop()
	$Musik.stop()
	$"Death sound".play()
	$HUD.show_game_over()

func NewGame() -> void:
	score = 0
	$player.start($PlayerStart.position)
	$StartTimer.start()
	$Musik.play()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
	$MOBTimer.set_wait_time(0.75 - 0.01 * score)


func _on_start_timer_timeout() -> void:
	$MOBTimer.start()
	$ScoreTimer.start()


func _on_mob_timer_timeout() -> void:
	var mob = Mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpownLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
