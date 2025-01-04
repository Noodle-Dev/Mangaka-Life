extends Label

func AssignChapterName(Ch_Name : String):
	var chapter_str = Ch_Name
	$".".text = str(chapter_str)
	print("Changed name succesfully")
