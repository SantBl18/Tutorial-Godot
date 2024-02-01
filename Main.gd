extends Node

@export var mobScene: PackedScene
var score: int

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_hit():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout():
	var mob = mobScene.instantiate()
	var mobSpawnLocation = $MobPath/MobSpawnLocation
	mobSpawnLocation.progress_ratio = randf()
	
	var direction = mobSpawnLocation.rotation + PI / 2
	
	mob.position = mobSpawnLocation.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

func _on_score_timer_timeout():
	score += 1



func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

