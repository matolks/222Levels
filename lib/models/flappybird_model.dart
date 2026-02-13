import 'dart:math';

import 'package:levels222_0/pages/home.dart';

// need collisison and more variance in pipes

class Flappybird extends StatefulWidget {
  const Flappybird({super.key});

  @override
  State<Flappybird> createState() => _FlappybirdState();
}

class _FlappybirdState extends State<Flappybird> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pipe1;
  late AnimationController _pipe2;
  late AnimationController _pipe3;
  Animation<double>? pipe1X;
  Animation<double>? pipe2X;
  Animation<double>? pipe3X;
  int pipe1Y = 0;
  int pipe2Y = 1;
  int pipe3Y = 2;
  double birdY = 0;
  bool gameStarted = false;
  static const double gravity = 0.001;
  static const double jumpVelocity = -0.02;
  double velocity = 0;

  @override
  void initState() {
    super.initState();
    _pipe1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..addListener(() {
            setState(() {
              if (pipe1X!.value < 0 && !_pipe2.isAnimating) {
                pipe2Y = Random().nextInt(3);
                _pipe2.forward();
              }
              if (_pipe1.isCompleted) {
                _pipe1.reset();
              }
            });
          });
    _pipe2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..addListener(() {
            setState(() {
              if (pipe2X!.value < 0 && !_pipe3.isAnimating) {
                pipe3Y = Random().nextInt(3);
                _pipe3.forward();
              }
              if (_pipe2.isCompleted) {
                _pipe2.reset();
              }
            });
          });
    _pipe3 =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..addListener(() {
            setState(() {
              if (pipe3X!.value < 0 && !_pipe1.isAnimating) {
                pipe1Y = Random().nextInt(3);
                _pipe1.forward();
              }
              if (_pipe3.isCompleted) {
                _pipe3.reset();
              }
            });
          });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 41), // 60 fps - 16, 30 fps - 33, 24 fps - 41
    )..addListener(_updateGame);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pipe1X = Tween<double>(
      begin: 1.4,
      end: -1.4,
    ).animate(
      CurvedAnimation(
        parent: _pipe1,
        curve: Curves.linear,
      ),
    );
    pipe2X = Tween<double>(
      begin: 1.4,
      end: -1.4,
    ).animate(
      CurvedAnimation(
        parent: _pipe2,
        curve: Curves.linear,
      ),
    );
    pipe3X = Tween<double>(
      begin: 1.4,
      end: -1.4,
    ).animate(
      CurvedAnimation(
        parent: _pipe3,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pipe1.dispose();
    _pipe2.dispose();
    _pipe3.dispose();
    super.dispose();
  }

  void _updateGame() {
    setState(() {
      velocity += gravity; // Apply gravity
      birdY += velocity; // Move bird based on velocity
      // Clamp bird position within bounds
      if (birdY > 0.62) {
        birdY = 0.62;
        velocity = 0; // Stop movement at bottom
      } else if (birdY < -1) {
        birdY = -1;
        velocity = 0; // Stop movement at top
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!gameStarted) {
          gameStarted = true;
          velocity = jumpVelocity; // Apply initial jump
          _pipe1.forward();
          _controller.repeat();
        } else {
          setState(() {
            velocity = jumpVelocity; // Smooth jump effect
          });
        }
      },
      child: SizedBox(
        width: deviceWidth(context),
        height: deviceHeight(context) * .72,
        child: Stack(
          children: [
            // Background
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: deviceWidth(context),
                height: deviceHeight(context) * .72,
                child: Image.asset(
                  'lib/assets/images/section13/flappy_bird.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // Bird
            Align(
              alignment: Alignment(0, birdY),
              child: SizedBox(
                width: deviceWidth(context) / 10,
                height: deviceWidth(context) / 14,
                child: Image.asset(
                  'lib/assets/images/section13/bird.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // Tap to Start Text
            gameStarted
                ? const SizedBox()
                : Align(
                    alignment: const Alignment(0, -0.5),
                    child: appText(
                      "Tap To Start",
                      const Color(0xffcdbca8),
                      deviceWidth(context) / 14,
                      FontWeight.w400,
                    ),
                  ),
            // pipe 1
            Align(
              alignment: Alignment(pipe1X?.value ?? 1.4, -1),
              child: SizedBox(
                height: deviceHeight(context) * .58,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //top
                    SizedBox(
                      width: deviceWidth(context) / 6,
                      height: deviceHeight(context) * .29,
                      child: CustomPaint(
                        painter: Sewer(
                            highMedLow: pipe1Y,
                            height: deviceHeight(context) / 3,
                            upDown: false),
                      ),
                    ),
                    // bottom
                    SizedBox(
                      width: deviceWidth(context) / 6,
                      height: deviceHeight(context) * .29,
                      child: CustomPaint(
                        painter: Sewer(
                          highMedLow: pipe1Y,
                          upDown: true,
                          height: deviceHeight(context) / 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // pipe 2
            Align(
              alignment: Alignment(pipe2X?.value ?? 1.4, -1),
              child: SizedBox(
                height: deviceHeight(context) * .58,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //top
                    SizedBox(
                      width: deviceWidth(context) / 6,
                      height: deviceHeight(context) * .29,
                      child: CustomPaint(
                        painter: Sewer(
                            highMedLow: pipe2Y,
                            height: deviceHeight(context) / 3,
                            upDown: false),
                      ),
                    ),
                    // bottom
                    SizedBox(
                      width: deviceWidth(context) / 6,
                      height: deviceHeight(context) * .29,
                      child: CustomPaint(
                        painter: Sewer(
                          highMedLow: pipe2Y,
                          upDown: true,
                          height: deviceHeight(context) / 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // pipe 3
            Align(
              alignment: Alignment(pipe3X?.value ?? 1.4, -1),
              child: SizedBox(
                height: deviceHeight(context) * .58,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //top
                    SizedBox(
                      width: deviceWidth(context) / 6,
                      height: deviceHeight(context) * .29,
                      child: CustomPaint(
                        painter: Sewer(
                            highMedLow: pipe3Y,
                            height: deviceHeight(context) / 3,
                            upDown: false),
                      ),
                    ),
                    // bottom
                    SizedBox(
                      width: deviceWidth(context) / 6,
                      height: deviceHeight(context) * .29,
                      child: CustomPaint(
                        painter: Sewer(
                          highMedLow: pipe3Y,
                          upDown: true,
                          height: deviceHeight(context) / 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sewer extends CustomPainter {
  final bool upDown;
  final double height;
  final int highMedLow;
  final List<Color> grad = [
    const Color.fromARGB(255, 147, 235, 123),
    const Color.fromARGB(255, 117, 196, 95),
    const Color.fromARGB(255, 90, 162, 70),
    const Color.fromARGB(255, 64, 112, 50),
  ];

  Sewer({
    required this.upDown,
    required this.height,
    required this.highMedLow,
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = const Color.fromARGB(255, 67, 111, 57)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final rect = Rect.fromLTWH(0, 0, size.width, height);
    final gradient = LinearGradient(
      colors: grad,
      begin: const Alignment(-1, 0),
      end: const Alignment(1, 0),
    );
    final paint = Paint()..shader = gradient.createShader(rect);
    final path = Path();
    double adjustments = 0;
    double space = size.height * .24;
    if (highMedLow == 2) {
      adjustments = size.height * .25;
    } else if (highMedLow == 0) {
      adjustments = size.height * -.25;
    }

    if (upDown) {
      path.moveTo(size.width * .072, size.height);
      path.lineTo(size.width * .075, size.height * .15 - adjustments + space);
      path.lineTo(size.width * .925, size.height * .15 - adjustments + space);
      path.lineTo(size.width * .925, size.height);
      path.close();
      path.moveTo(0, size.height * .15 - adjustments + space);
      path.lineTo(0, 0 - adjustments + space);
      path.lineTo(size.width, 0 - adjustments + space);
      path.lineTo(size.width, size.height * .15 - adjustments + space);
      path.close();
    } else {
      path.moveTo(size.width * .072, 0);
      path.lineTo(size.width * .075, size.height * .85 - adjustments - space);
      path.lineTo(size.width * .925, size.height * .85 - adjustments - space);
      path.lineTo(size.width * .925, 0);
      path.close();
      path.moveTo(0, size.height * .85 - adjustments - space);
      path.lineTo(0, size.height - adjustments - space);
      path.lineTo(size.width, size.height - adjustments - space);
      path.lineTo(size.width, size.height * .85 - adjustments - space);
      path.close();
    }
    canvas.drawPath(path, paint);
    canvas.drawPath(path, fillStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
