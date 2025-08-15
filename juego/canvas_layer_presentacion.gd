extends CanvasLayer

@onready var texto = $Panel/HBoxContainer/Label
@onready var retrato = $Panel/HBoxContainer/TextureRect

func _ready():
	mostrar_dialogo("¡Hola! Bienvenido a la isla, me perdí hace un rato y quiero volver a mi castillo. ¡GUÍAME!",preload)

func mostrar_dialogo(texto_dialogo: String, imagen_retrato: Texture2D):
	texto.text = texto_dialogo
	retrato.texture = imagen_retrato
	visible = true
	get_tree().paused = true  # Pausa el juego mientras habla

func _input(event):
	if event.is_action_pressed("ui_accept") and visible:
		visible = false
		get_tree().paused = false
