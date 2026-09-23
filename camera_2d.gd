extends Camera2D

@export var normal_zoom: Vector2 = Vector2(1.0, 1.0)
@export var zoomed_out: Vector2 = Vector2(0.5, 0.5)
@export var zoom_duration: float = 0.8

var zoom_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _animate_zoom(target_zoom: Vector2):
	if zoom_tween and zoom_tween.is_running():
		zoom_tween.kill()
	
	zoom_tween = create_tween()
	zoom_tween.tween_property(self, "zoom", target_zoom, zoom_duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)


func _on_zoom_out_camera_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_animate_zoom(zoomed_out)
		

func _on_zoom_out_camera_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		_animate_zoom(normal_zoom)
