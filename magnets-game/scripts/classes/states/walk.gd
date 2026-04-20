extends State

@export var movement_component: MovementComponent
@export var input_component: InputComponent
@export var animated_sprite: AnimatedSprite2D

func enter():
	animated_sprite.play("walk")


func physics_update(delta):
	var direction = input_component.get_movement_direction()
	
	movement_component.move(direction, delta)
	
	if direction == Vector2.ZERO:
		transitioned.emit(self, "idle")
