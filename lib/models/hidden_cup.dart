import 'dart:async';
import 'dart:math';
import 'package:levels222_0/pages/home.dart';

class HiddenCup extends StatefulWidget {
  const HiddenCup({super.key, required this.checkAd});

  final void Function(bool) checkAd;

  @override
  State<HiddenCup> createState() => _HiddenCupState();
}

class _HiddenCupState extends State<HiddenCup> with TickerProviderStateMixin {
  bool started = false;
  bool finished = false;
  bool? guessedCup;
  int count = 0;
  late AnimationController showBall;
  late AnimationController cupsMoving;
  Animation<double>? upCup;
  Timer? cupUpTimer;
  Timer? cupsMovingTimer;
  late List<double> ballSpot = [
    deviceWidth(context) * .135,
    deviceWidth(context) * .45,
    deviceWidth(context) * .7675,
  ];
  int moveBall = 0;
  late int temp;
  double ballOpacity = 1;
  // left cup
  Animation<double>? oneTo2;
  Animation<double>? oneTo3;
  Animation<double>? oneTo1;
  // middle cup
  Animation<double>? twoTo1;
  Animation<double>? twoTo3;
  Animation<double>? twoTo2;
  // right cup
  Animation<double>? threeTo2;
  Animation<double>? threeTo1;
  Animation<double>? threeTo3;
  // animation paths
  List<Animation<double>>? cup1;
  List<Animation<double>>? cup2;
  List<Animation<double>>? cup3;
  // paths 2-1-0
  late List<List<List<Animation<double>>>>? paths = [
    [
      [
        oneTo2!,
        oneTo2!,
        oneTo3!,
        oneTo3!,
        oneTo1!,
        oneTo1!,
        oneTo2!,
        oneTo3!,
        oneTo3!,
        oneTo2!,
        oneTo1!,
        oneTo3!,
      ],
      [
        twoTo3!,
        twoTo1!,
        twoTo1!,
        twoTo1!,
        twoTo3!,
        twoTo3!,
        twoTo3!,
        twoTo1!,
        twoTo1!,
        twoTo1!,
        twoTo3!,
        twoTo1!,
      ],
      [
        threeTo1!,
        threeTo3!,
        threeTo2!,
        threeTo2!,
        threeTo2!,
        threeTo2!,
        threeTo1!,
        threeTo2!,
        threeTo2!,
        threeTo3!,
        threeTo2!,
        threeTo2!,
      ]
    ],
    [
      [
        oneTo3!,
        oneTo2!,
        oneTo1!,
        oneTo3!,
        oneTo3!,
        oneTo3!,
        oneTo3!,
        oneTo3!,
        oneTo1!,
        oneTo1!,
        oneTo1!,
        oneTo2!,
      ],
      [
        twoTo2!,
        twoTo1!,
        twoTo3!,
        twoTo2!,
        twoTo1!,
        twoTo1!,
        twoTo2!,
        twoTo1!,
        twoTo3!,
        twoTo3!,
        twoTo3!,
        twoTo1!,
      ],
      [
        threeTo1!,
        threeTo3!,
        threeTo2!,
        threeTo1!,
        threeTo2!,
        threeTo2!,
        threeTo1!,
        threeTo2!,
        threeTo2!,
        threeTo2!,
        threeTo2!,
        threeTo3!,
      ]
    ],
    [
      [
        oneTo2!,
        oneTo2!,
        oneTo2!,
        oneTo1!,
        oneTo3!,
        oneTo3!,
        oneTo3!,
        oneTo2!,
        oneTo1!,
        oneTo1!,
        oneTo1!,
        oneTo1!,
      ],
      [
        twoTo1!,
        twoTo1!,
        twoTo1!,
        twoTo3!,
        twoTo2!,
        twoTo2!,
        twoTo2!,
        twoTo3!,
        twoTo3!,
        twoTo3!,
        twoTo3!,
        twoTo3!,
      ],
      [
        threeTo3!,
        threeTo3!,
        threeTo3!,
        threeTo2!,
        threeTo1!,
        threeTo1!,
        threeTo1!,
        threeTo1!,
        threeTo2!,
        threeTo2!,
        threeTo2!,
        threeTo2!,
      ]
    ]
  ];

  @override
  void initState() {
    showBall = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    showBall.addListener(() {
      setState(() {});
    });
    cupsMoving = AnimationController(
      duration: const Duration(milliseconds: 225),
      vsync: this,
    );
    cupsMoving.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // UP CUP
    upCup = Tween<double>(
      begin: deviceHeight(context) * (11 / 30),
      end: deviceHeight(context) * (7 / 30),
    ).animate(
      CurvedAnimation(
        parent: showBall,
        curve: Curves.linear,
      ),
    );
    // LEFT CUP
    // 1-2
    oneTo2 = Tween<double>(
      begin: deviceWidth(context) / 20,
      end: deviceWidth(context) * (11 / 30),
    ).animate(
      CurvedAnimation(
        parent: cupsMoving,
        curve: Curves.linear,
      ),
    );
    // 1-3
    oneTo3 = Tween<double>(
      begin: deviceWidth(context) / 20,
      end: deviceWidth(context) * (41 / 60),
    ).animate(
      CurvedAnimation(
        parent: cupsMoving,
        curve: Curves.linear,
      ),
    );
    // 1-1
    oneTo1 = Tween<double>(
      begin: deviceWidth(context) / 20,
      end: deviceWidth(context) / 20,
    ).animate(
      CurvedAnimation(
        parent: cupsMoving,
        curve: Curves.linear,
      ),
    );
    // MIDDLE CUP
    // 2-1
    twoTo1 = Tween<double>(
      begin: deviceWidth(context) * (11 / 30),
      end: deviceWidth(context) / 20,
    ).animate(
      CurvedAnimation(
        parent: cupsMoving,
        curve: Curves.linear,
      ),
    );
    // 2-3
    twoTo3 = Tween<double>(
      begin: deviceWidth(context) * (11 / 30),
      end: deviceWidth(context) * (41 / 60),
    ).animate(
      CurvedAnimation(
        parent: cupsMoving,
        curve: Curves.linear,
      ),
    );
    // 2-2
    twoTo2 = Tween<double>(
      begin: deviceWidth(context) * (11 / 30),
      end: deviceWidth(context) * (11 / 30),
    ).animate(
      CurvedAnimation(
        parent: cupsMoving,
        curve: Curves.linear,
      ),
    );
    // RIGHT CUP
    // 3-1
    threeTo1 = Tween<double>(
      begin: deviceWidth(context) * (41 / 60),
      end: deviceWidth(context) / 20,
    ).animate(
      CurvedAnimation(
        parent: cupsMoving,
        curve: Curves.linear,
      ),
    );
    // 3-2
    threeTo2 = Tween<double>(
      begin: deviceWidth(context) * (41 / 60),
      end: deviceWidth(context) * (11 / 30),
    ).animate(
      CurvedAnimation(
        parent: cupsMoving,
        curve: Curves.linear,
      ),
    );
    // 3-3
    threeTo3 = Tween<double>(
      begin: deviceWidth(context) * (41 / 60),
      end: deviceWidth(context) * (41 / 60),
    ).animate(
      CurvedAnimation(
        parent: cupsMoving,
        curve: Curves.linear,
      ),
    );
    temp = Random().nextInt(3);
    cup1 = paths![temp][0];
    cup2 = paths![temp][1];
    cup3 = paths![temp][2];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    showBall.dispose();
    cupsMoving.dispose();
    cupsMovingTimer?.cancel();
    super.dispose();
  }

  // starts game
  void startGame() {
    temp = Random().nextInt(3);
    cup1 = paths![temp][0];
    cup2 = paths![temp][1];
    cup3 = paths![temp][2];
    setState(() {});
    showBall.forward();
    cupUpTimer = Timer(const Duration(seconds: 1), () {
      showBall.reverse();
    });
    cupUpTimer = Timer(const Duration(seconds: 3), () {
      ballOpacity = 0;
      moveBall = 2 - temp;
      moveCups();
    });
    started = true;
    setState(() {});
  }

  // moves cup
  void moveCups() {
    cupsMovingTimer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      cupsMoving.reset();
      setState(() {});
      cupsMoving.forward();
      count++;
      if (count > 10) {
        cupsMovingTimer?.cancel();
        cupUpTimer = Timer(const Duration(milliseconds: 575), () {
          finished = true;
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // start button and return button
          !started
              ? Positioned(
                  bottom: deviceHeight(context) / 4,
                  child: GestureDetector(
                    onTap: () {
                      startGame();
                    },
                    child: button(
                        context,
                        const Color(0xff97BC62),
                        const Color(0xff2C5F2D),
                        const Color(0xff2C5F2D),
                        "Start",
                        const Color(0xff97BC62),
                        null),
                  ),
                )
              : guessedCup != null && guessedCup == false
                  ? Positioned(
                      bottom: deviceHeight(context) / 4,
                      child: GestureDetector(
                        onTap: () {
                          widget.checkAd(false);
                        },
                        child: SizedBox(
                          width: deviceWidth(context),
                          child: button(
                              context,
                              const Color(0xff97BC62),
                              const Color(0xff2C5F2D),
                              const Color(0xff2C5F2D),
                              '👈 Wrong! Get Back',
                              AppColors.lightGrey,
                              null),
                        ),
                      ),
                    )
                  : const SizedBox(),
          finished
              ? Positioned(
                  bottom: deviceHeight(context) / 3.5,
                  child: appText("Guess the cup", AppColors.lightGrey,
                      deviceWidth(context) / 20, FontWeight.w500),
                )
              : Positioned(
                  bottom: deviceHeight(context) / 3.5,
                  child: appText(
                      guessedCup == true ? 'Good Job Fr' : "",
                      AppColors.lightGrey,
                      deviceWidth(context) / 20,
                      FontWeight.w500),
                ),
          // ball
          Positioned(
            left: !started ? deviceWidth(context) * .135 : ballSpot[moveBall],
            top: deviceHeight(context) * .5175,
            child: Container(
              width: deviceWidth(context) / 10,
              height: deviceWidth(context) / 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(ballOpacity)),
            ),
          ),
          // cups
          Positioned(
            left: mounted ? cup1![count].value : deviceWidth(context) / 20,
            top: mounted ? upCup!.value : deviceHeight(context) * (11 / 30),
            child: GestureDetector(
              onTap: () {
                if (finished) {
                  finished = false;
                  guessedCup = true;
                  ballOpacity = 1;
                  setState(() {});
                  widget.checkAd(true);
                  showBall.forward();
                }
              },
              child: Container(
                color: AppColors.backgroundColor.withOpacity(0),
                height: deviceWidth(context) / 2.25,
                width: deviceWidth(context) / 3.75,
                child: CustomPaint(
                  painter: SoloCup(),
                ),
              ),
            ),
          ),
          Positioned(
            left:
                mounted ? cup2![count].value : deviceWidth(context) * (11 / 30),
            top: deviceHeight(context) * (11 / 30),
            child: GestureDetector(
              onTap: () {
                if (finished) {
                  finished = false;
                  guessedCup = false;
                  ballOpacity = 1;
                  setState(() {});
                  showBall.forward();
                }
              },
              child: Container(
                color: AppColors.backgroundColor.withOpacity(0),
                height: deviceWidth(context) / 2.25,
                width: deviceWidth(context) / 3.75,
                child: CustomPaint(
                  painter: SoloCup(),
                ),
              ),
            ),
          ),
          Positioned(
            left:
                mounted ? cup3![count].value : deviceWidth(context) * (41 / 60),
            top: deviceHeight(context) * (11 / 30),
            child: GestureDetector(
              onTap: () {
                if (finished) {
                  finished = false;
                  guessedCup = false;
                  ballOpacity = 1;
                  setState(() {});
                  showBall.forward();
                }
              },
              child: Container(
                color: AppColors.backgroundColor.withOpacity(0),
                height: deviceWidth(context) / 2.25,
                width: deviceWidth(context) / 3.75,
                child: CustomPaint(
                  painter: SoloCup(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SoloCup extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = AppColors.lightGrey
      ..style = PaintingStyle.fill;

    final strokeCup = Paint()
      ..color = const Color(0xffBE2E2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillCup = Paint()
      ..color = const Color(0xffDE3A3A)
      ..style = PaintingStyle.fill;

    final fillShade = Paint()
      ..color = const Color(0xffFF5C5C)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * .5, size.height);
    path.lineTo(size.width * .05, size.height);
    path.arcToPoint(Offset(size.width * .05, size.height * .95),
        radius: const Radius.circular(1));
    path.lineTo(size.width * .95, size.height * .95);
    path.arcToPoint(Offset(size.width * .95, size.height),
        radius: const Radius.circular(1));
    path.close();
    final path2 = Path();
    path2.moveTo(size.width * .075, size.height * .95);
    path2.lineTo(size.width * .1, size.height * .75);
    path2.lineTo(size.width * .9, size.height * .75);
    path2.lineTo(size.width * .925, size.height * .95);
    path2.close();
    path2.moveTo(size.width * .125, size.height * .75);
    path2.lineTo(size.width * .15, size.height * .425);
    path2.lineTo(size.width * .85, size.height * .425);
    path2.lineTo(size.width * .875, size.height * .75);
    path2.moveTo(size.width * .175, size.height * .425);
    path2.lineTo(size.width * .185, size.height * .25);
    path2.lineTo(size.width * .815, size.height * .25);
    path2.lineTo(size.width * .825, size.height * .425);
    path2.moveTo(size.width * .2, size.height * .25);
    path2.lineTo(size.width * .2, size.height * .23);
    path2.lineTo(size.width * .8, size.height * .23);
    path2.lineTo(size.width * .8, size.height * .25);
    final path3 = Path();
    path3.moveTo(size.width * .125, size.height * .925);
    path3.lineTo(size.width * .165, size.height * .785);
    path3.lineTo(size.width * .25, size.height * .785);
    path3.lineTo(size.width * .21, size.height * .925);
    path3.moveTo(size.width * .175, size.height * .725);
    path3.lineTo(size.width * .215, size.height * .47);
    path3.lineTo(size.width * .3, size.height * .47);
    path3.lineTo(size.width * .26, size.height * .725);
    path3.moveTo(size.width * .24, size.height * .4);
    path3.lineTo(size.width * .255, size.height * .275);
    path3.lineTo(size.width * .34, size.height * .275);
    path3.lineTo(size.width * .33, size.height * .4);

    canvas.drawPath(path2, fillCup);
    canvas.drawPath(path2, strokeCup);
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path3, fillShade);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
