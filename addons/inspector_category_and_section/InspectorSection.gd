# This file is a part of Godot-Haze
# https://github.com/zaevi/godot-haze
extends Container

var label : String
var bg_color : Color

var vbox : VBoxContainer


func _init():
	vbox = VBoxContainer.new()
	.add_child(vbox)


func _notification(what):

	if what == NOTIFICATION_SORT_CHILDREN:

		if not vbox.visible:
			return

		var font = get_font("font", "Tree")
		var arrow : Texture

		if vbox.visible:
			arrow = get_icon("arrow", "Tree")
		else:
			arrow = get_icon("arrow_collapsed", "Tree")
		
		var size = get_size()
		var offset = Vector2()
		offset.y = font.get_height()
		if arrow:
			offset.y = max(offset.y, arrow.get_height())
		
		offset.y += get_constant("vseparation", "Tree")
		offset.x += get_constant("inspector_margin", "Editor")

		var rect = Rect2(offset, size - offset)

		fit_child_in_rect(vbox, rect)

		update()
	
	if what == NOTIFICATION_DRAW:
		var arrow : Texture

		if vbox.visible:
			arrow = get_icon("arrow", "Tree")
		else:
			arrow = get_icon("arrow_collapsed", "Tree")

		var font = get_font("font", "Tree")

		var h = font.get_height()
		if arrow:
			h = max(h, arrow.get_height())
		h += get_constant("vseparation", "Tree")

		var bg = bg_color
		if not bg:
			bg = get_color("prop_subsection", "Editor")
		draw_rect(Rect2(Vector2.ZERO, Vector2(get_size().x, h)), bg)
		
		var arrow_margin = 3
		var color = get_color("font_color", "Tree")
		var EDSCALE = 1
		draw_string(font, Vector2(round((16+arrow_margin) * EDSCALE), font.get_ascent() + (h-font.get_height())/2).floor(), label, color, get_size().x)

		if arrow:
			draw_texture(arrow, Vector2(round(arrow_margin*EDSCALE), (h-arrow.get_height())/2).floor())


func _gui_input(event):
	var e = event as InputEventMouseButton
	if e and e.is_pressed() and e.button_index == BUTTON_LEFT:
		var font = get_font("font", "Tree")
		if e.position.y > font.get_height():
			return
		
		if vbox.visible:
			vbox.hide()
		else:
			vbox.show()


func _get_minimum_size():
	var ms = Vector2()
	
	if vbox.visible:
		ms += vbox.get_combined_minimum_size()
	
	var font = get_font("font", "Tree")
	ms.y += font.get_height() + get_constant("vseparation", "Tree")
	ms.x += get_constant("inspector_margin", "Editor")
	return ms


func unfold():
	vbox.show()
	update()


func fold():
	vbox.hide()
	update()


func add_child(node: Node, legible_unique_name: bool = false):
	vbox.add_child(node, legible_unique_name)
