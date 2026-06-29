extends CharacterBody2D

@onready var death_timer: Timer = $DeathTimer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

var box_fragments = preload("res://assets/textures/box_fragments.png")
var ins_fragment = preload("res://scenes/fragment.tscn")

var is_holding: bool = false
var dead: bool = false

func _physics_process(delta: float) -> void:
	up_direction = Vector2(0, -1) if global.gravity_scale == 1 else Vector2(0, 1)
	
	if not is_on_floor():
		velocity += get_gravity() * global.gravity_scale * delta
		
	if not is_holding or not is_on_floor():
		velocity.x = 0.0
	
	move_and_slide()

func _on_death_trigger_body_entered(body: Node2D) -> void:
	if body != get_node(".") and !dead:
		dead = true
		sprite.visible = false
		collision_shape.queue_free()
		set_physics_process(false)
		for i in range(7):
			var fragment: Node2D = ins_fragment.instantiate()
			fragment.frag_index = i
			add_child(fragment)
		death_timer.start()
		await death_timer.timeout
		queue_free()
