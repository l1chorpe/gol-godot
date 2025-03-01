class_name Cell extends Sprite2D

func _ready() -> void:
    (texture as GradientTexture2D).gradient.colors = [Config.cell_color]

var grid_pos: Vector2i:
    get:
        return grid_pos
    set(new_pos):
        grid_pos = new_pos
        position.x = (grid_pos.x + .5) * Config.cell_size
        position.y = (grid_pos.y + .5) * Config.cell_size
        scale = Vector2(Config.cell_size / 20.0, Config.cell_size / 20.0)

func isAt(pos: Vector2i) -> bool:
    return grid_pos == pos
