extends Polygon2D

func _ready():
	self.texture = preload("res://icon.png")
	var us = PoolVector2Array([
		Vector2(0.5, 0.0),
		Vector2(1.0, 1.0),
		Vector2(0.0, 1.0)
	])
	#self.uv = us
	var ps = PoolVector2Array()
	ps.push_back(Vector2(100, 50))
	ps.push_back(Vector2(150, 150))
	ps.push_back(Vector2(50, 150))
	self.polygon = ps
