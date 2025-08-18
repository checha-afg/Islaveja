extends CanvasLayer

@onready var texto = $Panel/Label
@onready var retrato = $Panel/TextureRect

var velocidad_texto := 0.02 # segundos entre letras
var escribiendo := false

func _ready():
	mostrar_dialogo("¡Hola! Bienvenido a la isla.\nEstoy buscando el castillo. \n¿Me ayudas a llegar?")

func mostrar_dialogo(texto_dialogo: String):
	escribiendo = true
	texto.text = "" #limpiado
	visible = true
	get_tree().paused = true  # Pausa el juego mientras habla
	
	#corutina: esto hace que el texto vaya daspecio
	await escribir_texto(texto_dialogo)
	escribiendo = false

func _input(event):
	if event.is_action_pressed("ui_accept") and visible:
		get_tree().paused = false
		queue_free()  # elimina la escena del diálogo
		
# --- Función para escribir texto lentamente
func escribir_texto(texto_dialogo: String) -> void:
	for i in range(texto_dialogo.length()):
		texto.text += texto_dialogo[i]
		await get_tree().create_timer(velocidad_texto).timeout
		
