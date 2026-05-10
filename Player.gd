extends CharacterBody2D

var move_speed : float = 100.0
var jump_force : float = 250.0
var gravity : float = 500.0

var pos : Vector2
var old_pos : Vector2
var moving : bool
var score : int = 0
@onready var score_text : Label = get_node("CanvasLayer/ScoreText")
@onready var _animated_sprite = $AnimatedSprite2D
@onready var audio_pickup = $AudioStreamPlayer2D

func _ready():
	old_pos = global_position
	pos = global_position

func _physics_process(delta: float) -> void:
	#set pos to current position
	pos = global_position
	if pos - old_pos:
		moving = true
	else:
		moving = false
	#create old pos from pos
	old_pos = pos
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = 0
	if moving == false:
		_animated_sprite.stop()
		_animated_sprite.play("idle")
		
	if Input.is_action_pressed("left"):
		velocity.x -= move_speed
		_animated_sprite.flip_h = true
		if is_on_floor():
			_animated_sprite.play("run")
		else:
			_animated_sprite.play("jump")
	if Input.is_action_pressed("right"):
		velocity.x += move_speed
		_animated_sprite.flip_h = false
		if is_on_floor():
			_animated_sprite.play("run")
		else:
			_animated_sprite.play("jump")
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	if global_position.y > 100:
		game_over()
	
	move_and_slide()

func add_score(amount):
	score += amount
	score_text.text = str("Score: ", score)

func play_sound1():
	audio_pickup.play()

func game_over():
	get_parent().lives -= 1
	get_tree().reload_current_scene()
