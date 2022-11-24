extends Node2D

var speed = 50

func _ready():
	pass

func get_negative():
	return to_global(get_node("Negative").position)

func get_positive():
	return to_global(get_node("Positive").position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var global_force_on_negative = Vector2()
	var global_force_on_positive = Vector2()
	var displacement
	var force
	
	var other_nodes = get_parent().get_children()
	for node in other_nodes:
		if node == self:
			continue
		# Negative repulsion
		displacement = get_negative() - node.get_negative()
		force = displacement_to_force(displacement)
		global_force_on_negative += force
		# Negative attraction
		displacement = get_negative() - node.get_positive()
		force = displacement_to_force(displacement)
		global_force_on_negative -= force
		# Positive repulsion
		displacement = get_positive() - node.get_positive()
		force = displacement_to_force(displacement)
		global_force_on_positive += force
		# Positive attraction
		displacement = get_positive() - node.get_negative()
		force = displacement_to_force(displacement)
		global_force_on_positive -= force
	
	global_force_on_negative *= delta * speed
	global_force_on_positive *= delta * speed
	
	apply_force(global_force_on_negative, get_node("Negative").position)
	apply_force(global_force_on_positive, get_node("Positive").position)


func displacement_to_force(displacement: Vector2):
	return displacement.normalized()

func apply_force(global_force: Vector2, local_position: Vector2):
	var local_combined_position = local_position + global_force
	var new_rotation = local_position.angle_to(local_combined_position)
	rotate(new_rotation)
	position += local_position.move_toward(local_combined_position, 0.5) - local_position
