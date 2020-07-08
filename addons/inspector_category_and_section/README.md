# InspectorCategory & InspectorSection

GDScript implements of `EditorInspectorCategory` and `EditorInspectorSection`.

Main scripts are `InspectorCategory.gd` and `InspectorSection.gd`

![preview](https://user-images.githubusercontent.com/12966814/86904140-da23c100-c142-11ea-9b96-346597b75d99.png)

## Usage

```GDScript
extends EditorInspectorPlugin

# ...

func parse_begin(object):
	var category = preload("InspectorCategory.gd").new()
	category.label = "InspectorCategory"
	category.set_icon("GDScript") # lazy load so no need editor theme here!
	add_custom_control(category)
	
	var section = preload("InspectorSection.gd").new()
	section.label = "InspectorSection"
	add_custom_control(section)
	
    # add controls into section
	var label = Label.new()
	label.align = Label.ALIGN_CENTER
	label.text = str(object)
	section.add_child(label)
	
	var button = Button.new()
	button.text = "Press"
	section.add_child(button)

```

Note: EditorProperty must be added via `add_property_editor` method, or it's going to lose its function. So you shouldn't add EditorProperty into InspectorSection.