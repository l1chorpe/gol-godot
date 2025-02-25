extends Node

var CellMatrix = load("res://CellMatrix.cs")
@onready var cell_matrix = CellMatrix.new(Config.screen_dimensions)

var cell_scene = preload("res://cell.tscn")


## Handles input events.
func _input(event: InputEvent) -> void:
    if event.is_action_pressed("quit"):
        Config.save_config()
        get_tree().quit()
    # Toggles a cell upon a click
    elif event.is_action_pressed("click"):
        toggle_cell(get_viewport().get_mouse_position() / Config.cell_size as Vector2i)
    # Plays or pauses the game
    elif event.is_action_pressed("playpause"):
        if $GameTick.is_stopped():
            $GameTick.start()
        else:
            $GameTick.stop()
    # Executes only one game tick
    elif event.is_action_pressed("exec_one_step"):
        on_game_tick()
    # Resets the game
    elif event.is_action_pressed("reset"):
        cell_matrix.Reset()
        for child in get_children():
            if child is Cell:
                child.queue_free()
    # Toggles the configuration window
    elif event.is_action_pressed("toggle_config_window"):
        $ConfigWindow.visible = !$ConfigWindow.visible

## Handles toggling a cell on and off.
## [br][br]
## Takes a cell coordinates as a [Vector2i], and toggles a cell's state in the boolean matrix and as a Node on screen.
func toggle_cell(cell_pos: Vector2i) -> void:
    cell_matrix.ToggleCellState(cell_pos)
    if(cell_matrix.GetCellState(cell_pos)):
        create_cell(cell_pos)
    else:
        delete_cell(cell_pos)

## Creates a new [Cell] on the screen.
## [br][br]
## Takes coordinates as [Vector2i] and creates a [Cell] in that location on the screen.
func create_cell(cell_pos: Vector2i) -> void:
    var new_cell: Cell = cell_scene.instantiate()
    new_cell.grid_pos = cell_pos
    add_child(new_cell)

## Removes a cell from the screen.
## [br][br]
## Takes coordinates as [Vector2i] and finds the corresponding [Cell] in the children, and calls [method Node.queue_free()] on it
func delete_cell(pos: Vector2i) -> void:
    # Could be a one-liner with filter() but it's less efficient since it could unnecessarily traverse the whole Array
    for child in get_children():
        if child is Cell && (child as Cell).isAt(pos):
            child.queue_free()
            return

## Like [method create_cell] but for multiple cells at a time.
func create_cells(pos_list: Array) -> void:
    for pos: Vector2i in pos_list:
        create_cell(pos)

## Like [method delete_cell] but for multiple cells at a time.
func delete_cells(pos_list: Array) -> void:
    for pos: Vector2i in pos_list:
        delete_cell(pos)
        
## This function is called at each game tick by the GameTick [Timer].
func on_game_tick() -> void:
    cell_matrix.Update()
    delete_cells(cell_matrix.GetDeadCells())
    create_cells(cell_matrix.GetLiveCells())
    

## Reloads and redraws the game.
func reload_game() -> void:
    $GameTick.stop()

    # Reset the grid
    for child in get_children():
        if child is Cell:
            child.queue_free()
    cell_matrix = CellMatrix.new(Config.screen_dimensions)

    # Redraw the grid
    $Grid.queue_redraw()
