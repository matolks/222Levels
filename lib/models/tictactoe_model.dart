import 'package:levels222_0/pages/home.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  bool userTurn = true;

  List<List<String>> board = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""],
  ];

  void cpuMove() {
    String cpu = "O";
    String player = "X";

    // Step 1: Check for a winning move
    if (findBlockingMove(board, cpu, player, false)) {
      print("CPU Wins"); // add func here
      userTurn = false;
      setState(() {});
      return; // CPU wins
    }

    // Step 2: Check for a blocking move
    if (findBlockingMove(board, player, cpu, true)) {
      userTurn = true;
      setState(() {});
      return; // Block the player
    }

    // Step 3: Take the center if available
    if (board[1][1] == "") {
      board[1][1] = cpu;
      userTurn = true;
      setState(() {});
      return;
    }

    // Step 4: Take a corner if available
    List<List<int>> corners = [
      [0, 0],
      [0, 2],
      [2, 0],
      [2, 2]
    ];
    for (var corner in corners) {
      if (board[corner[0]][corner[1]] == "") {
        board[corner[0]][corner[1]] = cpu;
        userTurn = true;
        setState(() {});
        return;
      }
    }

    // Step 5: Take a side if available
    List<List<int>> sides = [
      [0, 1],
      [1, 0],
      [1, 2],
      [2, 1]
    ];
    for (var side in sides) {
      if (board[side[0]][side[1]] == "") {
        board[side[0]][side[1]] = cpu;
        userTurn = true;
        setState(() {});
        return;
      }
    }
  }

  // for cpu
  bool findBlockingMove(
      List<List<String>> board, String player, String cpu, bool correctOrder) {
    List<List<List<int>>> winConditions = [
      // Rows
      [
        [0, 0],
        [0, 1],
        [0, 2],
      ],
      [
        [1, 0],
        [1, 1],
        [1, 2],
      ],
      [
        [2, 0],
        [2, 1],
        [2, 2],
      ],
      // Columns
      [
        [0, 0],
        [1, 0],
        [2, 0],
      ],
      [
        [0, 1],
        [1, 1],
        [2, 1],
      ],
      [
        [0, 2],
        [1, 2],
        [2, 2],
      ],
      // Diagonals
      [
        [0, 0],
        [1, 1],
        [2, 2],
      ],
      [
        [0, 2],
        [1, 1],
        [2, 0],
      ]
    ];

    for (var condition in winConditions) {
      int countPlayer = 0;
      List<int>? emptyCell;
      for (var cell in condition) {
        int row = cell[0];
        int col = cell[1];
        if (board[row][col] == player) countPlayer++;
        if (board[row][col] == "") emptyCell = cell;
      }
      // If the opponent has 2 marks and one empty space, block it
      if (countPlayer == 2 && emptyCell != null) {
        board[emptyCell[0]][emptyCell[1]] = correctOrder ? cpu : player;
        return true;
      }
    }
    return false; // No blocking move needed
  }

  // check winner for player
  bool checkWinner(List<List<String>> board) {
    String player = "X";
    // Check rows
    for (int row = 0; row < 3; row++) {
      if (board[row][0] == player &&
          board[row][1] == player &&
          board[row][2] == player) {
        return true;
      }
    }

    // Check columns
    for (int col = 0; col < 3; col++) {
      if (board[0][col] == player &&
          board[1][col] == player &&
          board[2][col] == player) {
        return true;
      }
    }
    // Check diagonals
    if (board[0][0] == player &&
        board[1][1] == player &&
        board[2][2] == player) {
      return true;
    }
    if (board[0][2] == player &&
        board[1][1] == player &&
        board[2][0] == player) {
      return true;
    }
    // No winner found
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context) / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: board.asMap().entries.map((rowEntry) {
          int rowIndex = rowEntry.key;
          List<String> keyRow = rowEntry.value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: keyRow.asMap().entries.map((cellEntry) {
              int colIndex = cellEntry.key;
              String input = cellEntry.value;
              return GestureDetector(
                onTap: () {
                  if (userTurn) {
                    board[rowIndex][colIndex] = "X";
                    userTurn = false;
                    setState(() {});
                    if (!checkWinner(board)) {
                      Future.delayed(
                          const Duration(milliseconds: 300), cpuMove);
                    } else {
                      print("Player Win");
                    }
                  }
                },
                child: Container(
                  width: deviceWidth(context) * .3,
                  height: deviceWidth(context) * .3,
                  decoration: BoxDecoration(
                    border: Border(
                      top: rowIndex == 0
                          ? BorderSide.none
                          : const BorderSide(
                              color: Color.fromARGB(255, 88, 106, 123),
                              width: 2,
                            ),
                      left: colIndex == 0
                          ? BorderSide.none
                          : const BorderSide(
                              color: Color.fromARGB(255, 88, 106, 123),
                              width: 2,
                            ),
                      right: colIndex == 2
                          ? BorderSide.none
                          : const BorderSide(
                              color: Color.fromARGB(255, 88, 106, 123),
                              width: 2,
                            ),
                      bottom: rowIndex == 2
                          ? BorderSide.none
                          : const BorderSide(
                              color: Color.fromARGB(255, 88, 106, 123),
                              width: 2,
                            ),
                    ),
                  ),
                  child: Center(
                    child: appText(
                      input,
                      input == "X"
                          ? const Color(0xffcdbca8)
                          : const Color(0xff675c5a),
                      deviceWidth(context) / 5,
                      FontWeight.w200,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
