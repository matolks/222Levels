import 'dart:math';

import 'package:levels222_0/pages/home.dart';

class Pong extends StatefulWidget {
  const Pong({super.key});

  @override
  State<Pong> createState() => _PongState();
}

class _PongState extends State<Pong> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool startGame = false;
  double cpuX = 0;
  double userX = 0;
  double ballX = 0.00;
  double ballY = 0.00;
  double ballSpeedX = 0.01;
  double ballSpeedY = 0.01;
  double userPaddleSpeed = 0;
  double cpuPaddleSpeed = .05;
  int userScore = 0;
  int cpuScore = 0;
  double ballWidth = 1 / 25;
  double paddleWidthUser = 2 / 5;
  double paddleWidthCPU = 2 / 4.5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 12),
    )..addListener(_updateGame);
    _resetBall();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateGame() {
    setState(() {
      ballX += ballSpeedX;
      ballY += ballSpeedY;
      userX += userPaddleSpeed;
      ballSpeedX = ballSpeedX.clamp(-0.05, 0.05);
      ballSpeedY = ballSpeedY.clamp(-0.01, 0.01);

      // Clamp user paddle position
      userX = userX.clamp(-1.0, 1.0);

      // CPU paddle AI
      cpuX += (ballX - cpuX) * cpuPaddleSpeed;
      cpuX = cpuX.clamp(-1.0, 1.0);

      // Ball collision with walls
      if (ballX <= -1 + ballWidth || ballX >= 1 - ballWidth) {
        ballSpeedX = -ballSpeedX;
      }

      // Ball collision with paddles
      if (ballY >= 0.8 - ballWidth &&
          ballX >= userX - (paddleWidthUser / 2) &&
          ballX <= userX + (paddleWidthUser / 2)) {
        ballSpeedY = -ballSpeedY;
        ballY = .76;
      }
      if (ballY <= -0.8 + ballWidth &&
          ballX >= cpuX - (paddleWidthCPU / 2) &&
          ballX <= cpuX + (paddleWidthCPU / 2)) {
        ballSpeedY = -ballSpeedY;
        ballY = -.76;
      }

      // Scoring logic
      if (ballY < -.8 - ballWidth) {
        userScore++;
        _resetBall();
      }
      if (ballY > .8 + ballWidth) {
        cpuScore++;
        _resetBall();
      }
    });
  }

  void _resetBall() {
    ballX = 0;
    ballY = 0;
    ballSpeedX =
        (Random().nextDouble() * 0.02 + 0.01) * (Random().nextBool() ? 1 : -1);
    ballSpeedY = (0.01) * (Random().nextBool() ? 1 : -1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context) * .7,
      child: Stack(
        children: [
          // center line
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < 15; i++) ...<Container>{
                  Container(
                    width: deviceWidth(context) / 17,
                    height: deviceWidth(context) / 100,
                    color: const Color.fromARGB(100, 205, 188, 168),
                  )
                }
              ],
            ),
          ),
          // CPU
          Align(
            alignment: Alignment(cpuX, -.8),
            child: Container(
              width: deviceWidth(context) / 4.5,
              height: deviceHeight(context) / 75,
              decoration: BoxDecoration(
                  color: const Color(0xff675c5a),
                  borderRadius:
                      BorderRadius.circular(deviceWidth(context) * .05)),
            ),
          ),
          //BALL
          Align(
            alignment: Alignment(ballX, ballY),
            child: Container(
              width: deviceWidth(context) / 25,
              height: deviceWidth(context) / 25,
              decoration: const BoxDecoration(
                  color: Color(0xffcdbca8), shape: BoxShape.circle),
            ),
          ),
          // USER
          Align(
            alignment: Alignment(userX, .8),
            child: Container(
              width: deviceWidth(context) / 5,
              height: deviceHeight(context) / 75,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 88, 106, 123),
                  borderRadius:
                      BorderRadius.circular(deviceWidth(context) * .05)),
            ),
          ),
          // move left
          Align(
            alignment: const Alignment(-1, 1),
            child: GestureDetector(
              onLongPressDown: (_) {
                if (!startGame) {
                  startGame = true;
                  _controller.repeat();
                }
                userPaddleSpeed = -.02;
              },
              onLongPressUp: () {
                userPaddleSpeed = 0;
              },
              onTapDown: (details) {
                if (!startGame) {
                  startGame = true;
                  _controller.repeat();
                }
                userPaddleSpeed = -.02;
              },
              onTapUp: (details) {
                userPaddleSpeed = 0;
              },
              child: Container(
                margin: EdgeInsets.all(deviceWidth(context) / 55),
                width: deviceWidth(context) * 12 / 25,
                height: deviceHeight(context) * .35,
                color: Color.fromARGB(startGame ? 0 : 25, 205, 188, 168),
                child: startGame
                    ? const SizedBox()
                    : Center(
                        child: appText('Left', const Color(0xffcdbca8),
                            deviceWidth(context) / 10, FontWeight.w400),
                      ),
              ),
            ),
          ),
          // move right
          Align(
            alignment: const Alignment(1, 1),
            child: GestureDetector(
              onLongPressDown: (_) {
                if (!startGame) {
                  startGame = true;
                  _controller.repeat();
                }
                userPaddleSpeed = .02;
              },
              onLongPressUp: () {
                userPaddleSpeed = 0;
              },
              onTapDown: (details) {
                if (!startGame) {
                  startGame = true;
                  _controller.repeat();
                }
                userPaddleSpeed = .02;
              },
              onTapUp: (details) {
                userPaddleSpeed = 0;
              },
              onForcePressEnd: (details) {},
              child: Container(
                margin: EdgeInsets.all(deviceWidth(context) / 55),
                width: deviceWidth(context) * 12 / 25,
                height: deviceHeight(context) * .35,
                color: Color.fromARGB(startGame ? 0 : 25, 205, 188, 168),
                child: startGame
                    ? const SizedBox()
                    : Center(
                        child: appText('Right', const Color(0xffcdbca8),
                            deviceWidth(context) / 10, FontWeight.w400),
                      ),
              ),
            ),
          ),
          // scores
          Align(
            alignment: const Alignment(0, -1),
            child: SizedBox(
              width: deviceWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  appText("User Score: $userScore", const Color(0xffcdbca8),
                      deviceWidth(context) / 18, FontWeight.w600),
                  appText("CPU Score: $cpuScore", const Color(0xffcdbca8),
                      deviceWidth(context) / 18, FontWeight.w600),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
