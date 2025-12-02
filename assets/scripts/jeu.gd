class_name Jeu
extends Node2D


const player    = preload ("res://assets/scenes/Player.tscn")
const interface = preload ("res://assets/scenes/Interface.tscn")

static var joueur: CharacterBody2D


func _ready () -> void:
	
	# Création du menu
	var menu: Control = interface. instantiate ()
	add_child (menu)
	
	# Création du joueur
	joueur = player. instantiate ()
	add_child (joueur)
	
	# Repositionnement du joueur selon la sauvegarde
	if Sauvegarde. lire ():
		var x: float = Sauvegarde. donnees ["joueur_x"]
		var y: float = Sauvegarde. donnees ["joueur_y"]
		joueur. position = Vector2 (x, y)


func _process (_delta: float) -> void:
	
	# Affichage du menu de pause
	if Input. is_action_just_pressed ("pause"):
		var menuPause: CanvasLayer = get_node ("interface/pause")
		
		# Bascule
		if menuPause. visible:
			menuPause. reprendre ()
		else:
			menuPause. mettrePause ()
