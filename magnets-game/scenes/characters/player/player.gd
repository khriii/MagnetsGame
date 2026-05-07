extends Entity

@export var input_component: InputComponent
@export var magnetic_component: MagneticComponent

enum Polarity {
	Positive = 1,
	Negative = -1,
	Neutral = 0
}

func switch_polarity() -> void:
	if (magnetic_component):
		magnetic_component.polarity -=magnetic_component.polarity

	print("Polarity changed to: " + str(magnetic_component.polarity))

func _physics_process(_delta: float) -> void:
	if (input_component):
		var is_pressing_change_polarity = input_component.get_extra_action_pressed(0)

		if (is_pressing_change_polarity):
			switch_polarity()
