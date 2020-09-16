extends Line2D
#__LOVE__BALANCE__RHYTHM____
var trail_length = 10
class_name circle
var time
var dir
var perpendicular
var amplitude
#____new variables
var shape_pos
onready var FREQ = 3.3
var FREQ_value
var slider_value_y
var slider_value_x
var slider_value_trail
var y_pulse = 0.23
var x_pulse = 20.360
var remove_point = 0



func _ready():
	pass # Replace with function body.

func _process(delta):
	#__Slider Controls___
	slider_value_x = get_node("../Node/Control/HSlider").get_value() 
	x_pulse = slider_value_x
	
	
	slider_value_y = get_node("../Node/Control/VSlider").get_value() 
	y_pulse = slider_value_y
	
	slider_value_trail = get_node("../Node/Control/HSlider2").get_value() 
	trail_length = slider_value_trail
	
	FREQ_value = get_node("../Node/Control/HSlider3").get_value() 
	FREQ = FREQ_value
	
	var remove_point_value_A = get_node("../Node/Control/HSlider4").get_value() 
	remove_point = remove_point_value_A
	
	# Change this Global Position back to 0,0 if you plan to use this scene as child
	global_position = Vector2(500,300)
	shape_pos = get_parent().position
	
	add_point(shape_pos)
	set_joint_mode(1)
	set_round_precision(210)
	

	while get_point_count() > trail_length:
		remove_point(0)
		remove_point(remove_point)


	for i in range(0, points.size(), 1):
		
		if i != 0:                                                #______________x_pulse __y_pulse
			dir = get_point_position(i)-get_point_position(i-1) * (Vector2(x_pulse, y_pulse)/FREQ ) 
			dir = dir.normalized()
		else:
			dir = Vector2(0,0)
			
		perpendicular = Vector2(dir.y,- dir.x)
		amplitude = i*sin(OS.get_system_time_secs()/6000000)*FREQ
		
		set_point_position(i, Vector2(get_point_position(i)+(amplitude*perpendicular))) 
		
		pass

func freq_up():
	FREQ = 0.54
	
func freq_down():
	FREQ = 0.03


func _on_HSlider_value_changed(value):
	get_node("../Node/Control/x_pulse").set_text("X_Pulse:" +str(slider_value_x))
	print(value)


func _on_VSlider_value_changed(value):
	get_node("../Node/Control/y_pulse").set_text("Y_Pulse:" +str(slider_value_y))
#	print(value)


func _on_HSlider2_value_changed(value):
	get_node("../Node/Control/trail").set_text("Trail:" +str(trail_length))


func _on_HSlider3_value_changed(value):
	get_node("../Node/Control/FREQ").set_text("FREQ:" +str(FREQ_value))


func _on_HSlider4_value_changed(value):
	get_node("../Node/Control/remove_pt_1").set_text("REMOVE PT A:" +str(remove_point))
