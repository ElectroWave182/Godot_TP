class_name Sauvegarde


const nomFichier: String = "res://donnees.save"

static var donnees: Dictionary = {}


"Sauvegarde les données dans le fichier"

static func ecrire () -> void:
	
	var fichier: FileAccess = FileAccess. open (nomFichier, FileAccess. WRITE)
	var texte: String = JSON. stringify (donnees, "\t")
	fichier. store_line (texte)


"Charge les données depuis le fichier"

static func lire () -> bool:
	
	# Le fichier peut ne pas exister
	if not (FileAccess. file_exists (nomFichier)):
		return false
	
	# Récupération
	var fichier: FileAccess = FileAccess. open (nomFichier, FileAccess. READ)
	var texte: String = fichier. get_as_text ()
	var json = JSON. new ()
	json. parse (texte)
	donnees = json. data
	
	return true
