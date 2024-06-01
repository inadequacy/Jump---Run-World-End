extends StaticBody2D
@onready var _animated_sprite = $PLAAAAAT
@onready var _platform = $CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	_animated_sprite.play("default")
	await get_tree().create_timer(1.0).timeout
	_platform.disabled = true
	 # Replace with function body.
