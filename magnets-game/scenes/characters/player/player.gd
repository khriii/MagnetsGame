extends Entity

@export var input_component: InputComponent
@export var magnetic_component: MagneticComponent

enum Polarity {
	Positive = 1,
	Negative = -1,
	Neutral = 0
}

func change_polarity() -> void:
	if (magnetic_component):
		if (magnetic_component.polarity == Polarity.Positive):
			magnetic_component.polarity = Polarity.Negative
		elif (magnetic_component.polarity == Polarity.Negative):
			magnetic_component.polarity = Polarity.Positive
	
	print("Polarity changed to: " + str(magnetic_component.polarity))


func _physics_process(_delta: float) -> void:
	if (input_component):
		var is_pressing_change_polarity = input_component.get_extra_action_pressed(0)

		if (is_pressing_change_polarity):
			change_polarity()



