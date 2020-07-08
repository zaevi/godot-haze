# This file is a part of Godot-Haze
# https://github.com/zaevi/godot-haze
extends Control

var icon : Texture
var label : String
var bg_color : Color

var _icon_name : String
var _icon_type : String


func _notification(what):
	
	if what == NOTIFICATION_ENTER_TREE:
		if not icon:
			if has_icon(_icon_name, _icon_type):
				icon = get_icon(_icon_name, _icon_type)
		
		if not bg_color:
			bg_color = get_color("prop_category", "Editor")
	
	if what == NOTIFICATION_DRAW:
		draw_rect(Rect2(Vector2.ZERO, get_size()), bg_color)
		var font = get_font("font", "Tree")
		var hs = get_constant("hseparation", "Tree")
		var w = font.get_string_size(label).x

		if icon:
			w += hs + icon.get_width()
		
		var ofs = (get_size().x - w) / 2
		
		if icon:
			draw_texture(icon, Vector2(ofs, (get_size().y - icon.get_height())/2).floor())
			ofs += hs + icon.get_width()
			
		var color = get_color("font_color", "Tree")
		draw_string(font, Vector2(ofs, font.get_ascent() + (get_size().y - font.get_height())/2).floor(), label, color, get_size().x)


func _get_minimum_size():
	var font = get_font("font", "Tree")
	
	var ms = Vector2(1, font.get_height())
	if icon:
		ms.y = max(icon.get_height(), ms.y)
	ms.y += get_constant("vseparation", "Tree")
	return ms


func set_icon(name : String, type : String = "EditorIcons"):
	_icon_name = name
	_icon_type = type
	if get_tree():
		icon = get_icon(_icon_name, _icon_type)
