extends Node

#signals
signal quest_completed(quest:String)
signal new_quest_added(quest:String)

var quests:Dictionary = {
	"collect_sticks":{
		"max":10,
		"current" : 0,
		10 : "collect sticks"
	}
}
var current_quest:String
var active_quests:Array = []
var completed_quests:Array = []


func get_random_quest():
	var key_quests:Array = quests.keys()
	key_quests.shuffle()
	return key_quests


func _process(delta):
	current_quest = active_quests[0]


func add_quests(quests_add : String):
	if quests_add in quests.keys():
		if not quests_add in completed_quests:
			new_quest_added.emit(quests_add)
			active_quests.append(quests_add)
	else:
		Debugger.label.text = "no quest named "+ quests_add + "in Quest DICTIONARY"
		printerr("no quest named "+ quests_add + "in Quest DICTIONARY")


func advance_quests(advance:String):
	if quests[advance]["current"] > quests[advance]["max"]:
		complete_quest(advance)
	else:
		quests[advance]["current"] = quests[advance]["current"] + 10


func complete_quest(complete:String):
	active_quests.erase(complete)
	completed_quests.append(complete)
	print("quest complete")
	quest_completed.emit(complete)
