extends Node2D

# https://alvarber.gitlab.io/pixel-perfection-in-godot.html
export var NATIVE_RES = Vector2(160, 240)
export var WIN_SIZE_SCALE = 3
var vp
var scaling_factor = 1
var trans_ori = Vector2()
var vp_size
var win_size = OS.get_window_size()
#***

func _ready():
	# https://alvarber.gitlab.io/pixel-perfection-in-godot.html
	vp = get_viewport()
	vp.connect("size_changed", self, "on_vp_size_change")
	on_vp_size_change()
	#***
	OS.set_window_size(win_size * WIN_SIZE_SCALE)

func _process(delta):
	vp_size = NATIVE_RES * scaling_factor
	win_size = OS.get_window_size()
	trans_ori = (win_size - vp_size) * 0.5
	
	vp.canvas_transform.origin = trans_ori

func on_vp_size_change():
	# https://alvarber.gitlab.io/pixel-perfection-in-godot.html
	var scale_vector = vp.size / NATIVE_RES
	var new_scaling_factor = max(floor(min(scale_vector[0], scale_vector[1])), 1)

	print(vp_size)
	print(win_size)
	print(trans_ori)
		
	if new_scaling_factor != scaling_factor:
    	scaling_factor = new_scaling_factor
    	var default_transform = Transform2D(Vector2(1, 0), Vector2(0, 1), Vector2())
    	vp.canvas_transform = (default_transform.scaled(Vector2(scaling_factor, scaling_factor)))
	#***