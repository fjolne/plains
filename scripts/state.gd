extends Node

var score = [0, 0]

func hit(player_id, points):
	%state.score[1 - player_id] += points
	$score.text = "%s:%s" % score
