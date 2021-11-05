extends CanvasLayer

signal chargeTrigger

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if Input.is_action_pressed("ACTION_MAIN"):
		Global.chargeCounter += (100 * delta)
	if !Input.is_action_pressed("ACTION_MAIN"):
		if Global.chargeCounter >= 90:
			emit_signal("chargeTrigger")
		Global.chargeCounter = 0

	if Global.chargeCounter <= 9:
		$HubChargeBar.play("zero")
	elif Global.chargeCounter >= 10 && Global.chargeCounter <= 19:
		$HubChargeBar.play("one")
	elif Global.chargeCounter >= 20 && Global.chargeCounter <= 29:
		$HubChargeBar.play("two")
	elif Global.chargeCounter >= 30 && Global.chargeCounter <= 39:
		$HubChargeBar.play("three")
	elif Global.chargeCounter >= 40 && Global.chargeCounter <= 49:
		$HubChargeBar.play("four")
	elif Global.chargeCounter >= 50 && Global.chargeCounter <= 59:
		$HubChargeBar.play("five")
	elif Global.chargeCounter >= 60 && Global.chargeCounter <= 69:
		$HubChargeBar.play("six")
	elif Global.chargeCounter >= 70 && Global.chargeCounter <= 79:
		$HubChargeBar.play("seven")
	elif Global.chargeCounter >= 80 && Global.chargeCounter <= 89:
		$HubChargeBar.play("eight")
	else:
		$HubChargeBar.play("flashing")

	if Global.chargeCounter >= 100:
		Global.chargeCounter == 100
