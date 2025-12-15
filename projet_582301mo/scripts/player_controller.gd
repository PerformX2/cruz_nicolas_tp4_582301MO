extends CharacterBody2D
class_name PlayerController

signal health_changed(new_health_value)

@export var max_health := 3
var current_health := 3
@export var speed = 10.0
@export var jump_power = 12.0
@onready var sfx_jump: AudioStreamPlayer = $sfx_jump
@onready var sfx_hurt: AudioStreamPlayer = $sfx_hurt 
@onready var hud = $CanvasLayer/HUD 
var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
var invincible := false

func _ready():
	current_health = max_health
	
	if hud:
		health_changed.connect(hud.update_lives)
		hud.update_lives(current_health)
	else:
		print("ERROR")

func take_damage(amount := 1):
	if invincible:
		return
	
	sfx_hurt.play()
	current_health -= amount
	current_health = max(current_health, 0)
	
	health_changed.emit(current_health)

	if current_health <= 0:
		die()
	else:
		start_invincibility()

func start_invincibility():
	invincible = true
	await get_tree().create_timer(0.8).timeout
	invincible = false

func die():
	print("Player dead")
	get_tree().call_deferred("reload_current_scene")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
		sfx_jump.play()

	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()
