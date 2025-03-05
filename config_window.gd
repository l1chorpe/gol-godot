class_name ConfigWindow extends Window


## Loads the necessary config values into the window.
func _ready() -> void:
    %ScreenSize/ValueX.text = str(Config.screen_dimensions.x)
    %ScreenSize/ValueY.text = str(Config.screen_dimensions.y)
    %CellSize/Value.text = str(Config.cell_size)
    %TPS/Value.text = str(Config.tps)
    %Background/Color.color = Config.bg_color
    %Grid/Color.color = Config.grid_color
    %GCBoxContainer/CheckButton.set_pressed_no_signal(Config.generational_color)

    %Cell.visible = !Config.generational_color

## Hides the window when requested.
func _input(event: InputEvent) -> void:
    if event.is_action_pressed("toggle_config_window") || event.is_action_pressed("quit"):
        visible = !visible

## Applies the changes to the config.
func _on_apply_pressed() -> void:
    Config.reload_config(self)
    get_parent().reload_game()

## Saves the changes to the config and hides the window.
func _on_save_pressed() -> void:
    _on_apply_pressed()
    visible = false

func _on_close_requested() -> void:
    visible = false

## Toggles the generational color option.
func _on_GC_toggled(toggled: bool) -> void:
    %Cell.visible = !toggled
    Config.generational_color = toggled

## Gets the screen dimensions for the game.
func get_screen_dimensions() -> Vector2i:
    var sdx := int(%ScreenSize/ValueX.text)
    var sdy := int(%ScreenSize/ValueY.text)
    return Vector2i(sdx, sdy)

## Gets the cell size for the game.
func get_cell_size() -> int:
    return int(%CellSize/Value.text)

## Gets the ticks per second for the game.
func get_tps() -> int:
    return int(%TPS/Value.text)

## Gets the background color for the game.
func get_bg_color() -> Color:
    return %Background/Color.color

## Gets the grid color for the game.
func get_grid_color() -> Color:
    return %Grid/Color.color

## Gets the cell color for the game.
func get_cell_color() -> Color:
    return %Cell/Color.color

## Resets the config to its default values and reloads the game.
func _on_config_reset() -> void:
    Config.create_config()
    _ready()
    get_parent().reload_game()