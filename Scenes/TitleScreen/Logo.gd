extends Position2D

var step_size: float = 0.1
var current_step: float = 0
var amplitude :float = 25.0
var speed: float = 0.2
var swing_offset: float = 2
var letters := {}
var y_offsets := {}


func _ready():
	letters = {
		$TopRow/A : 0, 
		$TopRow/d : 1, 
		$TopRow/v : 2, 
		$TopRow/e : 3, 
		$TopRow/n : 4, 
		$BotRow/D : 5, 
		$BotRow/o : 6, 
		$BotRow/d2 : 7, 
		$BotRow/g : 8,
		$BotRow/E : 9
	}
	y_offsets = {
		$TopRow/A : 0, 
		$TopRow/d : 0, 
		$TopRow/v : 0, 
		$TopRow/e : 0, 
		$TopRow/n : 0, 
		$BotRow/D : 10, 
		$BotRow/o : 10, 
		$BotRow/d2 : 10, 
		$BotRow/g : 10,
		$BotRow/E : 10
	}


func _process(delta):
	if current_step >= 20 * PI / speed:
		current_step = 0.0
	current_step += step_size
	for letter in letters:
		letter.position.y =  y_offsets[letter] + amplitude * sin(
			(current_step + letters[letter]) * swing_offset * speed
		)
