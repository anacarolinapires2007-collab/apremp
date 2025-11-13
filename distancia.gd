extends Node

const WIN_SCREEN = preload("res://venceu.tscn")
const LOSE_SCREEN = preload("res://derrota.tscn")

@onready var player = $player
@onready var meta = $meta
@onready var distance_label = $hud/distancia
@onready var tempo_label = $hud/tempo
@onready var timer = $Timer



var distance_from_start: float = 0.0
var game_over: bool = false

var start_x: float = 0.0
var start_position: Vector2 = Vector2.ZERO
var target_distance: float = 0.0

func _ready():
	game_over = false
	timer.start()
	
	
	if player and meta:
		start_position = player.global_position
		start_x = player.global_position.x
		target_distance = abs(meta.global_position.x - start_x)


func _process(_delta):
	if game_over:
		return
	
	var distance_travelled = abs(player.global_position.x - start_x)
	distance_from_start = distance_travelled
	
	distance_label.text = "%.2f m" % distance_from_start
	tempo_label.text = "%.1f" % timer.time_left

func end_game(won: bool):
	game_over = true
	timer.stop()
	if won:
		get_tree().change_scene_to_packed(WIN_SCREEN)
	else:
		get_tree().change_scene_to_packed(LOSE_SCREEN)

func _on_timer_timeout() -> void:
	
	if distance_from_start <= 1.0:
		end_game(true)
	else:
		end_game(false)
		
func _on_meta_body_entered(body):
	if body == player and not game_over:
		end_game(true)
		
func _on_buraco_body_entered(body: Node2D) -> void:
	if body == player and not game_over:
		timer.stop()
		player._die()
		
		await get_tree().process_frame
		player.global_position = Vector2(-5361.0, -1.0)
		player._reset_state()
		
		timer.start() 

func _on_reiniciatimer_timeout() -> void:
	pass # Replace with function body.
