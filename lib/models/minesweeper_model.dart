import 'dart:math';
import 'package:levels222_0/pages/home.dart';

// need to add a flag button not a touch button

class Minesweeper extends StatefulWidget {
  const Minesweeper({super.key});

  @override
  State<Minesweeper> createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  late Minesweeperlogic game;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    setState(() {
      game = Minesweeperlogic(rows: 15, cols: 15, mines: 25);
    });
  }

  Widget _buildCell(int row, int col) {
    bool isRevealed = game.revealed[row][col];
    bool isFlagged = game.flagged[row][col];
    int cellValue = game.board[row][col];

    return GestureDetector(
      onTap: () {
        setState(() {
          game.revealCell(row, col);
        });
      },
      onLongPress: () {
        setState(() {
          game.toggleFlag(row, col);
        });
      },
      child: Container(
        width: deviceWidth(context) / 16,
        height: deviceWidth(context) / 16,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffcdbca8),
          ),
          color: isRevealed
              ? const Color(0xff675c5a)
              : const Color.fromARGB(255, 88, 106, 123),
        ),
        child: Center(
          child: isFlagged
              ? Icon(
                  Icons.flag,
                  color: const Color.fromARGB(255, 234, 74, 62),
                  size: deviceWidth(context) / 25,
                )
              : isRevealed
                  ? (cellValue == -1
                      ? Icon(
                          Icons.warning,
                          color: Colors.black,
                          size: deviceWidth(context) / 25,
                        )
                      : Text(cellValue > 0 ? '$cellValue' : ''))
                  : null,
        ),
      ),
    );
  }

  Widget _buildBoard() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: game.cols,
      ),
      itemCount: game.rows * game.cols,
      itemBuilder: (context, index) {
        int row = index ~/ game.cols;
        int col = index % game.cols;
        return _buildCell(row, col);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: deviceWidth(context) * .96,
            height: deviceWidth(context) * .96,
            child: _buildBoard()),
      ],
    );
  }
}

class Minesweeperlogic {
  int rows;
  int cols;
  int mines;
  late List<List<int>> board;
  late List<List<bool>> revealed;
  late List<List<bool>> flagged;
  late bool gameOver;
  late bool gameWon;

  Minesweeperlogic(
      {required this.rows, required this.cols, required this.mines}) {
    board = List.generate(rows, (_) => List.filled(cols, 0));
    revealed = List.generate(rows, (_) => List.filled(cols, false));
    flagged = List.generate(rows, (_) => List.filled(cols, false));
    gameOver = false;
    gameWon = false;
    _initializeBoard();
  }

  void _initializeBoard() {
    // Place mines randomly
    Random random = Random();
    int minesPlaced = 0;
    while (minesPlaced < mines) {
      int row = random.nextInt(rows);
      int col = random.nextInt(cols);
      if (board[row][col] != -1) {
        board[row][col] = -1; // -1 represents a mine
        minesPlaced++;
      }
    }

    // Calculate numbers for non-mine cells
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (board[i][j] != -1) {
          board[i][j] = _countAdjacentMines(i, j);
        }
      }
    }
  }

  int _countAdjacentMines(int row, int col) {
    int count = 0;
    for (int i = row - 1; i <= row + 1; i++) {
      for (int j = col - 1; j <= col + 1; j++) {
        if (i >= 0 && i < rows && j >= 0 && j < cols && board[i][j] == -1) {
          count++;
        }
      }
    }
    return count;
  }

  void revealCell(int row, int col) {
    if (gameOver || revealed[row][col] || flagged[row][col]) return;
    revealed[row][col] = true;
    if (board[row][col] == -1) {
      gameOver = true;
      return;
    }
    if (board[row][col] == 0) {
      // Reveal adjacent cells if the current cell is empty
      for (int i = row - 1; i <= row + 1; i++) {
        for (int j = col - 1; j <= col + 1; j++) {
          if (i >= 0 && i < rows && j >= 0 && j < cols && !revealed[i][j]) {
            revealCell(i, j);
          }
        }
      }
    }
    _checkWin();
  }

  void toggleFlag(int row, int col) {
    if (!gameOver && !revealed[row][col]) {
      flagged[row][col] = !flagged[row][col];
    }
  }

  void _checkWin() {
    int unrevealedSafeCells = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (board[i][j] != -1 && !revealed[i][j]) {
          unrevealedSafeCells++;
        }
      }
    }
    if (unrevealedSafeCells == 0) {
      gameWon = true;
      gameOver = true;
    }
  }
}
