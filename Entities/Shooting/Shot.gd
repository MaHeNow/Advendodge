class_name Shot
extends Resource

export (float, 10) var buildup_time: float = 0;
export (float, 10) var cooldown_time: float = 0;
export (Vector2) var position: Vector2;
export (bool) var warning: bool = false;
var projectile_scene: PackedScene
