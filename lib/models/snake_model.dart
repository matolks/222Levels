import 'dart:async';
import 'dart:math';
import 'package:levels222_0/pages/home.dart';

// switch out timer periodic for with mixin (animation controller)

class Snake extends StatefulWidget {
  const Snake({super.key, required this.snakeColor});

  final Color snakeColor;

  @override
  State<Snake> createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  Timer? _timer;
  List<List<int>> board = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  ];
  int direction = 0; // 1 U, 2 R, 3 D, 4 L
  int appleCount = 0;
  bool addBody = false;
  List<List<int>> snakeBody = [
    [8, 5],
  ];
  List<int> food = [8, 10];
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // heart beat
  void startGame() {
    _timer = Timer.periodic(const Duration(milliseconds: 140), (_) {
      // Get current head position
      checkCollision();
      int headY = snakeBody[0][0];
      int headX = snakeBody[0][1];
      int newHeadY = headY;
      int newHeadX = headX;
      switch (direction) {
        case 1: // Up
          if (newHeadY > 0) {
            newHeadY -= 1;
          } else {
            _timer?.cancel();
          }
          break;
        case 2: // Right
          if (newHeadX < 17) {
            newHeadX += 1;
          } else {
            _timer?.cancel();
          }
          break;
        case 3: // Down
          if (newHeadY < 17) {
            newHeadY += 1;
          } else {
            _timer?.cancel();
          }
          break;
        case 4: // Left
          if (newHeadX > 0) {
            newHeadX -= 1;
          } else {
            _timer?.cancel();
          }
          break;
      }
      snakeBody.insert(0, [newHeadY, newHeadX]);
      if (!addBody) {
        snakeBody.removeLast();
      } else {
        addBody = false;
      }
      setState(() {});
      checkFoodCollision();
      updateBoard();
    });
  }

  void updateBoard() {
    board = board.map((row) => row.map((_) => 0).toList()).toList();
    for (var segment in snakeBody) {
      int segmentY = segment[0];
      int segmentX = segment[1];
      board[segmentY][segmentX] = 1;
    }
    board[food[0]][food[1]] = 2;
  }

  void changeDirection(int input) {
    if ((direction == 1 && input == 3) ||
        (direction == 2 && input == 4) ||
        (direction == 3 && input == 1) ||
        (direction == 4 && input == 2)) {
      return;
    }
    if (direction == 0) {
      direction = input;
      setState(() {});
      startGame();
    } else if (direction != input) {
      direction = input;
      setState(() {});
    }
  }

  void spawnFood() {
    Random random = Random();
    int randomY = random.nextInt(board.length);
    int randomX = random.nextInt(board[0].length);
    // Ensure the food doesn’t spawn on the snake
    while (board[randomY][randomX] == 1) {
      randomY = random.nextInt(board.length);
      randomX = random.nextInt(board[0].length);
    }
    food = [randomY, randomX];
    board[randomY][randomX] = 2; // Mark food position
  }

  void checkFoodCollision() {
    // If head is on the same position as food
    if (snakeBody.first[0] == food[0] && snakeBody.first[1] == food[1]) {
      addBody = true;
      appleCount++;
      setState(() {});
      spawnFood();
    }
  }

  void checkCollision() {
    // Get head position
    int headY = snakeBody.first[0];
    int headX = snakeBody.first[1];

    // Check for wall collision
    if (headY < 0 ||
        headY >= board.length ||
        headX < 0 ||
        headX >= board[0].length) {
      _timer?.cancel();
    }

    // Check for body collision
    for (int i = 1; i < snakeBody.length; i++) {
      if (snakeBody[i][0] == headY && snakeBody[i][1] == headX) {
        _timer?.cancel();
      }
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight(context) * .7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // board
          SizedBox(
            width: deviceWidth(context) * .96,
            height: deviceWidth(context) * .96,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: board
                  .map(
                    (keyRow) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: keyRow.map((input) {
                        return Container(
                          width: deviceWidth(context) / 20,
                          height: deviceWidth(context) / 20,
                          color: input == 1
                              ? widget.snakeColor
                              : input == 2
                                  ? const Color.fromARGB(255, 219, 71, 71)
                                  : AppColors.darkerGrey,
                        );
                      }).toList(),
                    ),
                  )
                  .toList(),
            ),
          ),
          // controller
          SizedBox(
            child: SizedBox(
              width: deviceWidth(context) * .46,
              height: deviceWidth(context) * .46,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // U
                  SizedBox(
                    height: deviceWidth(context) / 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => changeDirection(1),
                          child: Container(
                            width: deviceWidth(context) / 8,
                            height: deviceWidth(context) / 6,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 88, 106, 123),
                              borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(deviceWidth(context) * .05),
                                topRight:
                                    Radius.circular(deviceWidth(context) * .05),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: deviceWidth(context) / 16,
                                height: deviceWidth(context) / 16,
                                child: CustomPaint(
                                  painter: Triangle(direction: 0),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // L and R
                  SizedBox(
                    height: deviceWidth(context) / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => changeDirection(4),
                          child: Container(
                            width: deviceWidth(context) / 6,
                            height: deviceWidth(context) / 8,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 88, 106, 123),
                              borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(deviceWidth(context) * .05),
                                topLeft:
                                    Radius.circular(deviceWidth(context) * .05),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: deviceWidth(context) / 16,
                                height: deviceWidth(context) / 16,
                                child: CustomPaint(
                                  painter: Triangle(direction: 3),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: deviceWidth(context) / 8,
                          height: deviceWidth(context) / 8,
                          color: const Color.fromARGB(255, 88, 106, 123),
                          child: Center(
                            child: Container(
                              width: deviceWidth(context) / 10,
                              height: deviceWidth(context) / 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xff675c5a),
                                border: Border.all(
                                  color: const Color(0xffcdbca8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => changeDirection(2),
                          child: Container(
                            width: deviceWidth(context) / 6,
                            height: deviceWidth(context) / 8,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 88, 106, 123),
                              borderRadius: BorderRadius.only(
                                topRight:
                                    Radius.circular(deviceWidth(context) * .05),
                                bottomRight:
                                    Radius.circular(deviceWidth(context) * .05),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: deviceWidth(context) / 16,
                                height: deviceWidth(context) / 16,
                                child: CustomPaint(
                                  painter: Triangle(direction: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // D
                  SizedBox(
                    height: deviceWidth(context) / 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => changeDirection(3),
                          child: Container(
                            width: deviceWidth(context) / 8,
                            height: deviceWidth(context) / 6,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 88, 106, 123),
                              borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(deviceWidth(context) * .05),
                                bottomRight:
                                    Radius.circular(deviceWidth(context) * .05),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: deviceWidth(context) / 16,
                                height: deviceWidth(context) / 16,
                                child: CustomPaint(
                                  painter: Triangle(direction: 2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Triangle extends CustomPainter {
  final int direction;

  Triangle({required this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff675c5a)
      ..style = PaintingStyle.fill;

    final stroke = Paint()
      ..color = const Color(0xffcdbca8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path();
    if (direction == 0) {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width * .5, 0);
      path.close();
    } else if (direction == 1) {
      path.moveTo(size.width, size.height / 2);
      path.lineTo(0, 0);
      path.lineTo(0, size.height);
      path.close();
    } else if (direction == 2) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width * .5, size.height);
      path.lineTo(0, 0);
      path.close();
    } else {
      path.moveTo(0, size.height / 2);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.close();
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
