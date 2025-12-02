class_name Joueur
extends CharacterBody2D


const directions: Dictionary = {
	"up":    Vector2 ( 0, -1),
	"left":  Vector2 (-1,  0),
	"down":  Vector2 ( 0,  1),
	"right": Vector2 ( 1,  0)
}
const vitesse: float = 10 * 1000

enum corps {mobile, fige}

var texture: AnimatedSprite2D
var directionAppuyees: Array [String] = []
var etat = corps. mobile


"Cesse les déplacements"

func bloquer () -> void:
	
	self. etat = corps. fige
	
	# Changement vers l'animation "idle"
	if not (self. directionAppuyees. is_empty ()):
		self. texture. play ("idle_" + self. directionAppuyees [-1])
	
	# Arrêt du déplacement
	self. directionAppuyees. clear ()


"Reprend les déplacements"

func debloquer () -> void:
	
	self. etat = corps. mobile


"Gère le déplacement pour une entrée donnée (up, left, down, ou right)"

func deplacement (entree: String) -> void:
	
	# Changement de direction
	if Input. is_action_just_pressed (entree):
		self. directionAppuyees. append (entree)
	
	# Changement de texture
	if not (self. directionAppuyees. is_empty ()):
		self. texture. play ("walk_" + self. directionAppuyees [-1])
	
	# Si aucune touche n'est pressée
	var touchePressee = false
	for autreEntree in directions. keys ():
		touchePressee = touchePressee or Input. is_action_pressed (entree)
	
	# Réinitialisation
	if Input. is_action_just_released (entree):
		self. directionAppuyees. erase (entree)
		if not (touchePressee):
			self. texture. play ("idle_" + entree)


func _ready () -> void:
	
	# Obtention des noeuds
	self. texture = get_node ("animations")


func _process (periode: float) -> void:
	
	if self. etat == corps. mobile:
		
		# Changements liés aux touches ZQSD
		for entree in directions. keys ():
			self. deplacement (entree)
		
		# Translation du joueur
		velocity = Vector2. ZERO
		if not (self. directionAppuyees. is_empty ()):
			var unitaire: Vector2 = directions [self. directionAppuyees [-1]]
			velocity = unitaire * vitesse * periode
		move_and_slide ()
