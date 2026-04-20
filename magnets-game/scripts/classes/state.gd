class_name State
extends Node

signal transitioned(state, new_state)

var entity: Entity


func _ready() -> void:
	await owner.ready
	entity = owner


func enter():
	pass


func exit():
	pass
