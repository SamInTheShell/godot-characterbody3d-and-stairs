# Smooth Stairs Prototype - Godot 4.3
A demonstration of traversing stairs in Godot with a CharacterBody3D.
This code was never intended for production.

- ShapeCast3D is used to detect and climb small ledges
- RayCast3D is used to prevent flying off of stairs when going down.

Jumping does not work while traversing stairs and inclines with this code.
It can be solved with some code to track the character being in a jumping state instead of just determining if the character "is_on_floor".
