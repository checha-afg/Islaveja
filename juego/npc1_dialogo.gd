extends CanvasLayer

signal opcion_elegida(opcion: String)

@onready var texto = $Panel/Label
@onready var retrato = $Panel/TextureRect
@onready var opciones_container = $Panel/HBoxContainer

var velocidad_texto := 0.02

func _ready():
	opciones_container.visible = false
	visible = false  # no se ve hasta que el NPC lo muestre

func mostrar_dialogo(texto_dialogo: String):
	texto.text = ""
	visible = true
	get_tree().paused = true
	await escribir_texto(texto_dialogo)
	mostrar_opciones()

func mostrar_opciones():
	opciones_container.visible = true
	for boton in opciones_container.get_children():
		boton.pressed.connect(_on_boton_pressed.bind(boton.text))

func _on_boton_pressed(opcion: String):
	emit_signal("opcion_elegida", opcion)
	get_tree().paused = false
	# ❌ ya no hacemos queue_free aquí, lo controlará el NPC


func escribir_texto(texto_dialogo: String) -> void:
	for i in range(texto_dialogo.length()):
		texto.text += texto_dialogo[i]
		await get_tree().create_timer(velocidad_texto).timeout
