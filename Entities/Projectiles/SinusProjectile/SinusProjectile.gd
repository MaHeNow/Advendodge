class_name SinusProjectile
extends Projectile

var amplitude: float = 0.0
var wavelength: float = 1.0
var speed: float = 5.0
var spawnpoint: Vector2
var perpendicular_direction: Vector2
var scaled_direction: Vector2
var direction: Vector2


func setup(shot: Shot) -> Projectile:
	.setup(shot)
	if shot is SinusProjectileShot:
		amplitude = shot.amplitude
		wavelength = shot.wavelength
		speed = shot.speed
		spawnpoint = ScreenSize.at_screen(shot.position)
		direction = Vector2.UP.rotated(deg2rad(shot.rotation_degrees))
		self.perpendicular_direction = direction.rotated(-PI / 2)
		# direction in which the projectile will fly (scaled by the speed)
		self.scaled_direction = direction * speed

	return self
	
	
func behave() -> void:
	""" 
	The projected_vector acts like the x-axis of the sinus movement. Because the movement can
	be rotated, we need to project the current position down to the x-axis and use the distance as
	input for the sinus function. Finally we determine the next position for our projectile with
	some sinus math and use the difference between the next position and the current position as
	our movement vector.
	"""
	var projected_vector := (self.position - spawnpoint).project(self.direction)
	var distance := projected_vector.length()
	var target_point := (self.position + self.scaled_direction) 
	target_point += (self.perpendicular_direction * cos(distance * (2* PI / self.wavelength)) * self.amplitude)
	self.movement = (target_point - self.position)
