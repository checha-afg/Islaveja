extends CanvasLayer

signal frase_completada(correcta: bool)

@export var frase_objetivo_texto := "Aqui viven dos ovejas"
@export var fuente_personalizada: Font
@onready var label_titulo = $Panel/LabelTextBox
@onready var label_frase_actual = $Panel/LabelFraseActual
@onready var contenedor_botones = $Panel/HBoxContainer

# Frase objetivo como Array[String]
var frase_objetivo: Array[String] = []

# Selección actual del jugador
var seleccion_actual: Array[String] = []

func _ready():
	visible = false
	# Convertimos la frase objetivo en Array[String]
	frase_objetivo = []
	for palabra in frase_objetivo_texto.split(" ", false):
		frase_objetivo.append(palabra)

func iniciar_minijuego():
	visible = true           # hace visible el minijuego
	_iniciar_minijuego()     # llama a la función que ya prepara botones y limpia la selección

func _iniciar_minijuego(): 
	# Limpiamos selección y UI
	seleccion_actual.clear()
	label_frase_actual.text = ""
	_limpiar_botones()

	# Mezclamos palabras para los botones
	var palabras = frase_objetivo.duplicate()
	palabras.shuffle()
	label_titulo.text = "No recuerdo qué animal vive en esta isla...\n¡Toca las palabras en orden para \nformar la frase!"
	
	# Creamos botones
	for palabra in palabras:
		var b := Button.new()
		b.text = palabra
		b.focus_mode = Control.FOCUS_NONE

		b.pressed.connect(func(boton = b): _on_palabra_presionada(boton))
		contenedor_botones.add_child(b)




func _on_palabra_presionada(boton: Button):
	# Añadimos palabra y deshabilitamos botón
	seleccion_actual.append(boton.text)
	boton.disabled = true

	# Actualizamos Label
	label_frase_actual.text = " ".join(seleccion_actual)

	# Comprobamos si completó la frase
	if seleccion_actual.size() == frase_objetivo.size():
		if seleccion_actual == frase_objetivo:
			label_titulo.text = "¡Muy bien! ¡Ahora lo recuerdo!"
			label_frase_actual.text = frase_objetivo_texto
			emit_signal("frase_completada", true)
			await get_tree().create_timer(1.5).timeout
			queue_free()  # Cierra el minijuego
		else:
			label_titulo.text = "Ups, intenta de nuevo."
			await get_tree().create_timer(1.0).timeout
			_iniciar_minijuego()

func _limpiar_botones():
	for c in contenedor_botones.get_children():
		c.queue_free()
