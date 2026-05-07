extends Entity

@export var input_component: InputComponent
@export var magnetic_component: MagneticComponent

enum Polarity {
	Positive = 1,
	Negative = -1,
	Neutral = 0
}
func _ready() -> void:
	self.magnetic_component.polarity=1

func set_polarity(value:int)->void:
	if magnetic_component and (value==1 or value==0 or value==-1):
		magnetic_component.polarity=value
	else:
		printerr("trying to set a non valid polarity ("+str(value)+")")
		
func switch_polarity() -> void:
	if magnetic_component:
		magnetic_component.polarity = magnetic_component.polarity*-1

	print("Polarity changed to: " + str(magnetic_component.polarity))

func _physics_process(_delta: float) -> void:
	if (input_component):
		var is_pressing_change_polarity = input_component.get_extra_action_pressed(0)

		if (is_pressing_change_polarity):
			switch_polarity()
			
			
func _process(_delta: float) -> void:
	if magnetic_component.polarity==0:
		self.self_modulate=Color(0.0, 0.0, 0.0, 1.0)
	if magnetic_component.polarity==1:
		self.self_modulate=Color(1.0, 0.0, 0.0, 1.0)
