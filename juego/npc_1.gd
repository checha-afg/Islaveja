extends StaticBody2D

@export var nombre = "NPC"
@export var dialogo = "¡Hola! Soy un personaje."

var jugador_cercano = null  # Guarda el jugador que está cerca
var DialogueScene = preload("res://npc1_dialogue_box.tscn") # Ajusta la ruta a tu escena real

func _ready():
	$AnimatedSprite2D.play("default")
	
	# Conecta las señales del Area2D hijo
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D: # cualquier jugador que sea CharacterBody2D
		jugador_cercano = body
		jugador_cercano.npc_cercano = self

func _on_body_exited(body):
	if body is CharacterBody2D:
		jugador_cercano = null
		body.npc_cercano = null


func mostrar_dialogo(_texto: String = ""): # recibe argumento pero no lo usa
	print("Instanciando diálogo...") #debug
	var dialogue_instance = DialogueScene.instantiate()
	get_tree().current_scene.add_child(dialogue_instance)
