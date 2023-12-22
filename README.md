# Project Title

Name: Alexander Dergach & David Davitashvili

Student Number: C20401562 & C20406272

Class Group: TU856, Game Engines 1

Video:

[![YouTube](https://cdn.discordapp.com/attachments/918310097292243024/1187510121182539939/Screenshot_2023-12-21_213936.png?ex=659725fb&is=6584b0fb&hm=46872b10538de8b26a34369d0230fc14f9822495f25caa7104e5d15fc99cd389&)](https://www.youtube.com/watch?v=sJX0uuLm0p8)

# Description of the project

A futuristic remote-controlled drone flying experience where you can fly your drone around a map with obstacles and shoot with a turret. The player will be stationary and will have virtual controllers to fly the drone. The player will be able to use virtual headset that allows them to see from the drone's camera. The area underneath the drone will have particle effects.

# Instructions for use

Run on Godot 4.1. Connect to Meta Quest through link cable or air link. Press F5 to run root scene

## In-Game Controls

### Hand Mode

1. Left Controller
- Analog Stick : Move Player

2. Right Controller
- Analog Stick : Rotate Player

3. Both Controllers
- Grips : Grab Object

### Drone Mode

1. Left Controller
- Analog Stick :  
    Up and Down = Drone Altitude
    Left and Right = Drown Yaw

2. Right Controller
- Analog Stick :
    Up and Down = Move Drone Forward & Backward
    Left and Right = Move Drone Left & Right
    Trigger = Shoot Bullets
    Grab Headset = Show Drone View

# How it works

## Flight Movement

### LEFT CONTROLLER:
The left analog stick on the physical controller can be read and stored for
future use.

```python
func _on_left__controller_input_vector_2_changed(name, value):
	# store left stick values into global variables
	left_value_Z = value[0]
	left_value_X = value[1]
```

This allows for the player to change the drone's altitude and rotation based
on the change in position of the left stick. The variables `left_value_X` 
and `left_value_Z` both range from -1 to 1 with 0 being the resting position of 
the left stick. Depending on these variables, they will adjust the position 
and rotation of the drone. The variable `DRONE_SPEED_Y` is what determines 
the speed of the drone's up and down direction. The variable `delta` is the 
elapsed time since the previous frame.

```python
func _physics_process(delta):
	if drone: # fixes bug where it returns null
		if enabled: # if controllers are picked up
			# move drone up or down
			drone.position.y += left_value_X * DRONE_SPEED_Y * delta
			
			# rotate drone yaw
			drone.rotation.y += -left_value_Z * DRONE_ROTSPEED * delta
```

### RIGHT CONTROLLER: 
The left analog stick on the physical controller can be read and stored for
future use.

```python
func _on_right__controller_input_vector_2_changed(name, value):
	# store right stick values into global variables
	right_value_X = value[0]
	right_value_Z = value[1]
```

This allows for the player to change the drone's forward, backward, left,
and right directions. The variables `right_value_X` and `right_value_Z` both
range from -1 to 1 with 0 being the resting position of 
the right stick. Depending on these variables, they will adjust the position 
of the drone. The variable `DRONE_SPEED` determines the speed of the drone.
Using `-Vector.FORWARD`, the drone can be translated in the direction the drone
is facing. Also, using `-Vector.RIGHT`, the drone can be translated in the 
left and right directions. Extra slight rotation is added where the pitch
and the roll of the drone is affected depending on the direction the drone
is going.

```python
func _physics_process(delta):
	if drone: # fixes bug where it returns null
		if enabled: # if controllers are picked up
			# moving the drone
			drone.translate(-Vector3.FORWARD * right_value_Z * DRONE_SPEED * delta)
			drone.translate(-Vector3.RIGHT * right_value_X * DRONE_SPEED * delta)
			
			# adds a bit of rotation to the drone depending on direction it's going
			drone.rotation.x = right_value_Z * 0.2
			drone.rotation.z = right_value_X * 0.2
```

## Player

The player starts with normal hands, allowing the player to walk around the 
map. This is done with the nodes `MovementDirect` and `MovementTurn`, which 
both derive from the XRTools addon in Godot.

The table beside the player presents two controllers, where the player will be 
able to pick up these controllers and switch to drone mode and fly the drone. 
This is done by grap points, snap points, and the grip button to grab, which are
all handled by XRTools.

When the player grabs one of the controllers, the controller on the table will 
disappear along with the hand model of the player, which is replaced with the
same controller model as on the table.

```python
func _on_left__controller_button_pressed(name):
	# if left controller is placed back on the tabled
	if(name == "grip_click"):
		snapped_left.visible = true
		hand_left.visible = true
		controller_onLeft.visible = false
		leftJoystick.enabled = false
		movingFunction.enabled = true
```

When the player decides to place them back on the table using the grip button,
the opposite occurs.

```python
func _on_ctrllr_left__pickable_object_2_picked_up(pickable):
	if(offset_left == 2): # sets offset back to 1 for next time picked up
		offset_left = 1
	elif(offset_left == 1): # if picked up
		snapped_left.visible = false
		hand_left.visible = false
		controller_onLeft.visible = true
		leftJoystick.enabled = true
		movingFunction.enabled = false
		offset_left = 2
	else: # fixes said bug
		offset_left = 1
```
	

## Headset And Cameras

The camera on the drone is positioned just underneath the drone, which allows for
the player to view from the drone. This is done by creating a subviewport and having
a camera as its child. A Sprite3D node is added as a child to the player's camera, so 
that the drone camera can constantly be in the player's point of view. With this, the
Sprite3D node acts as a screen to display the drone camera.

The drone camera appears when the headset has been held, which sets a timer for 1.5
seconds, allowing the animation to play first and then displaying the view. The drone 
camera disappears when the headset has been held once again, starting another timer.

```python
func _on_headset__pickable_object_picked_up(pickable):
	if pickable: # if headset is picked up
		if forTimer: # if opened
			# play animation to open headset
			$AnimationTree.set("parameters/Transition/transition_request","open")
			
			# start the timer to delay the drone camera toggle
			timer.start()
			
		else: # if closed
			# play animation to open headset
			$AnimationTree.set("parameters/Transition/transition_request","close")
			
			# start the timer to delay the drone camera toggle
			timer.start()
		
func _on_timer_timeout():
	if forTimer: # if opened, turn on the drone camera
		droneCam.visible = true
		forTimer = false
	else: # if closed, turn off the drone camera
		droneCam.visible = false
		forTimer = true
```

## Shooting

While the virtual controllers are equipped, a bullet is instantiated whenever the 
right trigger is pressed. The bullet instance becomes a child node of the root node
and the bullet leaves from the bullet spawn point. The variable `bullet_speed` 
determines the speed of the bullet, which is then applied to the `linear_velocity` property.

```python
func _on_right__controller_button_pressed(name):
	if name == "trigger_click":
		# spawn a bullet
		spawn_bullet()

func spawn_bullet():
	# instantiate a bullet
	var projectile = bullet_scene.instantiate()
	
	# add to root node
	rootNode.add_child(projectile)
	
	# set bullet position to bullet spawn position
	projectile.transform = bullet_spawn.global_transform
	
	# apply velocity to bullet
	projectile.linear_velocity = bullet_spawn.global_transform.basis.z * bullet_speed
```


## Sound

Once the game opens, the music theme starts to play, creating the atmosphere of the sci-fi
game. The drone plays a sound that continuously loops. When the drone moves upwards or downwards,
the pitch of the sound adjusts based on the left stick. A maximum and a minimum value is 
applied to this property so that the pitch does not go infinitely high or low, keeping the
realistic sound of a real drone. When the left stick is at resting position, the pitch of
the sound is lerped to `0` by a weight of `0.1`. This means that when the drone stops in place
after elevation change, the pitch smoothly interpolates between what it was to the default
pitch.


```python
# if left stick is not moved
if left_value_X == 0:
	# lerp sound pitch from when it was being moved
	sound.pitch_scale = lerp(sound.pitch_scale,1.0,0.1)
else:
	# control the pitch
	sound.pitch_scale += left_value_X * delta
	
	# set max and min of pitch
	sound.pitch_scale = clamp(sound.pitch_scale, 0.8,1.2)
```

## Enviroment

All the models used on the map are custom, including the drone setup. For the building windows, it uses omni lighting as for the lamp posts to illuminate the surrounding areas, as with the world environment, and directional lighting is dark with a dark Star HDRI surrounding the map, which helps give a futuristic atmosphere.
It has two car models moving around the map, as they would in a city, using path navigation. Use the script below to access the created path and parent Path3dD node of the car mesh models.

```python
extends Node3D

@onready var path = get_node("/root/root/Car1Path3D/PathFollow3D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	const move_speed := 4.0
	path.progress += move_speed * delta

```

At the centre of the map, unlike the more detailed buildings, is a broken-down 'Main building' with precise collison meshes just like the other buildings, allowing the drone to fly through intracting windows and rooms.


# List of classes/assets in the project

| Class/Asset | Source |
|-----------|-----------|
| BuildingFour.fbx | Self Made |
| BuildingThree.fbx | Self Made |
| BuildingTwo.fbx | Self Made |
| BuildingOne.fbx | Self Made |
| Car1.fbx | Self Made |
| Car2.fbx | Self Made |
| Controller_Right.fbx | Self Made |
| Controller_Left.fbx | Self Made |
| Drone.fbx | Self Made |
| Headset.glb | Self Made |
| Map.fbx | Self Made |
| Table.fbx | Self Made |
| MainBuilding.fbx | Self Made |
| Bullet.tscn | Self Written |
| HeadSet.tscn  | Self Written |
| Particles.tscn  | Self Written |
| Root.tscn  | Self Written |

# References

| Ref No. | Name | Source |
|-----------|-----------|-----------|
| 1 | XR-Tools Addon | https://github.com/GodotVR/godot-xr-tools |
| 2 | beatiful-shinng-stars-night... | https://www.freepik.com/free-photo/starry-night-sky_7061153.htm#query=hdri%20night&position=6&from_view=keyword&track=ais&uuid=c9455ca4-c2c9-4e87-9dc8-c96c8e1ba084 |
| 3 | Drone.mp3 | https://www.youtube.com/watch?v=QO91wfmHPMo |
| 4 | Grid-Hartzman-main.mp3 | https://uppbeat.io/music/genre/techno |

# What I am most proud of in the assignment

- We are proud of the Drone's dynamic movement based on it's direction
- We are proud of the lighting and modelling of the custom map
- We are proud of the sound design and atmosphere
- We are proud of the car's navigation pathing
- We are proud of the camera changes
- We are proud we could mimic a drone :D

# What I learned

- We learnt how dynamic movement works with model yawing and lerping
- We learnt how easy it is to make a stream line VR game with godot's engine
- We learnt about path finding and navigation
- We learnt about godot's lighting and shadow system for maps
- We learnt how challenging it can be to combine models and interact game systems and design

# Proposal submitted earlier can go here:

A futuristic remote-controlled drone flying experience where you can fly your drone around a map with obstacles and targets to shoot with a turret. The player will be stationary and will have a virtual controller to fly the drone and do tricks such as backflips. The player will be able to put on a virtual headset that allows them to see from the drone's camera. The area underneath the drone will have the effects of it being blown away. If the drone collides with another object, depending on the severity, it will have effects on the drone, such as slower speed and damage done.
