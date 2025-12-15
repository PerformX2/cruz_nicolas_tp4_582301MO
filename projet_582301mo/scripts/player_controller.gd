extends CharacterBody2D
class_name PlayerController

# 1. We rename the signal parameter to avoid "Shadowed Variable" warnings
signal health_changed(new_health_value)

@export var max_health := 3
# We initialize this variable, but we don't declare it twice
var current_health := 3

@export var speed = 10.0
@export var jump_power = 12.0
@onready var sfx_jump: AudioStreamPlayer = $sfx_jump

# --- NEW: AUTO-CONNECTION TO HUD ---
# Since your HUD is a child of the Player (inside CanvasLayer), we grab it here.
@onready var hud = $CanvasLayer/HUD 

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
var invincible := false

func _ready():
	current_health = max_health
	
	# --- AUTO-CONNECT LOGIC ---
	# This connects the signal via code. No need to click things in the editor.
	if hud:
		health_changed.connect(hud.update_lives)
		# Send the starting health (3) immediately so HUD updates
		hud.update_lives(current_health)
	else:
		print("ERROR: Could not find HUD! Check if CanvasLayer/HUD exists under Player.")

func take_damage(amount := 1):
	if invincible:
		return

	current_health -= amount
	current_health = max(current_health, 0) # Prevents negative numbers
	
	# Emit the signal with the NEW health value
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
	# --- CRITICAL FIX ---
	# You cannot reload the scene while physics are running (CollisionObject error).
	# call_deferred tells Godot: "Wait 1 frame, then restart."
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
