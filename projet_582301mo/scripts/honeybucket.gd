extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var sfx = $sfx_honey_pickedup

var is_collected = false

func _ready():
	anim.play("standby")  # default animation
	anim.speed_scale = 0.2   # slower animation

func _on_body_entered(body):
	if body.name == "Player" and not is_collected:
		is_collected = true

		# Play pickup animation (bigger image)
		anim.play("pickedup")
		
		# Play sound
		sfx.play()

		# Animate move & fade
		var tween = create_tween()

		tween.tween_property(self, "position", position + Vector2(0, -30), 0.5)
		tween.tween_property(self, "modulate:a", 0.0, 0.5)

		# Delete object after animation
		tween.tween_callback(self.queue_free)
