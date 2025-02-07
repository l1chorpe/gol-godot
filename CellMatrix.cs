using Godot;
using Godot.Collections;
using System.Linq;

/// <summary>
/// Handles all operations on the cell matrix. Uses a boolean 2D array for performance.
/// </summary>
public partial class CellMatrix : Node
{
    private bool[,] _cellMatrix;
    private readonly int CM_LENGTH_X, CM_LENGTH_Y;
    private Array<Vector2I> _deadCells = new(), _liveCells = new();

    /// <summary>
    /// Instantiates the matrix.
    /// </summary>
    /// <param name="size">The size of the matrix.</param>
    public CellMatrix(Vector2I size)
    {
        _cellMatrix = new bool[size.X, size.Y];
        (CM_LENGTH_X, CM_LENGTH_Y) = size;
    }

    /// <summary>
    /// Toggles a cell's state between alive (<c>true</c>) or dead (<c>false</c>).
    /// </summary>
    /// <param name="cell">The coordinates of the cell.</param>
    public void ToggleCellState(Vector2I cell) =>
        _cellMatrix[cell.X, cell.Y] = !_cellMatrix[cell.X, cell.Y];
    
    /// <summary>
    /// Returns a cell's state.
    /// </summary>
    /// <param name="cell">The coordinates of the cell.</param>
    /// <returns></returns>
    public bool GetCellState(Vector2I cell) =>
        _cellMatrix[cell.X, cell.Y];

    /// <summary>
    /// Updates the matrix for the next generation, storing the newly dead and newly alive cells in two arrays.
    /// </summary>
    public void Update()
    {
        // Prepare the arrays
        _deadCells.Clear();
        _liveCells.Clear();

        // Check each cell
        for (int i = 0; i < CM_LENGTH_X; ++i)
            for (int j = 0;  j < CM_LENGTH_Y; ++j)
                CheckCell(i, j);

        // Update the matrix
        _deadCells.Concat(_liveCells).ToList().ForEach(cell => ToggleCellState(cell));
    }

    /// <summary>
    /// Resets everything to the initial state.
    /// </summary>
    public void Reset()
    {
        _deadCells.Clear();
        _liveCells.Clear();
        _cellMatrix = new bool[CM_LENGTH_X, CM_LENGTH_Y];
    }

    /// <summary>
    /// Checks if a cell lives or becomes alive or dies.
    /// </summary>
    /// <param name="posX">The cell's x-axis coordinate.</param>
    /// <param name="posY">The cell's y-axis coordindate.</param>
    private void CheckCell(int posX, int posY)
    {
        int neighbor_count = 0;
        int minx = ClampX(posX - 1), maxx = ClampX(posX + 1),
            miny = ClampY(posY - 1), maxy = ClampY(posY + 1);

        for (int x = minx; x <= maxx; ++x)
            for (int y = miny; y <= maxy; ++y)
                if ((x != posX || y != posY) && _cellMatrix[x, y])
                    ++neighbor_count;

        if (_cellMatrix[posX, posY] && (neighbor_count < 2 || neighbor_count > 3))
            _deadCells.Add(new(posX, posY));
        else if (!_cellMatrix[posX, posY] && neighbor_count == 3)
            _liveCells.Add(new(posX, posY));
    }

    /// <summary>
    /// Returns the newly dead cells.
    /// </summary>
    /// <returns>An array of coordinates.</returns>
    public Array<Vector2I> GetDeadCells() => _deadCells;

    /// <summary>
    /// Returns the newly alive cells.
    /// </summary>
    /// <returns>An array of coordinates.</returns>
    public Array<Vector2I> GetLiveCells() => _liveCells;

    private int ClampX(int x)
    {
        if (x < 0) return 0;
        if (x >= CM_LENGTH_X) return CM_LENGTH_X - 1;
        return x;
    }

    private int ClampY(int y)
    {
        if (y < 0) return 0;
        if (y >= CM_LENGTH_Y) return CM_LENGTH_Y - 1;
        return y;
    }
}
