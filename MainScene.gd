extends Node2D
@onready var player = $PlayerCharacter
@onready var start = $Start.global_position
@onready var levelComplete = $WinCondition/restart
@onready var levelLost = $LoseCondition/death
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_win_condition_area_entered(area):
	pass # Replace with function body.


func _on_win_condition_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	levelComplete.play()
	await get_tree().create_timer(2.0).timeout
	player.global_position = start



func _on_lose_condition_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	levelLost.play()
	await get_tree().create_timer(2.0).timeout
	player.global_position = start
