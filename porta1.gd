extends Area2D

@export var pergunta: String = "Quanto é 12 + 6?"
@export var resposta_correta: String = "18"

var jogador_na_porta = false
var respondeu = false
var acerto = 0
func _ready():
	$Label.visible = false


func _process(_delta):
	if jogador_na_porta and not respondeu and Input.is_action_just_pressed("ui_accept"):
		perguntar()



func perguntar():
	var resposta = await perguntar_popup(pergunta)

	if resposta == resposta_correta:
		print("Acertou!")
		respondeu = true
		$Label.text = "✔ Correto!"
	else:
		print("Resposta errada!")
		$Label.text = "✘ Errado!"

func perguntar_popup(pergunta_texto: String) -> String:
	var popup = AcceptDialog.new()
	popup.title = "Pergunta"
	popup.dialog_text = pergunta_texto

	# Campo de entrada para o jogador digitar
	var entrada = LineEdit.new()
	entrada.placeholder_text = "Digite sua resposta..."
	popup.add_child(entrada)

	get_tree().root.add_child(popup)
	popup.popup_centered()

	# aguardar confirmação
	await popup.confirmed

	var resposta = entrada.text

	popup.queue_free()
	return resposta
	# coleta resposta do usuário
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		jogador_na_porta = true
		$Label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		jogador_na_porta = false
		$Label.visible = false
