class_name MovementComponent
extends Node2D

@export var speed: float = 200.0
@export var gravity: float = 200.0
@export var friction: float = 1500.0
@export var acceleration: float = 500.0
@export var entity: Entity


# Applies movement to a certain entity. Requires delta
func move(direction: Vector2, delta: float) -> void:
	if not entity: 
		printerr("entity is null")
		return
	
	# Handle x axis movement
	if direction:
		entity.velocity.x = move_toward(entity.velocity.x, speed * direction.x, acceleration * delta)
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0, friction * delta)
	
	# Handle y axis movement (Gravity)
	if not entity.is_on_floor():
		entity.velocity.y += gravity * delta

	entity.move_and_slide()


func _ready() -> void:
	if not entity:
		printerr("entity is null")
