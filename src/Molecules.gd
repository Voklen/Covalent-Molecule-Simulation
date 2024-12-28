extends Node2D


func _ready():
	var molecule = load("res://scenes/molecule.tscn")
	randomize()
	for i in 200:
		var instance = molecule.instantiate()
		add_child(instance)
		instance.scale = Vector2(0.05, 0.05)
		instance.position.x = randf_range(-500, 500)
		instance.position.y = randf_range(-300, 300)
		instance.rotation = randf_range(0, 2*PI)


func _process(delta):
	pass
