class_name ConfigWindow extends Window


## Loads the necessary config values into the window.
func _ready() -> void:
    $Margin/VBox/ScreenSize/ValueX.text = str(Config.screen_dimensions.x)
    $Margin/VBox/ScreenSize/ValueY.text = str(Config.screen_dimensions.y)
    $Margin/VBox/CellSize/Value.text = str(Config.cell_size)
    $Margin/VBox/TPS/Value.text = str(Config.tps)

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