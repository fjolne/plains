extends Node

var score = [0, 0]

func hit(player_id):
	%state.score[1 - player_id] += 1
	$score.text = "%s:%s" % score
