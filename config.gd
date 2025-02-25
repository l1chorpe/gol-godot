## Handles the configuration of the game.
class_name Config


# Config file location
const CONF_FILE_NAME = "user://golgodot.cfg"

# Config variables
static var screen_dimensions: Vector2i
static var cell_size: int
static var tps: int
static var bg_color: Color
static var grid_color: Color

class Defaults:
    const SCREEN_DIMENSIONS := Vector2i(1280, 720)
    const CELL_SIZE := 20
    const TPS := 5
    const BG_COLOR := Color(0x171717ff)
    const GRID_COLOR := Color(0xe8e8e8ff)


## Handles config file loading and saving.
static func _static_init() -> void:
    var file := ConfigFile.new()
    var error := file.load(CONF_FILE_NAME)
    if error != OK:
        create_config()
    else:
        load_config(file)

## Creates a new config file.
static func create_config() -> void:
    screen_dimensions = Defaults.SCREEN_DIMENSIONS
    cell_size = Defaults.CELL_SIZE
    tps = Defaults.TPS
    bg_color = Defaults.BG_COLOR
    grid_color = Defaults.GRID_COLOR

## Loads a config file.
static func load_config(file: ConfigFile) -> void:
    screen_dimensions = file.get_value("Config", "screen_dimensions", Defaults.SCREEN_DIMENSIONS)
    cell_size = file.get_value("Config", "cell_size", Defaults.CELL_SIZE)
    tps = file.get_value("Config", "tps", Defaults.TPS)
    bg_color = file.get_value("Config", "bg_color", Defaults.BG_COLOR)
    grid_color = file.get_value("Config", "grid_color", Defaults.GRID_COLOR)


## Reloads the config with values from the config window.
static func reload_config(conf_win: ConfigWindow) -> void:
    screen_dimensions = conf_win.get_screen_dimensions()
    cell_size = conf_win.get_cell_size()
    tps = conf_win.get_tps()
    bg_color = conf_win.get_bg_color()
    grid_color = conf_win.get_grid_color()

## Saves the current config to a file.
static func save_config() -> void:
    var file := ConfigFile.new()
    file.set_value("Config", "screen_dimensions", screen_dimensions)
    file.set_value("Config", "cell_size", cell_size)
    file.set_value("Config", "tps", tps)
    file.set_value("Config", "bg_color", bg_color)
    file.set_value("Config", "grid_color", grid_color)
    file.save(CONF_FILE_NAME)