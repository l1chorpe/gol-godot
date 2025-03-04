class_name ConfigWindow extends Window


## Loads the necessary config values into the window.
func _ready() -> void:
    $Margin/VBox/ScreenSize/ValueX.text = str(Config.screen_dimensions.x)
    $Margin/VBox/ScreenSize/ValueY.text = str(Config.screen_dimensions.y)
    $Margin/VBox/CellSize/Value.text = str(Config.cell_size)
    $Margin/VBox/TPS/Value.text = str(Config.tps)
    $Margin/VBox/Background/Color.color = Config.bg_color
    $Margin/VBox/Grid/Color.color = Config.grid_color
    $Margin/VBox/GCBoxContainer/CheckButton.set_pressed_no_signal(Config.generational_color)

    $Margin/VBox/Cell.visible = !Config.generational_color

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
    $Margin/VBox/Cell.visible = !toggled
    Config.generational_color = toggled

## Gets the screen dimensions for the game.
func get_screen_dimensions() -> Vector2i:
    var sdx := int($Margin/VBox/ScreenSize/ValueX.text)
    var sdy := int($Margin/VBox/ScreenSize/ValueY.text)
    return Vector2i(sdx, sdy)

## Gets the cell size for the game.
func get_cell_size() -> int:
    return int($Margin/VBox/CellSize/Value.text)

## Gets the ticks per second for the game.
func get_tps() -> int:
    return int($Margin/VBox/TPS/Value.text)

## Gets the background color for the game.
func get_bg_color() -> Color:
    return $Margin/VBox/Background/Color.color

## Gets the grid color for the game.
func get_grid_color() -> Color:
    return $Margin/VBox/Grid/Color.color

## Gets the cell color for the game.
func get_cell_color() -> Color:
    return $Margin/VBox/Cell/Color.color

## Resets the config to its default values and reloads the game.
func _on_config_reset() -> void:
    Config.create_config()
    _ready()
    get_parent().reload_game()