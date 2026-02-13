import 'dart:async';
import 'dart:math';
//import 'package:flutter/services.dart';
import 'package:levels222_0/models/keyboard.dart';
import 'package:levels222_0/models/number_board.dart';
import 'package:levels222_0/pages/home.dart';

class Section12 extends StatefulWidget {
  const Section12({super.key});

  @override
  State<Section12> createState() => _Section12State();
}

class _Section12State extends State<Section12> {
  // universal logic
  bool showHome = true;
  int currentPage = 0;
  int currentAdNum = 0;
  int adCap = 8;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;
  static const maxSeconds = 150;
  double seconds = maxSeconds / 10;
  bool hasGuessed = false;
  // quick maths
  double opacitys = .2;
  List<String> numbers = [];
  Timer? _timer;
  // quick text
  List<String> textGuess = [];
  List<String> names = ["Zaza", "Zeze", "Zizi", "Zozo", "????"];

  @override
  void initState() {
    super.initState();
    loadAd();
    currentAdNum = box.get('currentAd');
    timerFunc();
  }

  @override
  void dispose() {
    _timer?.cancel();
    videoAd?.dispose();
    super.dispose();
  }

  // Shows Ad and Updates Counter
  void showAd() {
    videoAd!.show();
    videoAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
      updateAd(12, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(12, currentAdNum, adCap, showAd, context);
  }

  // Back arrow logic
  void backArrow() {
    if (currentPage == 0) {
      backSection(11, context);
    } else {
      showHome = true;
      currentPage--;
      setState(() {});
    }
  }

  // Front arrow logic
  void frontArrow() {
    currentPage++;
    showHome = false;
    // seconds = maxSeconds / 10;
    hasGuessed = false;
    textGuess = [];
    numbers = [];
    opacitys = .25;
    // timerFunc();
    if (currentPage > 7) {
      nextSection(12, context);
    }
    setState(() {});
  }

  // Quick Maths - 1, 2, 3, 8
  Column quickMaths() {
    return Column(
      children: [
        // timer
        Padding(
          padding: EdgeInsets.only(
              top: deviceHeight(context) / 7,
              bottom: deviceHeight(context) / 25),
          child: appText('$seconds', const Color(0xffc7395f),
              deviceWidth(context) / 16, FontWeight.w400),
        ),
        // meat
        SizedBox(
          height: deviceWidth(context) * (8 / 15),
          width: deviceWidth(context),
          child: currentPage == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //bannanas
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: deviceWidth(context) / 6,
                              height: deviceWidth(context) * (2 / 15),
                              child: CustomPaint(
                                painter: Bannana(),
                              ),
                            ),
                            Transform.rotate(
                              alignment: const Alignment(.7, -.7),
                              angle: pi / 6,
                              child: SizedBox(
                                width: deviceWidth(context) / 6,
                                height: deviceWidth(context) * (2 / 15),
                                child: CustomPaint(
                                  painter: Bannana(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // + sign
                        SizedBox(
                          width: deviceWidth(context) / 10,
                          child: appText2("+", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                        // bannanas
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: deviceWidth(context) / 6,
                              height: deviceWidth(context) * (2 / 15),
                              child: CustomPaint(
                                painter: Bannana(),
                              ),
                            ),
                            Transform.rotate(
                              alignment: const Alignment(.7, -.7),
                              angle: pi / 6,
                              child: SizedBox(
                                width: deviceWidth(context) / 6,
                                height: deviceWidth(context) * (2 / 15),
                                child: CustomPaint(
                                  painter: Bannana(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // = sign
                        SizedBox(
                          width: deviceWidth(context) / 8,
                          child: appText("=", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                        // answer CHANGE THIS SO IT VARRIES
                        appText2("16", const Color(0xffe8ba40),
                            deviceWidth(context) / 15, FontWeight.w700),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // grapes
                        SizedBox(
                          width: deviceWidth(context) / 6,
                          height: deviceWidth(context) * (2 / 15),
                          child: CustomPaint(
                            painter: Grapes(),
                          ),
                        ),
                        // + sign
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: deviceWidth(context) / 8,
                          child: appText("+", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                        // bannanas
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: deviceWidth(context) / 6,
                              height: deviceWidth(context) * (2 / 15),
                              child: CustomPaint(
                                painter: Bannana(),
                              ),
                            ),
                            Transform.rotate(
                              alignment: const Alignment(.7, -.7),
                              angle: pi / 6,
                              child: SizedBox(
                                width: deviceWidth(context) / 6,
                                height: deviceWidth(context) * (2 / 15),
                                child: CustomPaint(
                                  painter: Bannana(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // = sign
                        SizedBox(
                          width: deviceWidth(context) / 8,
                          child: appText("=", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                        // answer CHANGE THIS SO IT VARRIES
                        appText2("10", const Color(0xffe8ba40),
                            deviceWidth(context) / 15, FontWeight.w700),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // orange
                        SizedBox(
                          width: deviceWidth(context) / 6,
                          height: deviceWidth(context) * (2 / 15),
                          child: CustomPaint(
                            painter: Orange(),
                          ),
                        ),
                        // + sign
                        SizedBox(
                          width: deviceWidth(context) / 16,
                          child: appText("+", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                        // orange
                        SizedBox(
                          width: deviceWidth(context) / 6,
                          height: deviceWidth(context) * (2 / 15),
                          child: CustomPaint(
                            painter: Orange(),
                          ),
                        ),
                        // + sign
                        SizedBox(
                          width: deviceWidth(context) / 16,
                          child: appText("+", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                        // orange
                        SizedBox(
                          width: deviceWidth(context) / 6,
                          height: deviceWidth(context) * (2 / 15),
                          child: CustomPaint(
                            painter: Orange(),
                          ),
                        ),
                        // = sign
                        SizedBox(
                          width: deviceWidth(context) / 11,
                          child: appText("=", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                        // answer CHANGE THIS SO IT VARRIES
                        SizedBox(
                          width: deviceWidth(context) / 12,
                          child: appText("9", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                      ],
                    ),
                    // final one
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: deviceWidth(context) / 6,
                          height: deviceWidth(context) * (2 / 15),
                          child: CustomPaint(
                            painter: Bannana(),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth(context) / 10,
                          child: appText("×", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                        Container(
                          width: deviceWidth(context) / 20,
                          height: deviceWidth(context) / 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 121, 24, 95),
                            border: Border.all(
                              color: const Color.fromARGB(255, 48, 14, 58),
                              width: 1,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth(context) / 10,
                          child: appText("+", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                        // orange
                        SizedBox(
                          width: deviceWidth(context) / 6,
                          height: deviceWidth(context) * (2 / 15),
                          child: CustomPaint(
                            painter: Orange(),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth(context) / 10,
                          child: appText("=", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                        // answer CHANGE THIS SO IT VARRIES
                        SizedBox(
                          width: deviceWidth(context) / 12,
                          child: appText("??", const Color(0xffe8ba40),
                              deviceWidth(context) / 15, FontWeight.w700),
                        ),
                      ],
                    )
                  ],
                )
              : currentPage == 1
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        appText(
                            "Which number is missing?",
                            const Color(0xffe8ba40),
                            deviceWidth(context) / 18,
                            FontWeight.w400),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            appText("16  06  68  88  ", const Color(0xffe8ba40),
                                deviceWidth(context) / 12, FontWeight.w600),
                            Container(
                              width: deviceWidth(context) / 8,
                              height: deviceWidth(context) / 8,
                              decoration: const BoxDecoration(
                                  color: Color(0xffc7395f),
                                  shape: BoxShape.circle),
                            ),
                            appText(" 98", const Color(0xffe8ba40),
                                deviceWidth(context) / 12, FontWeight.w600),
                          ],
                        )
                      ],
                    )
                  : currentPage == 2
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            appText(
                                "A bat costs \$100 more than a baseball.\n...if",
                                const Color(0xffe8ba40),
                                deviceWidth(context) / 22,
                                FontWeight.w400),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: deviceWidth(context) / 6,
                                  height: deviceWidth(context) * (2 / 15),
                                  child: CustomPaint(
                                    painter: Bat(),
                                  ),
                                ),
                                SizedBox(
                                  width: deviceWidth(context) / 10,
                                  child: appText(
                                      "+",
                                      const Color(0xffe8ba40),
                                      deviceWidth(context) / 15,
                                      FontWeight.w700),
                                ),
                                SizedBox(
                                  width: deviceWidth(context) / 6,
                                  height: deviceWidth(context) * (2 / 15),
                                  child: CustomPaint(
                                    painter: Baseball(),
                                  ),
                                ),
                                SizedBox(
                                  width: deviceWidth(context) / 3.75,
                                  child: appText(
                                      "=  \$110",
                                      const Color(0xffe8ba40),
                                      deviceWidth(context) / 15,
                                      FontWeight.w700),
                                ),
                              ],
                            ),
                            appText(
                                "How much does the baseball cost?",
                                const Color(0xffe8ba40),
                                deviceWidth(context) / 22,
                                FontWeight.w400),
                          ],
                        )
                      : Column(
                          children: [],
                        ),
        ),
        // input
        Padding(
          padding: EdgeInsets.only(
              top: deviceHeight(context) / 25,
              bottom: deviceHeight(context) / 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: deviceHeight(context) / 14,
                width: deviceWidth(context) / 2.5,
                decoration: const BoxDecoration(
                  color: AppColors.darkerGrey,
                  border: Border(
                    bottom: BorderSide(color: Color(0xffe8ba40), width: 2),
                  ),
                ),
                child: Center(
                  child: appText(numbers.join(), const Color(0xffc7395f),
                      deviceWidth(context) / 12, FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        // board
        NumberBoard(
          onKeyTapped: onKeyTappedNumber,
          onDeleteTapped: onDeleteTappedNumber,
          onEnterTapped: onEnterTappedNumber,
          textColor: const Color(0xffc7395f),
          backgroundColor: const Color(0xffe8ba40),
          opacitys: opacitys,
        ),
      ],
    );
  }

  void onKeyTappedNumber(input) {
    if (numbers.length < 6 && !hasGuessed) {
      numbers.add(input);
      if (opacitys != 1.0) {
        opacitys = 1.0;
      }
      //  HapticFeedback.selectionClick(); // maybe put these in the keyboard class
      setState(() {});
    } else {
      //   HapticFeedback.lightImpact();
    }
  }

  void onDeleteTappedNumber() {
    if (numbers.isNotEmpty && !hasGuessed) {
      numbers.removeLast();
      if (numbers.isEmpty) {
        opacitys = .25;
      }
      //   HapticFeedback.selectionClick();
      setState(() {});
    } else {
      //   HapticFeedback.lightImpact();
    }
  }

  void onEnterTappedNumber() {
    if (numbers.isNotEmpty && !hasGuessed) {
      _timer?.cancel();
      //    HapticFeedback.lightImpact();
    } else {
      //   HapticFeedback.lightImpact();
    }
  }

// Quick Type - 4, 5
  Column quickType() {
    return Column(
      children: [
        // timer
        Padding(
          padding: EdgeInsets.only(
              top: deviceHeight(context) / 7,
              bottom: deviceHeight(context) / 50),
          child: appText('$seconds', const Color(0xffc7395f),
              deviceWidth(context) / 16, FontWeight.w400),
        ),
        // meat
        SizedBox(
          width: deviceWidth(context) / 1.05,
          height: deviceHeight(context) / 4,
          child: currentPage == 3
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    appText(
                        "A cowboy rode into town on Friday. He stayed in town for three days and rode out on Friday. How was that possible?",
                        const Color(0xffe8ba40),
                        deviceWidth(context) / 22,
                        FontWeight.w400),
                    SizedBox(
                      width: deviceWidth(context) / 4,
                      child: Image.asset(
                          'lib/assets/images/section12/horse.png',
                          fit: BoxFit.contain),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    appText("LeBron's Mom had 5 sons", const Color(0xffe8ba40),
                        deviceWidth(context) / 22, FontWeight.w400),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0; i < 5; i++) ...<SizedBox>{
                              SizedBox(
                                width: deviceWidth(context) / 6,
                                child: appText(
                                    names[i],
                                    const Color(0xffe8ba40),
                                    deviceWidth(context) / 25,
                                    FontWeight.w600),
                              )
                            }
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0; i < 5; i++) ...<SizedBox>{
                              SizedBox(
                                width: deviceWidth(context) / 6,
                                height: deviceHeight(context) / 8,
                                child: Image.asset(
                                    'lib/assets/images/section12/character.png',
                                    fit: BoxFit.contain),
                              )
                            }
                          ],
                        ),
                      ],
                    ),
                    appText(
                        "What is the name of the 5th son?",
                        const Color(0xffe8ba40),
                        deviceWidth(context) / 22,
                        FontWeight.w400),
                  ],
                ),
        ),
        // input
        Padding(
          padding: EdgeInsets.only(
              top: deviceHeight(context) / 35,
              bottom: deviceHeight(context) / 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: deviceHeight(context) / 12,
                width: deviceWidth(context) / 1.05,
                decoration: const BoxDecoration(
                  color: AppColors.darkerGrey,
                  border: Border(
                    bottom: BorderSide(color: Color(0xffe8ba40), width: 2),
                  ),
                ),
                child: Center(
                  child: appText(textGuess.join(), const Color(0xffc7395f),
                      deviceWidth(context) / 18, FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        // key board
        Keyboard(
          onKeyTapped: onKeyTappedText,
          onDeleteTapped: onDeleteTappedText,
          onEnterTapped: onEnterTappedText,
          onSpaceTapped: onSpaceTappedText,
          isWordle: false,
          textColor: const Color(0xffc7395f),
          backgroundColor: const Color(0xffe8ba40),
          opacity: opacitys,
        )
      ],
    );
  }

  void onKeyTappedText(letter) {
    if (textGuess.length < 45 && !hasGuessed) {
      textGuess.add(letter);
      if (opacitys != 1.0) {
        opacitys = 1.0;
      }
      //    HapticFeedback.selectionClick();
      setState(() {});
    } else {
      //    HapticFeedback.lightImpact();
    }
  }

  void onDeleteTappedText() {
    if (textGuess.isNotEmpty && !hasGuessed) {
      textGuess.removeLast();
      if (textGuess.isEmpty) {
        opacitys = .25;
      }
      //     HapticFeedback.selectionClick();
      setState(() {});
    } else {
      //    HapticFeedback.lightImpact();
    }
  }

  void onEnterTappedText() {
    if (textGuess.isNotEmpty && !hasGuessed) {
      _timer?.cancel();
    } else {
      //     HapticFeedback.lightImpact();
    }
  }

  void onSpaceTappedText() {
    if (textGuess.isNotEmpty && !hasGuessed) {
      textGuess.add(" ");
      //     HapticFeedback.selectionClick();
      setState(() {});
    } else {
      //     HapticFeedback.lightImpact();
    }
  }

// Quick Think - 6, 7
  Column quickThink() {
    return Column(
      children: [],
    );
  }

  void timerFunc() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        if (seconds > 0) {
          seconds = ((seconds * 10) - 1) / 10;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Top bar and arrows
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(
                home: showHome,
                banner1: const Color(0xffc7395f),
                banner2: const Color(0xffded4e8),
                banner3: const Color(0xffe8ba40),
                title: "IQ Test",
                opacity: 1,
                numbers: allNumbers[currentPage + 75],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xffc7395f),
                arrow2: const Color(0xffded4e8),
                arrow3: const Color(0xffe8ba40),
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // levels
          IndexedStack(
            index: currentPage,
            children: <Widget>[
              quickMaths(),
              quickMaths(),
              quickMaths(),
              quickType(),
              quickType(),
              quickThink(),
              quickThink(),
              quickMaths(),
            ],
          )
        ],
      ),
    );
  }
}

class Bannana extends CustomPainter {
  Bannana({
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = const Color.fromARGB(255, 69, 68, 29)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 250, 239, 24)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color.fromARGB(255, 187, 187, 37)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.arcToPoint(
      Offset(size.width * .9, size.height * .2),
      radius: Radius.circular(size.width * 4),
    );
    path.lineTo(size.width * .85, size.height * .075);
    path.arcToPoint(
      Offset(0, size.height),
      radius: Radius.circular(size.width),
    );
    path.close();
    final path2 = Path();
    path2.moveTo(0, size.height);
    path2.arcToPoint(Offset(size.width * .8, size.height * .25),
        radius: Radius.circular(size.width * .75), clockwise: false);
    path2.arcToPoint(
      Offset(0, size.height),
      radius: Radius.circular(size.width),
    );
    path2.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path, fillStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Grapes extends CustomPainter {
  Grapes({
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = const Color.fromARGB(255, 48, 14, 58)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 121, 24, 95)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color.fromARGB(255, 75, 216, 32)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * .9);
    path.arcToPoint(
      Offset(size.width * .175, size.height * .7),
      radius: Radius.circular(size.width * .1),
    );
    path.arcToPoint(
      Offset(0, size.height * .9),
      radius: Radius.circular(size.width * .1),
    );
    path.moveTo(size.width * .175, size.height * .7);
    path.arcToPoint(
      Offset(size.width * .35, size.height * .5),
      radius: Radius.circular(size.width * .1),
    );
    path.arcToPoint(
      Offset(size.width * .175, size.height * .7),
      radius: Radius.circular(size.width * .1),
    );
    path.moveTo(size.width * .235, size.height * .775);
    path.arcToPoint(
      Offset(size.width * .41, size.height * .975),
      radius: Radius.circular(size.width * .1),
    );
    path.arcToPoint(
      Offset(size.width * .235, size.height * .775),
      radius: Radius.circular(size.width * .1),
    );
    path.moveTo(size.width * .465, size.height * .8);
    path.arcToPoint(
      Offset(size.width * .635, size.height),
      radius: Radius.circular(size.width * .1),
    );
    path.arcToPoint(
      Offset(size.width * .465, size.height * .8),
      radius: Radius.circular(size.width * .1),
    );
    path.moveTo(size.width * .41, size.height * .715);
    path.arcToPoint(
      Offset(size.width * .58, size.height * .515),
      radius: Radius.circular(size.width * .1),
    );
    path.arcToPoint(
      Offset(size.width * .41, size.height * .715),
      radius: Radius.circular(size.width * .1),
    );
    path.moveTo(size.width * .325, size.height * .45);
    path.arcToPoint(
      Offset(size.width * .5, size.height * .25),
      radius: Radius.circular(size.width * .1),
    );
    path.arcToPoint(
      Offset(size.width * .325, size.height * .45),
      radius: Radius.circular(size.width * .1),
    );
    final path2 = Path();
    path2.moveTo(size.width * .6, size.height * .6);
    path2.arcToPoint(Offset(size.width, size.width * .1),
        radius: Radius.circular(size.width));
    path2.arcToPoint(
      Offset(size.width * .6, size.height * .6),
      radius: Radius.circular(size.width * .5),
    );
    path2.close();
    path2.moveTo(size.width * .6, size.height * .6);
    path2.lineTo(size.width, size.height * .6);
    path2.lineTo(size.width, size.height * .5);
    path2.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, fillStroke);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Orange extends CustomPainter {
  Orange({
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = const Color.fromARGB(255, 194, 156, 21)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 178, 46)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color.fromARGB(255, 70, 159, 37)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = const Color.fromARGB(255, 215, 150, 38)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * .5, size.height);
    path.arcToPoint(
      Offset(size.width * .5, size.height * .2),
      radius: Radius.circular(size.width * .1),
    );
    path.arcToPoint(
      Offset(size.width * .5, size.height),
      radius: Radius.circular(size.width * .1),
    );
    path.close();
    final path2 = Path();
    path2.moveTo(size.width * .75, size.height * .4);
    path2.arcToPoint(
      Offset(size.width * .9, size.height * .2),
      radius: Radius.circular(size.width * .1),
    );
    path2.arcToPoint(
      Offset(size.width, size.height * .4),
      radius: Radius.circular(size.width * .1),
    );
    path2.arcToPoint(
      Offset(size.width * .75, size.height * .4),
      radius: Radius.circular(size.width * .2),
      clockwise: false,
    );
    path2.close();

    final path3 = Path();
    path3.moveTo(size.width * .225, size.height * .825);
    path3.arcToPoint(
      Offset(size.width * .775, size.height * .4),
      radius: Radius.circular(size.width * .3),
      clockwise: false,
    );
    path3.arcToPoint(
      Offset(size.width * .225, size.height * .825),
      radius: Radius.circular(size.width * .35),
    );

    path3.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, fillStroke);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Bat extends CustomPainter {
  Bat({
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = const Color.fromARGB(255, 255, 225, 115)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.25;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 225, 115)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color.fromARGB(255, 89, 63, 13)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(size.width * .01, size.height * .7);
    path2.arcToPoint(
      Offset(size.width * .125, size.height * .975),
      radius: Radius.circular(size.width * .3),
    );
    path2.arcToPoint(
      Offset(size.width * .01, size.height * .7),
      radius: Radius.circular(size.width * .5),
    );
    path2.moveTo(size.width * .05, size.height * .775);
    path2.lineTo(size.width * .325, size.height * .55);
    path2.lineTo(size.width * .4, size.height * .725);
    path2.lineTo(size.width * .125, size.height * .9);
    path2.close();
    final path = Path();
    path.moveTo(size.width * .05, size.height * .8);
    path.lineTo(size.width * .8, size.height * .2);
    path.arcToPoint(
      Offset(size.width * .95, size.height * .35),
      radius: Radius.circular(size.width * .01),
    );
    path.lineTo(size.width * .125, size.height * .875);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, fillStroke);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Baseball extends CustomPainter {
  Baseball({
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 212, 212, 212)
      ..style = PaintingStyle.fill;

    final fillStroke2 = Paint()
      ..color = const Color.fromARGB(255, 194, 65, 65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();
    path.moveTo(size.width * .5, size.height);
    path.arcToPoint(
      Offset(size.width * .5, 0),
      radius: Radius.circular(size.width * .1),
    );
    path.arcToPoint(
      Offset(size.width * .5, size.height),
      radius: Radius.circular(size.width * .1),
    );
    path.close();
    final path2 = Path();
    path2.moveTo(size.width * .275, size.height * .9);
    path2.arcToPoint(
      Offset(size.width * .275, size.height * .1),
      radius: Radius.circular(size.width * .5),
      clockwise: false,
    );
    path2.moveTo(size.width * .725, size.height * .9);
    path2.arcToPoint(
      Offset(size.width * .725, size.height * .1),
      radius: Radius.circular(size.width * .5),
      clockwise: true,
    );
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, fillStroke2);
    canvas.drawPath(path, fillStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class IQtest1 extends CustomPainter {
  IQtest1({
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 193, 182, 107)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color.fromARGB(255, 135, 124, 55)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * .9);
    path.lineTo(size.width, size.height * .9);
    path.close();
    final path2 = Path();
    path2.moveTo(0, size.height * .9);
    path2.lineTo(size.width, size.height * .9);
    path2.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path, fillStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class IQtest2 extends CustomPainter {
  IQtest2({
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 193, 182, 107)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color.fromARGB(255, 135, 124, 55)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * .9);
    path.lineTo(size.width, size.height * .9);
    path.close();
    final path2 = Path();
    path2.moveTo(0, size.height * .9);
    path2.lineTo(size.width, size.height * .9);
    path2.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path, fillStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
