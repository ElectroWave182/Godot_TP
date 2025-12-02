class_name Pause
extends CanvasLayer


"Met le jeu en pause"

func mettrePause () -> void:
	
	visible = true
	Jeu. joueur. bloquer ()


"Enlève la pause du jeu"

func reprendre () -> void:
	
	visible = false
	Jeu. joueur. debloquer ()


"Quitte complètement le jeu"

func quitter () -> void:
	
	# Enregistrement de la position du joueur
	var positionJoueur: Vector2 = Jeu. joueur. position
	Sauvegarde. donnees ["joueur_x"] = positionJoueur. x
	Sauvegarde. donnees ["joueur_y"] = positionJoueur. y
	Sauvegarde. ecrire ()
	
	get_tree (). quit ()
