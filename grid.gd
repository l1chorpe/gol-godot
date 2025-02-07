extends Node2D


const bg_color := 0x171717ff; ## Background color: dark grey
const fg_color := 0xe8e8e8ff; ## Foreground color: light grey

@onready var screen_size: Vector2 = get_viewport_rect().size


## Draws the grid lines.
func _draw() -> void:
    for x in range(0, screen_size.x, 20):
        var point0 := Vector2(x, 0)
        var point1 := Vector2(x, screen_size.y)
        draw_line(point0, point1, Color.hex(fg_color))
    
    for y in range(0, screen_size.y, 20):
        var point0 := Vector2(0, y)
        var point1 := Vector2(screen_size.x, y)
        draw_line(point0, point1, Color.hex(fg_color))
    
    # Draw the edges
    draw_line(Vector2(1, 1), Vector2(1, screen_size.y), fg_color)
    draw_line(Vector2(screen_size.x, 1), Vector2(screen_size.x, screen_size.y), fg_color)
    draw_line(Vector2(1, 1), Vector2(screen_size.x, 1), fg_color)
    draw_line(Vector2(1, screen_size.y), Vector2(screen_size.x, screen_size.y), fg_color)
