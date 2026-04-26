extends Area2D
class_name MagneticComponent

#This component is an area2d and adds functionality for magnetism.
#Basically this component adds properties such as which polarity an object has and how strong it is.
#This component handles itself (and the parent when it needs to move it) without requiring any assistance to other nodes (except for the collision shape it is given)

#Exports
@export_enum("Positive:1","Neutral:0", "Negative:-1") var polarity: int=1
@export var magnetic_strength:float
@export var is_movable:bool
@export var affected_node:Node2D
#other variables
var colliding_magnets: Array[MagneticComponent] = []

func _ready() -> void:
	#TODO: add non selected export variables check
	self.area_entered.connect(on_area_entered)
	self.area_exited.connect(on_area_exited)
	
func _physics_process(delta: float) -> void:
	if self.is_movable==true and self.polarity!=0:
		for magnet in colliding_magnets:
			if magnet.polarity!=0:
				handle_polarity_collision(magnet, delta)

func on_area_entered(area:Area2D):
	if area is MagneticComponent:
		self.colliding_magnets.push_front(area)
	
func on_area_exited(area:Area2D):
	if area is MagneticComponent:
		self.colliding_magnets.erase(area)
		#print(area)

#applies movement to self.affected_node given another MagneticComponent
func handle_polarity_collision(other:MagneticComponent, delta: float)->void:
	if other.polarity==0: return
	#we exit if self is not movable or if the other force is weaker 
	if not is_movable: return
	#var movement_force=self.magnetic_strength-other.magnetic_strength
	var movement_force=other.magnetic_strength
	#if movement_force>=0: return
	
	#we take the absolute value of the movement force (we will combine the direction later)
	movement_force=abs(movement_force)
	
	#we calculate the direction and distance to the other magnet
	var direction_to_other = global_position.direction_to(other.global_position)
	var distance = global_position.distance_to(other.global_position)
	
	#distance shouldn't be lower than 5 (to avoid having the 2 magnets too close to avoid bugs etc..)
	distance = max(distance, 5.0)
	
	#we create a distance multiplier to make the distance between the 2 magnets important
	var distance_multiplier = 100.0 / distance
	var final_force = movement_force * distance_multiplier
	
	#we check polarity to choose whether to move towards or move away from the other magnet
	var movement_direction: Vector2
	if self.polarity != other.polarity:
		movement_direction = direction_to_other
	else:
		movement_direction = -direction_to_other
	
	#print(movement_direction)
	
	#we apply the force to the node based on its type
	if self.affected_node is RigidBody2D:
		affected_node.apply_central_force(movement_direction * final_force)
	elif affected_node is CharacterBody2D:
		affected_node.velocity += movement_direction * final_force * delta
