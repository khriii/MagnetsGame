class_name InputComponent
extends Node

@export_group("Input Actions")
@export var action_left: StringName = "ui_left"
@export var action_right: StringName = "ui_right"
@export var action_up: StringName = "ui_up"
@export var action_down: StringName = "ui_down"

@export_group("Buttons")
@export var action_jump: StringName = "ui_up"
@export var action_use: StringName = "ui_accept"
@export var extra_actions: Array[StringName] = []

func _ready() -> void:
	pass


func get_movement_direction() -> Vector2:
	return Input.get_vector(
		action_left,
		action_right,
		action_up,
		action_down
	)

func get_extra_action_pressed(index: int) -> bool:
	if index >= 0 and index < extra_actions.size():
		return Input.is_action_just_pressed(extra_actions[index])
	return false


func is_using() -> bool:
	return Input.is_action_just_pressed(action_use)


func is_jumping() -> bool:
	return Input.is_action_just_pressed(action_jump)
