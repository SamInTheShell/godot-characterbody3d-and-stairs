# Smooth Stairs Prototype - Godot 4.3
A demonstration of traversing stairs in Godot with a CharacterBody3D.
This code was never intended for production.

- ShapeCast3D is used to detect and climb small ledges
- RayCast3D is used to prevent flying off of stairs when going down.

Jumping does not work while traversing stairs and inclines with this code.
It can be solved with some code to track the character being in a jumping state instead of just determining if the character "is_on_floor".

---
There are two major bugs that can be observed in this version. On of them is if you traverse a step in parallel to the next step. The character will float up. This is solvable by just using a box shape ajusted to only check heading forward and behind.

The second one is when trying to walk off the ramp onto the platform. I thought this was due to the shapecast holding two collisions at the same time while the raycast was activated. I seem to be wrong in validating the idea. No clue why.

---
### Final Thoughts
Improvement to this model can probably be achieved with:
- StairForwardChecker (ShapeCast3D)
- StairFollowChecker (ShapeCast3D)
- FloorSnapper (RayCast3D)

The StairForwardChecker and StairFollowChecker would be box shapes that are narrower than the character collider.

The StairForwardChecker is responsible for detecting stairs the character is going up.

StairFollowChecker is used in conjunction with FloorSnapper to detect when the player is going down stairs.
