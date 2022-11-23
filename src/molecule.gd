extends Node2D

var speed = 0.5

func _ready():
	pass

func get_negative():
	return to_global(get_node("Negative").position)

func get_positive():
	return to_global(get_node("Positive").position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var force_on_negative = Vector2()
	var force_on_positive = Vector2()
	var other_nodes = get_parent().get_children()
	for node in other_nodes:
		if node != self:
#			Negative repulsion
			var neg_neg_displacement = get_negative() - node.get_negative()
			var neg_neg_force = displacement_to_force(neg_neg_displacement)
			force_on_negative += neg_neg_force
#			Negative attraction
			var neg_pos_displacement = get_negative() - node.get_positive()
			var neg_pos_force = displacement_to_force(neg_pos_displacement)
			force_on_negative -= neg_pos_force
	force_on_negative = force_on_negative * delta * speed
	var combined = get_node("Negative").position + force_on_negative
	rotation += combined.angle() * delta * speed
	var new_position = get_negative().move_toward(to_global(combined), 0.5)
	position = self.position.move_toward(new_position, delta * speed)
	print(position)
	

func displacement_to_force(displacement: Vector2):
	return displacement.normalized()
