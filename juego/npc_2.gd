extends StaticBody2D

@export var nombre = "NPC Ovejas"

var jugador_cercano: Node = null
var minijuego_instance: Node = null
var MinijuegoScene = preload("res://minijuego_ordenar.tscn")

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

func interactuar():
	if minijuego_instance == null:
		minijuego_instance = MinijuegoScene.instantiate()
		get_tree().current_scene.add_child(minijuego_instance) # se agrega al árbol
		minijuego_instance.frase_completada.connect(_on_frase_completada)
		minijuego_instance.iniciar_minijuego() # muestra y activa el minijuego

func _on_frase_completada(correcta: bool):
	if correcta:
		await get_tree().create_timer(2).timeout
		queue_free() # elimina al NPC para avanzar
		# el minijuego ya se elimina solo al completarse
	else:
		# minijuego se reinicia solo si es incorrecto
		pass
