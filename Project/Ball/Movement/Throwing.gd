extends State

const TIME_TO_RECHARGE = 0.1
const MAX_DISTANCE = 170
var timer : float

func enter(_args):
	owner.player.movement.update_state("Falling")
	
	timer = 0

func run(delta):
	
	if(root_state.velocity == Vector2(0, 0)):
		return ["Default", false]
	
	if(Input.is_action_just_released("throw_ball")):
		return ["Default", false]

	#if throw ball is held long enough, revert to a charging state
	if(Input.is_action_pressed("throw_ball")):
		timer += delta
	else:
		timer = 0
	
	if(timer >= TIME_TO_RECHARGE):
		return ["Default", false]
		
	if(owner.to_player().length() >= MAX_DISTANCE):
		return ["Default", false]
	
	if(Input.is_key_pressed(KEY_X)):
		owner.player.movement.update_state("Swinging")	#force player into swinging state
		return ["Default", true]