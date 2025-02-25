## Handles the configuration of the game.
class_name Config


# Config file location
const CONF_FILE_NAME = "user://golgodot.cfg"

# Config variables
static var screen_dimensions: Vector2i
static var cell_size: int
static var tps: int


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
    screen_dimensions = Vector2i(1280, 720)
    cell_size = 20
    tps = 5

## Loads a config file.
static func load_config(file: ConfigFile) -> void:
    screen_dimensions = parse_screen_dimensions(file.get_value("Config", "screen_dimensions", "1280x720"))
    cell_size = file.get_value("Config", "cell_size", 20).to_int()
    tps = file.get_value("Config", "tps", 5).to_int()

## Reloads the config with values from the config window.
static func reload_config(conf_win: ConfigWindow) -> void:
    screen_dimensions = conf_win.get_screen_dimensions()
    cell_size = conf_win.get_cell_size()
    tps = conf_win.get_tps()

## Saves the current config to a file.
static func save_config() -> void:
    var file := ConfigFile.new()
    file.set_value("Config", "screen_dimensions", screen_dimensions)
    file.set_value("Config", "cell_size", cell_size)
    file.set_value("Config", "tps", tps)
    file.save(CONF_FILE_NAME)

## Parses string screen dimensions (like "1280x720") into a Vector2i.
static func parse_screen_dimensions(value: String) -> Vector2i:
    var values := value.split("x")
    return Vector2i(values[0].to_int(), values[1].to_int())