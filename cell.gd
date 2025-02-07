class_name Cell extends Sprite2D

var grid_pos: Vector2i:
    get:
        return grid_pos
    set(new_pos):
        grid_pos = new_pos
        position.x = grid_pos.x * 20 + 10
        position.y = grid_pos.y * 20 + 10

func isAt(pos: Vector2i) -> bool:
    return grid_pos == pos
