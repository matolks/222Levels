import 'dart:async';
import 'package:levels222_0/pages/home.dart';

// NEED TO HIGHLIGHT WINNING PIECES

class ConnectFour extends StatefulWidget {
  const ConnectFour({
    super.key,
    required this.backgroundColor,
    required this.chipColors,
  });

  final Color backgroundColor;
  final List<Color> chipColors;

  @override
  State<ConnectFour> createState() => _ConnectFourState();
}

class _ConnectFourState extends State<ConnectFour> {
  // 1 is user, 2 is CPU
  static const int cpu = 2;
  static const int user = 1;
  static const int maxDepth = 5;
  List<int> displayChip = [0, 0, 0, 0, 0, 0, 0];
  List<List<int>> board = [
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
  ];
  bool userTurn = true;
  bool moveSelected = false;
  List<double> opacity = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // moves user
  void moveUserChip(index) async {
    int i = 0;
    Future.delayed(const Duration(milliseconds: 150), () {
      displayChip = displayChip.map((_) => 0).toList();
      setState(() {});
    });
    _timer = Timer.periodic(const Duration(milliseconds: 150), (_) {
      if (i > maxDepth || board[i][index] != 0) {
        _timer?.cancel();
        if (checkWin(board, user)) {
          print("Player Win");
        } else {
          moveCpuChip();
        }
      } else {
        if (i > 0) {
          board[i - 1][index] = 0;
        }
        board[i][index] = user;
        i++;
        setState(() {});
      }
    });
  }

  // check for win
  bool checkWin(List<List<int>> board, int player) {
    // Check horizontal
    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        if (board[row][col] == player &&
            board[row][col + 1] == player &&
            board[row][col + 2] == player &&
            board[row][col + 3] == player) {
          return true;
        }
      }
    }
    // Check vertical
    for (int col = 0; col < 7; col++) {
      for (int row = 0; row < 3; row++) {
        if (board[row][col] == player &&
            board[row + 1][col] == player &&
            board[row + 2][col] == player &&
            board[row + 3][col] == player) {
          return true;
        }
      }
    }
    // Check diagonal (top-left to bottom-right)
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 4; col++) {
        if (board[row][col] == player &&
            board[row + 1][col + 1] == player &&
            board[row + 2][col + 2] == player &&
            board[row + 3][col + 3] == player) {
          return true;
        }
      }
    }
    // Check diagonal (bottom-left to top-right)
    for (int row = 3; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        if (board[row][col] == player &&
            board[row - 1][col + 1] == player &&
            board[row - 2][col + 2] == player &&
            board[row - 3][col + 3] == player) {
          return true;
        }
      }
    }
    return false;
  }

  // checks if board is full
  bool isBoardFull(List<List<int>> board) {
    for (var row in board) {
      if (row.contains(0)) return false;
    }
    return true;
  }

  // mini max algo
  int minimax(List<List<int>> board, int depth, bool isMaximizing) {
    if (checkWin(board, cpu)) return 1000; // CPU win
    if (checkWin(board, user)) return -1000; // User win
    if (isBoardFull(board)) return 0; // Draw
    if (depth == 0) return evaluateBoard(board); // Heuristic score

    if (isMaximizing) {
      int maxEval = -9999;
      for (int col = 0; col < 7; col++) {
        int row = getAvailableRow(board, col);
        if (row != -1) {
          board[row][col] = cpu;
          int eval = minimax(board, depth - 1, false);
          board[row][col] = 0;
          maxEval = eval > maxEval ? eval : maxEval;
        }
      }
      return maxEval;
    } else {
      int minEval = 9999;
      for (int col = 0; col < 7; col++) {
        int row = getAvailableRow(board, col);
        if (row != -1) {
          board[row][col] = user;
          int eval = minimax(board, depth - 1, true);
          board[row][col] = 0;
          minEval = eval < minEval ? eval : minEval;
        }
      }
      return minEval;
    }
  }

  // best move for cpu
  int getBestMove(List<List<int>> board) {
    int bestScore = -9999;
    int bestColumn = 0;

    for (int col = 0; col < 7; col++) {
      int row = getAvailableRow(board, col);
      if (row != -1) {
        board[row][col] = cpu;
        int score = minimax(board, maxDepth, false);
        board[row][col] = 0;
        if (score > bestScore) {
          bestScore = score;
          bestColumn = col;
        }
      }
    }

    return bestColumn;
  }

  // gets deepest available row
  int getAvailableRow(List<List<int>> board, int col) {
    for (int row = 5; row >= 0; row--) {
      if (board[row][col] == 0) return row;
    }
    return -1;
  }

  // evaluates board
  int evaluateBoard(List<List<int>> board) {
    int score = 0;

    // Score center column higher (strategic advantage)
    for (int row = 0; row < 6; row++) {
      if (board[row][3] == cpu) {
        score += 3;
      } else if (board[row][3] == user) {
        score -= 3;
      }
    }

    // Evaluate horizontal, vertical, and diagonal sequences
    score += scoreLines(board, cpu);
    score -= scoreLines(board, user);

    return score;
  }

  // scores lines
  int scoreLines(List<List<int>> board, int player) {
    int score = 0;

    // Horizontal
    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        List<int> line = [
          board[row][col],
          board[row][col + 1],
          board[row][col + 2],
          board[row][col + 3]
        ];
        score += evaluateLine(line, player);
      }
    }

    // Vertical
    for (int col = 0; col < 7; col++) {
      for (int row = 0; row < 3; row++) {
        List<int> line = [
          board[row][col],
          board[row + 1][col],
          board[row + 2][col],
          board[row + 3][col]
        ];
        score += evaluateLine(line, player);
      }
    }

    // Diagonal (top-left to bottom-right)
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 4; col++) {
        List<int> line = [
          board[row][col],
          board[row + 1][col + 1],
          board[row + 2][col + 2],
          board[row + 3][col + 3]
        ];
        score += evaluateLine(line, player);
      }
    }

    // Diagonal (bottom-left to top-right)
    for (int row = 3; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        List<int> line = [
          board[row][col],
          board[row - 1][col + 1],
          board[row - 2][col + 2],
          board[row - 3][col + 3]
        ];
        score += evaluateLine(line, player);
      }
    }

    return score;
  }

  // finds winning moves
  int evaluateLine(List<int> line, int player) {
    int score = 0;
    int countPlayer = line.where((cell) => cell == player).length;
    int countEmpty = line.where((cell) => cell == 0).length;
    if (countPlayer == 4) {
      score += 100;
    } // Winning line
    else if (countPlayer == 3 && countEmpty == 1) {
      score += 5;
    } // 3 in a row
    else if (countPlayer == 2 && countEmpty == 2) {
      score += 2;
    } // 2 in a row
    return score;
  }

  // moves for CPU // check for cpu win after
  void moveCpuChip() {
    int bestColumn = getBestMove(board);
    int row = getAvailableRow(board, bestColumn);
    displayChip[bestColumn] = cpu;
    setState(() {});
    if (row != -1) {
      int i = 0;
      _timer = Timer.periodic(const Duration(milliseconds: 150), (_) {
        if (i > row) {
          _timer?.cancel();
          setState(() {});
          if (checkWin(board, cpu)) {
            print("cpu win");
          } else if (isBoardFull(board)) {
            // Draw
            print("tie");
          } else {
            userTurn = true;
            setState(() {});
          }
        } else {
          if (i > 0) {
            board[i - 1][bestColumn] = 0;
          } else {
            displayChip[bestColumn] = 0;
          }
          board[i][bestColumn] = cpu;
          i++;
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context) * .7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // dislay chip
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < displayChip.length; i++) ...<SizedBox>{
                  SizedBox(
                    width: deviceWidth(context) / 8,
                    height: deviceWidth(context) / 8,
                    child: Center(
                      child: Container(
                        width: deviceWidth(context) / 9.25,
                        height: deviceWidth(context) / 9.25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: displayChip[i] == 0
                              ? AppColors.backgroundColor
                              : displayChip[i] == 1
                                  ? widget.chipColors[0]
                                  : widget.chipColors[1],
                        ),
                      ),
                    ),
                  ),
                }
              ],
            ),
          ),
          // board
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: board.asMap().entries.map((rowEntry) {
              List<int> keyRow = rowEntry.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: keyRow.asMap().entries.map((cellEntry) {
                  int colIndex = cellEntry.key;
                  int input = cellEntry.value;
                  return GestureDetector(
                    onTap: () {
                      if (userTurn) {
                        if (opacity[colIndex] < 1.0) {
                          opacity[colIndex] = 1.0;
                          displayChip[colIndex] = 0;
                          moveSelected = false;
                        } else if (board[0][colIndex] == 0) {
                          opacity = opacity.map((_) => 1.0).toList();
                          displayChip = displayChip.map((_) => 0).toList();
                          opacity[colIndex] = .5;
                          displayChip[colIndex] = user;
                          moveSelected = true;
                        }
                        setState(() {});
                      }
                    },
                    child: Opacity(
                      opacity: opacity[colIndex],
                      child: Container(
                        width: deviceWidth(context) / 8,
                        height: deviceWidth(context) / 8,
                        color: widget.backgroundColor,
                        child: Center(
                          child: Container(
                            width: deviceWidth(context) / 9.25,
                            height: deviceWidth(context) / 9.25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: input == 0
                                  ? AppColors.backgroundColor
                                  : input == 1
                                      ? widget.chipColors[0]
                                      : widget.chipColors[1],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
          // play button
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 15),
            child: GestureDetector(
              onTap: () {
                if (moveSelected) {
                  int index = opacity.indexOf(.5);
                  userTurn = false;
                  moveSelected = false;
                  opacity = opacity.map((_) => 1.0).toList();
                  setState(() {});
                  moveUserChip(index);
                }
              },
              child: Opacity(
                opacity: moveSelected ? 1 : .5,
                child: button(
                    context,
                    const Color(0xff675c5a),
                    const Color(0xffcdbca8),
                    const Color.fromARGB(255, 88, 106, 123),
                    "Play Move",
                    const Color(0xffcdbca8),
                    null),
              ),
            ),
          )
        ],
      ),
    );
  }
}
