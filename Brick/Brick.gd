extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1

func _ready():
	randomize()
	position = new_position
	if score >= 100:
		$ColorRect.color = Color8(24,78,119)
	elif score >= 90:
		$ColorRect.color = Color8(30,96,145)
	elif score >= 80:
		$ColorRect.color = Color8(26,117,159)
	elif score >= 70:
		$ColorRect.color = Color8(22,138,173)
	elif score >= 60:
		$ColorRect.color = Color8(52,160,164)
	elif score >= 50:
		$ColorRect.color = Color8(82,182,154)
	elif score >= 40:
		$ColorRect.color = Color8(118,200,147)
	else:
		$ColorRect.color = Color8(153,217,140)

func _physics_process(_delta):
	if dying:
		queue_free()

func hit(_ball):
	var brick_sound = get_node_or_null("/root/Game/Brick_Sound")
	if brick_sound != null:
		brick_sound.play()
	die()

func die():
	dying = true
	collision_layer = 0
	$ColorRect.hide()
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instance()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
