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
	var other_nodes = get_parent().get_children()
	for node in other_nodes:
		if node != self:
#			Negative repulsion
			var neg_neg_displacement = get_negative() - node.get_negative()
			var neg_neg_force = displacement_to_force(neg_neg_displacement)
			global_force_on_negative += neg_neg_force
#			Negative attraction
			var neg_pos_displacement = get_negative() - node.get_positive()
			var neg_pos_force = displacement_to_force(neg_pos_displacement)
			global_force_on_negative -= neg_pos_force
#			Positive attraction
			var pos_pos_displacement = get_positive() - node.get_positive()
			var pos_pos_force = displacement_to_force(pos_pos_displacement)
			global_force_on_positive += pos_pos_force
#			Positive attraction
			var pos_neg_displacement = get_positive() - node.get_negative()
			var pos_neg_force = displacement_to_force(pos_neg_displacement)
			global_force_on_positive -= pos_neg_force
	global_force_on_negative *= delta * speed
	var local_combined_position = get_node("Negative").position + global_force_on_negative
	var new_rotation = get_node("Negative").position.angle_to(local_combined_position)
	rotate(new_rotation)
	position += get_node("Negative").position.move_toward(local_combined_position, 0.5) - get_node("Negative").position
	
	global_force_on_positive *= delta * speed
	local_combined_position = get_node("Positive").position + global_force_on_positive
	new_rotation = get_node("Positive").position.angle_to(local_combined_position)
	rotate(new_rotation)
	position += get_node("Positive").position.move_toward(local_combined_position, 0.5) - get_node("Positive").position


func displacement_to_force(displacement: Vector2):
	return displacement.normalized()
