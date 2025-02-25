extends Node2D


## Draws the grid lines.
func _draw() -> void:
    RenderingServer.set_default_clear_color(Config.bg_color)
    DisplayServer.window_set_size(Config.screen_dimensions)
    get_window().move_to_center()

    for x in range(0, Config.screen_dimensions.x, Config.cell_size):
        var point0 := Vector2(x, 0)
        var point1 := Vector2(x, Config.screen_dimensions.y)
        draw_line(point0, point1, Config.grid_color)
    
    for y in range(0, Config.screen_dimensions.y, Config.cell_size):
        var point0 := Vector2(0, y)
        var point1 := Vector2(Config.screen_dimensions.x, y)
        draw_line(point0, point1, Config.grid_color)
    
    # Draw the edges
    draw_line(Vector2(1, 1), Vector2(1, Config.screen_dimensions.y), Config.grid_color)
    draw_line(Vector2(Config.screen_dimensions.x, 1), Vector2(Config.screen_dimensions.x, Config.screen_dimensions.y), Config.grid_color)
    draw_line(Vector2(1, 1), Vector2(Config.screen_dimensions.x, 1), Config.grid_color)
    draw_line(Vector2(1, Config.screen_dimensions.y), Vector2(Config.screen_dimensions.x, Config.screen_dimensions.y), Config.grid_color)


