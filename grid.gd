extends Node2D


const bg_color := 0x171717ff; ## Background color: dark grey
const fg_color := 0xe8e8e8ff; ## Foreground color: light grey


## Draws the grid lines.
func _draw() -> void:
    for x in range(0, Config.screen_dimensions.x, Config.cell_size):
        var point0 := Vector2(x, 0)
        var point1 := Vector2(x, Config.screen_dimensions.y)
        draw_line(point0, point1, Color.hex(fg_color))
    
    for y in range(0, Config.screen_dimensions.y, Config.cell_size):
        var point0 := Vector2(0, y)
        var point1 := Vector2(Config.screen_dimensions.x, y)
        draw_line(point0, point1, Color.hex(fg_color))
    
    # Draw the edges
    draw_line(Vector2(1, 1), Vector2(1, Config.screen_dimensions.y), fg_color)
    draw_line(Vector2(Config.screen_dimensions.x, 1), Vector2(Config.screen_dimensions.x, Config.screen_dimensions.y), fg_color)
    draw_line(Vector2(1, 1), Vector2(Config.screen_dimensions.x, 1), fg_color)
    draw_line(Vector2(1, Config.screen_dimensions.y), Vector2(Config.screen_dimensions.x, Config.screen_dimensions.y), fg_color)


