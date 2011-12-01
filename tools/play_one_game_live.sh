#!/usr/bin/env sh
./playgame.py -So --player_seed 42 --end_wait=0.25 --verbose --log_dir game_logs --turns 800 --map_file maps/maze/maze_04p_01.map "$@" \
	"ruby ../my_ai/MyBot.rb > error_log.log" \
	"python sample_bots/python/LeftyBot.py" \
	"python sample_bots/python/HunterBot.py" \
	"python sample_bots/python/LeftyBot.py" |
java -jar visualizer.jar
