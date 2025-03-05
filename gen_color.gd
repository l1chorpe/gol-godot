class_name GenColor

enum Op
{
    ADD,
    SUB,
    NIL
}

static var red := 256
static var green := 0
static var blue := 0

static var r_op := Op.NIL
static var g_op := Op.ADD
static var b_op := Op.NIL

static var resolution := 64


static func get_color() -> Color:
    return Color8(red, green, blue)
    #return Color8(red, green, blue)

static func increment() -> void:
    if r_op == Op.ADD:
        red += resolution
        if red == 256:
            r_op = Op.NIL
            b_op = Op.SUB
        return
    
    if g_op == Op.ADD:
        green += resolution
        if green == 256:
            g_op = Op.NIL
            r_op = Op.SUB
        return
    
    if b_op == Op.ADD:
        blue += resolution
        if blue == 256:
            b_op = Op.NIL
            g_op = Op.SUB
        return
    
    if r_op == Op.SUB:
        red -= resolution
        if red == 0:
            r_op = Op.NIL
            b_op = Op.ADD
        return

    if g_op == Op.SUB:
        green -= resolution
        if green == 0:
            g_op = Op.NIL
            r_op = Op.ADD
        return

    if b_op == Op.SUB:
        blue -= resolution
        if blue == 0:
            b_op = Op.NIL
            g_op = Op.ADD