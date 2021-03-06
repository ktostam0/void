extends KinematicBody2D

var speed : int = Global.enemy_speed
var acceleration : float = 8

var velocity : Vector2 = Vector2.ZERO


func _ready():
	pass


func _process(delta):
	var player_direction : Vector2 = global_position.direction_to(Global.player_position)
	if global_position.distance_to(Global.player_position) > 10000:
		queue_free()
	
	velocity += player_direction * speed * acceleration * delta
	velocity = velocity.normalized() * clamp(velocity.length(), 0, speed)
	
	velocity = move_and_slide(velocity)


func on_hit():
	queue_free()


func _on_PlayerCollision_body_entered(_body):
	get_tree().call_group("player", "on_death")
