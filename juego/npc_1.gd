extends StaticBody2D

@export var nombre = "NPC1"
@export var dialogo = ""

var jugador_cercano = null
var dialogue_instance: Node = null
var DialogueScene = preload("res://npc1_dialogue_box.tscn")

func _ready():
	$AnimatedSprite2D.play("default")
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D:
		jugador_cercano = body
		jugador_cercano.npc_cercano = self

func _on_body_exited(body):
	if body is CharacterBody2D:
		jugador_cercano = null
		body.npc_cercano = null

# Esta función la llamas desde la entrada del jugador (tecla "interact")
func interactuar():
	if dialogue_instance == null:
		dialogue_instance = DialogueScene.instantiate()
		get_tree().current_scene.add_child(dialogue_instance) # <- se agrega directo a la escena
		dialogue_instance.opcion_elegida.connect(_on_opcion_elegida)
	dialogue_instance.mostrar_dialogo("¡ALTO!\n¿A dónde vas?\nElige tu respuesta:")


func _on_opcion_elegida(opcion: String):
	match opcion:
		"Casa":
			dialogue_instance.mostrar_dialogo("NPC: No hay casas en esta isla.\n Por eso duermo aquí.")
		"Castillo":
			# Mostramos el texto primero
			dialogue_instance.mostrar_dialogo("NPC: De acuerdo, adelante.")
			await get_tree().create_timer(5).timeout
			# Luego de los 6 segundos quitamos todo
			dialogue_instance.queue_free() # quita la caja de diálogo
			queue_free() # elimina al NPC
		"Torre":
			dialogue_instance.mostrar_dialogo("NPC: ¡No hay torres a la vista! \n Quizás necesito lentes.")
		_:
			dialogue_instance.mostrar_dialogo("NPC: ... No entendí tu respuesta.")
