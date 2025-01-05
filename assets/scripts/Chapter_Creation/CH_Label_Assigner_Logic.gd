extends Label

func AssignChapterName(target_node: Node, Ch_Name : String):
	if self == target_node:
		$".".text = Ch_Name
		print("Changed name successfully")
