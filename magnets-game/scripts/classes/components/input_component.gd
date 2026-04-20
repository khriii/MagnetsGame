class_name InputComponent
extends Node

@export_group("Input Actions")
@export var action_left: StringName = "ui_left"
@export var action_right: StringName = "ui_right"
@export var action_up: StringName = "ui_up"
@export var action_down: StringName = "ui_down"
@export var action_jump: StringName = "ui_up"
@export var action_use: StringName = "ui_accept"

func _ready() -> void:
	pass


func get_movement_direction() -> Vector2:
	return Input.get_vector(
		action_left,
		action_right,
		action_up,
		action_down
	)


func is_using() -> bool:
	return Input.is_action_just_pressed(action_use)


func is_jumping() -> bool:
	return Input.is_action_just_pressed(action_jump)
