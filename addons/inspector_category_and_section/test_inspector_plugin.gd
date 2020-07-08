extends EditorInspectorPlugin

func can_handle(object):
	return object is Node


func parse_begin(object):
	var category = preload("InspectorCategory.gd").new()
	category.label = "InspectorCategory"
	category.set_icon("GDScript") # lazy
	add_custom_control(category)
	
	var section = preload("InspectorSection.gd").new()
	section.label = "InspectorSection"
	add_custom_control(section)
	
	var label = Label.new()
	label.align = Label.ALIGN_CENTER
	label.text = str(object)
	section.add_child(label)
	
	var button = Button.new()
	button.text = "Press"
	section.add_child(button)
