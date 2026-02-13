import 'dart:async';
import 'dart:math';
import 'package:levels222_0/models/check_fail.dart';
import 'package:levels222_0/models/splitting_widget.dart';
import 'package:levels222_0/pages/home.dart';

class Section6 extends StatefulWidget {
  const Section6({super.key});

  @override
  State<Section6> createState() => _Section6State();
}

class _Section6State extends State<Section6> with TickerProviderStateMixin {
  bool showHome = true;
  int currentPage = 0;
  int adjustPage = 0;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = 1;
  List<String> titles = [
    'Pizza Pizza',
    'Thread It',
    'Lead It',
    'Half It',
    'Fourth It',
    'Nice',
    'Hammer Time',
  ];
  Timer? timer;
  late AnimationController slow;
  late AnimationController medium;
  late AnimationController clicked;
  bool fwrd = true;
  bool clkd = false;
  bool isGood = false;
  // Pizza Level
  Animation<double>? pizzaMoving;
  Animation<double>? pizzaUp;
  // Needle Level
  Animation<double>? threadMoving;
  Animation<double>? threadRight;
  double threadPos = 0;
  // Pencil Level
  Animation<double>? leadMoving;
  Animation<double>? leadUp;
  // Hammer Level
  Animation<double>? hammerMoving;
  Animation<double>? hammerDown;
  Animation<double>? nailDown;
  double hammerPos = 0;
  late AnimationController nailMove;
  // Timer Level
  static const maxSeconds = 1000;
  double seconds = maxSeconds / 10;
  // cookie levels
  final GlobalKey<SplittingWidgetState> splittingKey =
      GlobalKey<SplittingWidgetState>();
  Animation<double>? scissorsMoving1;
  Animation<double>? scissorsDown;
  Animation<double>? scissorsMoving2;
  Animation<double>? scissorsRight;
  bool shouldCut = false;
  List<double> whereCut = [0, 0];
  // check or fail
  final GlobalKey<CheckFailState> checkFailKey = GlobalKey<CheckFailState>();

  @override
  void initState() {
    super.initState();
    slow = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    slow.addListener(() {
      setState(() {});
    });
    medium = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    medium.addListener(() {
      setState(() {});
    });
    clicked = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    clicked.addListener(() {
      if (currentPage == 6) {
        if ((hammerDown!.value >= (deviceHeight(context) / 2.975)) && isGood) {
          nailMove.forward();
        }
      }
      if (currentPage == 3 && shouldCut && clicked.isCompleted) {
        splittingKey.currentState!.split(whereCut);
      }
      if (currentPage == 4 && shouldCut && clicked.isCompleted) {
        splittingKey.currentState!.split(whereCut);
      }
      if (clicked.isCompleted) {
        checkFailKey.currentState!.animate(isGood);
      }

      setState(() {});
    });
    nailMove = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    nailMove.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pizzaMoving = Tween<double>(
      begin: -deviceWidth(context) / 5,
      end: deviceWidth(context) / 2,
    ).animate(
      CurvedAnimation(
        parent: slow,
        curve: Curves.linear,
      ),
    );
    pizzaUp = Tween<double>(
      begin: deviceHeight(context) / 2.75,
      end: deviceHeight(context) / 20,
    ).animate(
      CurvedAnimation(
        parent: clicked,
        curve: Curves.linear,
      ),
    );

    threadMoving = Tween<double>(
      begin: deviceHeight(context) / 10,
      end: deviceHeight(context) / 2.25,
    ).animate(
      CurvedAnimation(
        parent: slow,
        curve: Curves.linear,
      ),
    );
    threadRight = Tween<double>(
      begin: deviceWidth(context) / 15,
      end: deviceWidth(context) / 1.75,
    ).animate(
      CurvedAnimation(
        parent: clicked,
        curve: Curves.linear,
      ),
    );

    leadMoving = Tween<double>(
      begin: deviceWidth(context) / 7,
      end: deviceWidth(context) * 6 / 7,
    ).animate(
      CurvedAnimation(
        parent: slow,
        curve: Curves.linear,
      ),
    );
    leadUp = Tween<double>(
      begin: deviceHeight(context) / 2,
      end: deviceHeight(context) / 4.5,
    ).animate(
      CurvedAnimation(
        parent: clicked,
        curve: Curves.linear,
      ),
    );

    hammerMoving = Tween<double>(
      begin: deviceWidth(context) / 30,
      end: deviceWidth(context) / 2,
    ).animate(
      CurvedAnimation(
        parent: medium,
        curve: Curves.linear,
      ),
    );
    hammerDown = Tween<double>(
      begin: deviceHeight(context) / 20,
      end: deviceHeight(context) / 2.45,
    ).animate(
      CurvedAnimation(
        parent: clicked,
        curve: Curves.linear,
      ),
    );
    nailDown = Tween<double>(
      begin: deviceHeight(context) / 2.08,
      end: deviceHeight(context) / 1.8,
    ).animate(
      CurvedAnimation(
        parent: nailMove,
        curve: Curves.linear,
      ),
    );

    scissorsMoving1 = Tween<double>(
      begin: deviceWidth(context) / 20,
      end: deviceWidth(context) / 1.5,
    ).animate(
      CurvedAnimation(
        parent: slow,
        curve: Curves.linear,
      ),
    );
    scissorsDown = Tween<double>(
      begin: deviceHeight(context) / 10,
      end: deviceHeight(context) / 1.5,
    ).animate(
      CurvedAnimation(
        parent: clicked,
        curve: Curves.linear,
      ),
    );

    scissorsMoving2 = Tween<double>(
      begin: deviceHeight(context) / 10,
      end: deviceHeight(context) / 1.85,
    ).animate(
      CurvedAnimation(
        parent: medium,
        curve: Curves.linear,
      ),
    );
    scissorsRight = Tween<double>(
      begin: deviceWidth(context) / 100,
      end: deviceWidth(context) / 1.05,
    ).animate(
      CurvedAnimation(
        parent: clicked,
        curve: Curves.linear,
      ),
    );

    slowFunc();
  }

  @override
  void dispose() {
    timer?.cancel();
    slow.dispose();
    medium.dispose();
    clicked.dispose();
    nailMove.dispose();
    super.dispose();
  }

  // BACK ARROW LOGIC
  void backArrow() {
    if (currentPage == 0) {
      backSection(5, context);
    } else {
      showHome = true;
      currentPage--;
      setState(() {});
    }
  }

  // FRONT ARROW LOGIC
  void frontArrow() {
    if (currentPage == 0) {
      slow.reset();
      clicked.reset();
      checkFailKey.currentState!.reset();
      fwrd = true;
      clkd = false;
      isGood = false;
      slowFunc();
    } else if (currentPage == 1) {
      slow.reset();
      clicked.reset();
      checkFailKey.currentState!.reset();
      fwrd = true;
      clkd = false;
      isGood = false;
      slowFunc();
    } else if (currentPage == 2) {
      slow.reset();
      clicked.reset();
      checkFailKey.currentState!.reset();
      fwrd = true;
      clkd = false;
      isGood = false;
      slowFunc();
    } else if (currentPage == 3) {
      slow.reset();
      clicked.reset();
      checkFailKey.currentState!.reset();
      fwrd = true;
      adjustPage = 1;
      clkd = false;
      isGood = false;
      fastFunc();
    } else if (currentPage == 4) {
      medium.reset();
      clicked.reset();
      checkFailKey.currentState!.reset();
      fwrd = true;
      clkd = false;
      isGood = false;
      timerFunc();
    } else if (currentPage == 5) {
      clkd = false;
      isGood = false;
      checkFailKey.currentState!.reset();
      fastFunc();
    } else if (currentPage == 6) {
      nextSection(6, context);
    }
    currentPage++;
    showHome = false;
    setState(() {});
  }

  // Slow Func
  void slowFunc() {
    slow.forward();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (fwrd) {
        slow.reverse();
      } else {
        slow.forward();
      }
      fwrd = !fwrd;
      setState(() {});
    });
  }

  // Medium Func
  void fastFunc() {
    medium.forward();
    timer = Timer.periodic(const Duration(milliseconds: 750), (_) {
      if (fwrd) {
        medium.reverse();
      } else {
        medium.forward();
      }
      fwrd = !fwrd;
      setState(() {});
    });
  }

  // PIZZA PIZZA
  GestureDetector fillPizza() {
    return GestureDetector(
      onTapDown: (_) {
        if (!clkd) {
          timer?.cancel();
          slow.stop();
          if ((pizzaMoving!.value > deviceWidth(context) / 6.4) &&
              (pizzaMoving!.value < deviceWidth(context) / 5.65)) {
            isGood = true;
          }
          clkd = true;
          clicked.forward();
          setState(() {});
        }
      },
      child: Center(
        child: Container(
          width: deviceWidth(context),
          height: deviceHeight(context) / 1.35,
          color: AppColors.backgroundColor.withOpacity(0),
          child: Stack(
            children: [
              Positioned(
                left: deviceWidth(context) / 6,
                top: deviceHeight(context) / 20,
                child: SizedBox(
                  width: deviceWidth(context) / 1.5,
                  child: Image.asset('lib/assets/images/section6/pizza.png',
                      fit: BoxFit.contain),
                ),
              ),
              Positioned(
                left: isGood
                    ? deviceWidth(context) / 6
                    : pizzaMoving?.value ?? -deviceWidth(context) / 5,
                top: pizzaUp?.value ?? deviceHeight(context) / 2.75,
                child: SizedBox(
                  width: deviceWidth(context) / 1.5,
                  child: Image.asset(
                      'lib/assets/images/section6/pizzaSlice.png',
                      fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // THREAD IT
  GestureDetector threader() {
    return GestureDetector(
      onTapDown: (_) {
        if (!clkd) {
          slow.stop();
          timer?.cancel();
          if ((threadMoving!.value > deviceHeight(context) / 6.05) &&
              (threadMoving!.value < deviceHeight(context) / 4.95)) {
            if (threadMoving!.value < deviceHeight(context) / 5.8) {
              threadPos = deviceHeight(context) / 5.8;
            } else if (threadMoving!.value > deviceHeight(context) / 5.1) {
              threadPos = deviceHeight(context) / 5.1;
            } else {
              threadPos = threadMoving!.value;
            }
            isGood = true;
            setState(() {});
          }
          clkd = true;
          setState(() {});
          clicked.forward();
        }
      },
      child: Center(
        child: Container(
          width: deviceWidth(context),
          height: deviceHeight(context) / 1.35,
          color: AppColors.backgroundColor.withOpacity(0),
          child: Stack(
            children: [
              Positioned(
                left: deviceWidth(context) / 1.75,
                top: deviceHeight(context) / 6,
                child: SizedBox(
                  height: deviceHeight(context) / 4,
                  child: Image.asset('lib/assets/images/section6/needle.png',
                      fit: BoxFit.contain),
                ),
              ),
              Positioned(
                top: isGood
                    ? threadPos
                    : threadMoving?.value ?? deviceHeight(context) / 10,
                left: threadRight?.value ?? deviceWidth(context) / 15,
                child: SizedBox(
                  width: deviceWidth(context) / 2.5,
                  child: Image.asset('lib/assets/images/section6/thread.png',
                      fit: BoxFit.contain),
                ),
              ),
              // needle part
              Positioned(
                left: deviceWidth(context) / 1.225,
                top: deviceHeight(context) / 5.45,
                child: Container(
                  width: deviceWidth(context) / 37,
                  height: deviceHeight(context) / 30,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(2),
                    ),
                    gradient: LinearGradient(colors: [
                      AppColors.middleGrey,
                      AppColors.lightGrey,
                      Color.fromARGB(255, 238, 238, 238)
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // LEAD IT
  GestureDetector leader() {
    return GestureDetector(
      onTapDown: (_) {
        if (!clkd) {
          timer?.cancel();
          slow.stop();
          if ((leadMoving!.value > deviceWidth(context) / 2.05) &&
              (leadMoving!.value < deviceWidth(context) / 1.95)) {
            isGood = true;
          }
          clkd = true;
          clicked.forward();
          setState(() {});
        }
      },
      child: Center(
        child: Container(
          width: deviceWidth(context),
          height: deviceHeight(context) / 1.35,
          color: AppColors.backgroundColor.withOpacity(0),
          child: Stack(
            children: [
              Positioned(
                top: leadUp?.value ?? deviceHeight(context) / 2,
                left: isGood
                    ? deviceWidth(context) / 1.995
                    : leadMoving?.value ?? deviceWidth(context) / 7,
                child: Container(
                  width: deviceWidth(context) / 135,
                  height: deviceHeight(context) / 6,
                  color: AppColors.darkGrey,
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: deviceHeight(context) / 3,
                  width: deviceWidth(context),
                  child: Image.asset(
                    'lib/assets/images/section6/pencil.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // HALF COOKIE
  GestureDetector cookieCut() {
    return GestureDetector(
      onTapDown: (_) {
        // width / 2.8 (middle)
        // left bound / 7.2
        // right bound / 1.79
        if (!clkd && currentPage == 3) {
          // vertical cut
          timer?.cancel();
          slow.stop();
          if ((scissorsMoving1!.value > deviceWidth(context) / 7.2) &&
              (scissorsMoving1!.value < deviceWidth(context) / 1.79)) {
            shouldCut = true;
            if ((scissorsMoving1!.value > deviceWidth(context) / 2.9) &&
                (scissorsMoving1!.value < deviceWidth(context) / 2.7)) {
              isGood = true;
              whereCut[0] = .5;
            } else {
              whereCut[0] =
                  (scissorsMoving1!.value - (deviceWidth(context) / 7.2)) /
                      (deviceWidth(context) / 2.25);
            }
          }
          clkd = true;
          clicked.forward();
          setState(() {});
        } else if (!clkd && currentPage == 4) {
          // deviceHeight(context) / 4 + deviceWidth(context) / 6.5 (middle)
          // up bound deviceHeight(context) / 4.5
          // deviceHeight(context) / 4 + deviceWidth(context) / 2.75
          timer?.cancel();
          medium.stop();
          if ((scissorsMoving2!.value > deviceHeight(context) / 4.5) &&
              (scissorsMoving2!.value <
                  (deviceHeight(context) / 4 + deviceWidth(context) / 2.75))) {
            shouldCut = true;
            if ((scissorsMoving2!.value >
                    (deviceHeight(context) / 4 + deviceWidth(context) / 7)) &&
                (scissorsMoving2!.value <
                    (deviceHeight(context) / 4 + deviceWidth(context) / 6))) {
              isGood = true;
              whereCut[1] = .5;
            } else {
              whereCut[1] =
                  (scissorsMoving2!.value - (deviceHeight(context) / 4.5)) /
                      (deviceWidth(context) / 2.25);
            }
          }
          clkd = true;
          clicked.forward();
          setState(() {});
        }
      },
      child: Center(
        child: Container(
          width: deviceWidth(context),
          height: deviceHeight(context) / 1.35,
          color: AppColors.backgroundColor.withOpacity(0),
          child: Stack(
            children: [
              Positioned(
                left: currentPage == 3
                    ? deviceWidth(context) / 3.6
                    : deviceWidth(context) / 1.9,
                top: currentPage == 3
                    ? deviceHeight(context) / 2.25
                    : deviceHeight(context) / 4,
                child: SplittingWidget(
                  key: splittingKey,
                  child: Container(
                    color: AppColors.backgroundColor,
                    width: deviceWidth(context) / 2.25,
                    height: deviceWidth(context) / 2.25,
                    child: Image.asset('lib/assets/images/section6/cookie.png',
                        fit: BoxFit.contain),
                  ),
                  onSplitCompleted: () {
                    print('done');
                  },
                ),
              ),
              Positioned(
                left: currentPage == 3
                    ? scissorsMoving1?.value ?? deviceWidth(context) / 20
                    : deviceWidth(context) / 3.5,
                top: currentPage == 3
                    ? deviceHeight(context) / 4
                    : scissorsMoving2?.value ?? deviceHeight(context) / 10,
                child: Transform.rotate(
                  angle: currentPage == 3 ? -pi / 2 : -pi,
                  child: SizedBox(
                    height: deviceWidth(context) / 7,
                    width: deviceWidth(context) / 3.5,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth(context) / 100),
                          child: Container(
                            width: deviceWidth(context) / 30,
                            height: deviceWidth(context) / 75,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth(context) / 100),
                          child: Container(
                            width: deviceWidth(context) / 30,
                            height: deviceWidth(context) / 75,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth(context) / 100),
                          child: Container(
                            width: deviceWidth(context) / 30,
                            height: deviceWidth(context) / 75,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth(context) / 100),
                          child: Container(
                            width: deviceWidth(context) / 30,
                            height: deviceWidth(context) / 75,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth(context) / 100),
                          child: Container(
                            width: deviceWidth(context) / 30,
                            height: deviceWidth(context) / 75,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: currentPage == 3
                    ? isGood
                        ? deviceWidth(context) / 2.8
                        : scissorsMoving1?.value ?? deviceWidth(context) / 20
                    : scissorsRight?.value ?? deviceWidth(context) / 100,
                top: currentPage == 3
                    ? scissorsDown?.value ?? deviceHeight(context) / 10
                    : isGood
                        ? deviceHeight(context) / 4 + deviceWidth(context) / 6.5
                        : scissorsMoving2?.value ?? deviceHeight(context) / 10,
                child: Transform.rotate(
                  angle: currentPage == 3 ? -pi / 2 : -pi,
                  child: SizedBox(
                    width: deviceWidth(context) / 3.5,
                    height: deviceWidth(context) / 7,
                    child: Image.asset(
                      'lib/assets/images/section6/scissor.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // STOP TIMER
  Center timerGuy() {
    return Center(
      child: Container(
        width: deviceWidth(context),
        height: deviceHeight(context) / 1.35,
        color: AppColors.backgroundColor.withOpacity(0),
        child: Stack(
          children: [
            Positioned(
              left: deviceWidth(context) / 3,
              top: deviceHeight(context) / 8,
              child: Container(
                width: deviceWidth(context) / 3,
                height: deviceHeight(context) / 8,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.darkGrey, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: Center(
                  child: appText('$seconds', const Color(0xFF30A431),
                      deviceWidth(context) / 15, FontWeight.w500),
                ),
              ),
            ),
            Positioned(
              left: deviceWidth(context) / 3,
              top: deviceHeight(context) / 2.75,
              child: GestureDetector(
                onTap: () {
                  if (!clkd) {
                    timer?.cancel();
                    clkd = true;
                  }
                },
                child: gameButton(
                  context,
                  Colors.black,
                  const Color.fromARGB(255, 155, 135, 55),
                  const Color(0xffF9D342),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void timerFunc() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        if (seconds > 0) {
          seconds = ((seconds * 10) - 1) / 10;
        } else {
          timer?.cancel();
        }
      });
    });
  }

  // HAMMER IT
  GestureDetector hammerIt() {
    return GestureDetector(
      onTapDown: (_) {
        if (!clkd) {
          medium.stop();
          timer?.cancel();
          if ((hammerMoving!.value > deviceWidth(context) / 8.5) &&
              (hammerMoving!.value < deviceWidth(context) / 4.5)) {
            if (hammerMoving!.value < deviceWidth(context) / 8) {
              hammerPos = deviceWidth(context) / 8;
            } else if (hammerMoving!.value > deviceWidth(context) / 4.75) {
              hammerPos = deviceWidth(context) / 4.75;
            } else {
              hammerPos = hammerMoving!.value;
            }
            isGood = true;
            setState(() {});
          }
          clkd = true;
          setState(() {});
          clicked.forward();
        }
      },
      child: Center(
        child: Container(
          width: deviceWidth(context),
          height: deviceHeight(context) / 1.35,
          color: AppColors.backgroundColor.withOpacity(0),
          child: Stack(
            children: [
              Positioned(
                top: hammerDown?.value ?? deviceHeight(context) / 20,
                left: isGood
                    ? hammerPos
                    : hammerMoving?.value ?? deviceWidth(context) / 30,
                child: SizedBox(
                  width: deviceWidth(context) / 2.25,
                  child: Image.asset(
                    'lib/assets/images/section6/hammer.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                left: deviceWidth(context) / 5,
                top: nailDown?.value ?? deviceHeight(context) / 2.08,
                child: SizedBox(
                  width: deviceWidth(context) / 18,
                  height: deviceHeight(context) / 11,
                  child: CustomPaint(
                    painter: Nail(),
                  ),
                ),
              ),
              Positioned(
                top: deviceHeight(context) / 1.75,
                left: deviceWidth(context) / 22.22,
                child: Container(
                  width: deviceWidth(context) / 1.1,
                  height: deviceHeight(context) / 50,
                  color: const Color.fromARGB(255, 100, 77, 69),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // TOP BAR && ARROWS
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(
                home: showHome,
                banner1: const Color(0xffF9D342),
                banner2: Colors.black,
                banner3: Colors.black,
                title: titles[currentPage],
                opacity: 1,
                numbers: allNumbers[currentPage + 33],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '0',
                totalAdCount: '5',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xffF9D342),
                arrow2: Colors.black,
                arrow3: Colors.black,
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // levels
          IndexedStack(
            index: currentPage - adjustPage,
            children: <Widget>[
              fillPizza(),
              threader(),
              leader(),
              cookieCut(),
              timerGuy(),
              hammerIt(),
            ],
          ),
          CheckFail(
            key: checkFailKey,
          )
        ],
      ),
    );
  }
}

class Nail extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = AppColors.lightGrey
      ..style = PaintingStyle.fill;

    final path = Path();
    final path2 = Path();
    path.moveTo(size.width * .05, size.height * .1);
    path.arcToPoint(
      Offset(size.width * .95, size.height * .1),
      radius: Radius.circular(size.width * .8),
    );
    path.arcToPoint(
      Offset(size.width * .05, size.height * .1),
      radius: Radius.circular(size.width),
    );
    path2.moveTo(size.width / 2.45, size.height * .1);
    path2.lineTo(size.width / 2.45, size.height * .9);
    path2.lineTo(size.width / 2, size.height);
    path2.lineTo(size.width / 1.67, size.height * .9);
    path2.lineTo(size.width / 1.67, size.height * .1);
    path.close();
    path2.close();
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path2, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
