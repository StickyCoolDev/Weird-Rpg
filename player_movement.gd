class_name player
extends CharacterBody2D

@export var start_diraction = Vector2(0,1)
@export var SPEED:int = 150

@onready var animation_tree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")


func _ready():
	animation_tree.set("parameters/idle/blend_position", start_diraction)
	Global.inventory = [null, null, null , null ,null]



func _physics_process(delta):
	var direction = Input.get_axis("left" , "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directionr = Input.get_axis("up" , "down")
	if directionr:
		velocity.y = directionr * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	pick_direction()
	Input.get_vector("left", "right", "down", "up")
	update_animation_parameters(Vector2(direction, directionr))

func _on_area_2d_area_entered(area):
	if area.has_method("shop"):
		position =Vector2(1365, 1391)
	if area.has_method("shop1"):
		position = Vector2(624, -197)

func update_animation_parameters(input:Vector2):
	if input == Vector2.ZERO:
		pass
	else:
		animation_tree.set("parameters/idle/blend_position", input)
		animation_tree.set("parameters/walk/blend_position", input)

func pick_direction():
	if velocity == Vector2.ZERO:
		state_machine.travel("idle")
	else:
		state_machine.travel("walk")