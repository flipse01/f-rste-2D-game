extends Area2D
signal hit
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	hide()
func _process(delta: float) -> void:
	var Velocity = Vector2.ZERO
	if Input.is_action_pressed("Up"):
		Velocity.y -= 1
	if Input.is_action_pressed("Ned"):
		Velocity.y += 1
	if Input.is_action_pressed("Højre"):
		Velocity.x += 1
	if Input.is_action_pressed("Venstre"):
		Velocity.x -= 1
	if Velocity.length() > 0:
		Velocity = Velocity.normalized() * speed
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.stop()
	if Velocity.x != 0:
		animated_sprite_2d.animation = "Walk"
		animated_sprite_2d.flip_v = false
		animated_sprite_2d.flip_h = Velocity.x < 0
	elif Velocity.y != 0:
		animated_sprite_2d.animation = "Up"
		animated_sprite_2d.flip_v = Velocity.y > 0
	position += Velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
