# Project Title

Name: Alexander Dergach & David Davitashvili

Student Number: C20401562 & C20406272

Class Group: TU856, Game Engines 1

Video:

[![YouTube](http://img.youtube.com/vi/J2kHSSFA4NU/0.jpg)](https://www.youtube.com/watch?v=J2kHSSFA4NU)

# Description of the project

A futuristic remote-controlled drone flying experience where you can fly your drone around a map with obstacles and shoot with a turret. The player will be stationary and will have a virtual controller to fly the drone and do tricks. The player will be able to put on a virtual headset that allows them to see from the drone's camera. The area underneath the drone will have particle effects.

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

- David

## Player

- David

## Headset And Cameras

- David

## Shooting

- David

## Sound

Includes background techno music that we felt fits into the surronding enviroment.

- Drone Sound On David

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
- We learnt how easy it is to make a stream line game with godot's engine
- We learnt about path finding and navigation
- We learnt about godot's lighting and shadow system for maps
- We learnt how challanging it can be to combine models and interact game systems and design

# Proposal submitted earlier can go here:

A futuristic remote-controlled drone flying experience where you can fly your drone around a map with obstacles and targets to shoot with a turret. The player will be stationary and will have a virtual controller to fly the drone and do tricks such as backflips. The player will be able to put on a virtual headset that allows them to see from the drone's camera. The area underneath the drone will have the effects of it being blown away. If the drone collides with another object, depending on the severity, it will have effects on the drone, such as slower speed and damage done.