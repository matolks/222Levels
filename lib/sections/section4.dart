import 'package:flutter/services.dart';
import 'package:levels222_0/models/hidden_cup.dart';
import 'package:levels222_0/models/keyboard.dart';
import 'package:levels222_0/pages/home.dart';

class Section4 extends StatefulWidget {
  const Section4({super.key});

  @override
  State<Section4> createState() => _Section4State();
}

class _Section4State extends State<Section4> {
  bool showHome = true;
  int currentPage = 0;
  bool canGo = false;
  int lostInt = 0;
  int currentAdNum = 0;
  int adCap = 4;
  double rightArrowOpacity = 1;
  double leftArrowOpacity = 1;
  List<String> titles = [
    'Reverse',
    'Pink Cow Question',
    'Hidden Cup',
    'Pink Cow Question',
    'Find the Fox',
    'Pink Cow Question'
  ];
  // Pink Cow Functions
  List<int> clicked = [-1, -1];
  int whichQuestion = 0;
  List<String> cowGuess = [];
  bool guessed = false;
  // Find the Fox Functions
  List<String> foxSearch = [
    "OFXOXFOFFOOXFXOOFXXOXFOFX",
    "FOFOOFXXXOXXFXOOXOXXFXOXF",
    "XFXFOFXOXOOXOOFXXXOOXFXOX",
    "XXXFXXOXOOXXOXFOFXOXXOOOX",
    "FFOFXOOOOXXOXXOXFOFXOOXOX",
    "OFXXXOXXFXOOXOOXFXFXXOXXX",
    "OFXOXFOFFOOXXXOOFXXOXFOFX",
    "XXOXOOXXOXOOFXOXXOOOFXOXX",
    "XFOOXOOXFOOXOXOOOXOXOOXOX",
    "XOXXOXXFXOXXFXOOXOXXFOOOF",
    "XOXFOFXOXOOXFOFXFXOOXOOFO",
    "XXOOXXOOOOXXOXOOFXOXOOOOF",
    "FOOFXFOOOXOOFXOXFOFXOOXFX",
    "OXXXFOOXFXOOXOXXFXFXFOOOX",
    "OFXOXFOFFOFOFXOOXFXOXFOFX",
    "XXOXOOXXOXOOFXOXXXOOFXOXX",
    "XFOOXOOXFOOOOOFOFOOFXOXFF",
    "XOXXOXXXXOOXFXOOXOXXFXFXF",
    "XOXFOFXOXXOOFOFXFXOOFFXOX",
    "XXOOXXOXOOFXOXFOFXOOXFOOF",
    "FOOFXOOOOXOOFXOXFOFXOOXOX",
    "OXXOXOXXFXOOFOOXFXFFFFOFX",
    "OFXOXFOFFOFXFXOOFFXOXFOFX",
    "XXOXOOXXOXFOFXOXXFOOFFOOX",
    "XOXFOFXOOFOOFOFXFXOOXFXOX",
  ];
  int foxRow = 0;
  int foxCol = 0;
  int numTaps = 0;
  bool found = false;

  @override
  void initState() {
    loadAd();
    currentAdNum = box.get('currentAd') ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    videoAd?.dispose();
    super.dispose();
  }

  // Back Arrow Logic
  void backArrow() {
    if (currentPage == 0) {
      showHome = false;
      currentPage++;
      leftArrowOpacity = .2;
      rightArrowOpacity = .2;
      setState(() {});
    }
  }

  // Front Arrow Logic
  void frontArrow() {
    if (currentPage == 0) {
      backSection(3, context);
    } else if (canGo) {
      if (currentPage == 5) {
        nextSection(4, context);
      }
      currentPage++;
      if (currentPage > 1) {
        whichQuestion = 1;
      }
      canGo = false;
      leftArrowOpacity = .2;
      rightArrowOpacity = .2;
      setState(() {});
    }
  }

  // Shows Ad and Updates Counter
  void showAd() {
    videoAd!.show();
    videoAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
      updateAd(4, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(4, currentAdNum, adCap, showAd, context);
  }

  // lost level
  SizedBox lostLevel() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 3),
            child: appText(
                numTaps > 5 ? 'Way to many guesses \n🤣🤣' : 'Loser 🤣🤣',
                AppColors.lightGrey,
                numTaps > 5
                    ? deviceWidth(context) / 16
                    : deviceWidth(context) / 12,
                FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 6),
            child: GestureDetector(
              onTap: () {
                checkAd();
              },
              child: button(
                  context,
                  const Color(0xff97BC62),
                  const Color(0xff2C5F2D),
                  const Color(0xff2C5F2D),
                  '👈 Nope Get Back',
                  AppColors.lightGrey,
                  null),
            ),
          ),
        ],
      ),
    );
  }

  // Reverse Button
  SizedBox reverse() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: -3.14 / 4,
            child: SizedBox(
              width: deviceWidth(context) / 4,
              height: deviceWidth(context) / 4,
              child: Column(
                children: [
                  Container(
                    color: AppColors.backgroundColor,
                    width: deviceWidth(context) / 4,
                    height: deviceWidth(context) / 8,
                    child: CustomPaint(
                      painter: ReverseCard(),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Container(
                      color: AppColors.backgroundColor,
                      width: deviceWidth(context) / 4,
                      height: deviceWidth(context) / 8,
                      child: CustomPaint(
                        painter: ReverseCard(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: deviceWidth(context) / 1.75,
            height: deviceHeight(context) / 2.5,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightGrey, width: 4.0),
                borderRadius: BorderRadius.circular(25)),
          ),
          Transform.rotate(
            angle: 2.75 / 5.25,
            child: Container(
              width: deviceWidth(context) / 3,
              height: deviceHeight(context) / 2.25,
              color: Colors.transparent,
              child: CustomPaint(
                painter: Oval(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Cow Questions 1 and 2
  SizedBox pinkCowQuestions() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Column(
        children: [
          // questions
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 4.75),
            child: SizedBox(
              width: deviceWidth(context) / 1.15,
              child: appText(
                  currentPage == 1
                      ? "How many spots did the pink cow have?"
                      : "What color were the PINK cows eyes?",
                  AppColors.lightGrey,
                  deviceWidth(context) / 19,
                  FontWeight.w400),
            ),
          ),
          // question 1
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 18),
            child: GestureDetector(
              onTap: () {
                if (clicked[whichQuestion] < 0) {
                  if (whichQuestion == 1) {
                    clicked[whichQuestion] = 0;
                    canGo = true;
                    rightArrowOpacity = 1;
                  } else {
                    lostInt = 6 - currentPage;
                  }
                  setState(() {});
                }
              },
              child: button(
                  context,
                  clicked[whichQuestion] < 0
                      ? AppColors.middleGrey
                      : clicked[whichQuestion] == 0
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  clicked[whichQuestion] < 0
                      ? AppColors.backgroundColor
                      : clicked[whichQuestion] == 0
                          ? AppColors.lightGrey
                          : AppColors.backgroundColor,
                  clicked[whichQuestion] < 0
                      ? AppColors.backgroundColor
                      : clicked[whichQuestion] == 0
                          ? whichQuestion == 1
                              ? const Color(0xff30A431)
                              : AppColors.backgroundColor
                          : AppColors.backgroundColor,
                  currentPage == 1 ? "3" : "Green",
                  clicked[whichQuestion] < 0
                      ? AppColors.middleGrey
                      : clicked[whichQuestion] == 0
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  null),
            ),
          ),
          // question 2
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 40),
            child: GestureDetector(
              onTap: () {
                if (clicked[whichQuestion] < 0) {
                  lostInt = 6 - currentPage;
                  setState(() {});
                }
              },
              child: button(
                  context,
                  AppColors.middleGrey,
                  AppColors.backgroundColor,
                  AppColors.backgroundColor,
                  currentPage == 1 ? "4" : "Black",
                  AppColors.middleGrey,
                  null),
            ),
          ),
          // question 3
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 40),
            child: GestureDetector(
              onTap: () {
                if (clicked[whichQuestion] < 0) {
                  if (whichQuestion == 0) {
                    clicked[whichQuestion] = 2;
                    canGo = true;
                    rightArrowOpacity = 1;
                  } else {
                    lostInt = 6 - currentPage;
                  }
                  setState(() {});
                }
              },
              child: button(
                  context,
                  clicked[whichQuestion] < 0
                      ? AppColors.middleGrey
                      : clicked[whichQuestion] == 2
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  clicked[whichQuestion] < 0
                      ? AppColors.backgroundColor
                      : clicked[whichQuestion] == 2
                          ? AppColors.lightGrey
                          : AppColors.backgroundColor,
                  clicked[whichQuestion] < 0
                      ? AppColors.backgroundColor
                      : clicked[whichQuestion] == 2
                          ? whichQuestion == 0
                              ? const Color(0xff30A431)
                              : AppColors.backgroundColor
                          : AppColors.backgroundColor,
                  currentPage == 1 ? "5" : "Pink",
                  clicked[whichQuestion] < 0
                      ? AppColors.middleGrey
                      : clicked[whichQuestion] == 2
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  null),
            ),
          ),
          // question 4
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 40),
            child: GestureDetector(
              onTap: () {
                if (clicked[whichQuestion] < 0) {
                  lostInt = 6 - currentPage;
                  setState(() {});
                }
              },
              child: button(
                  context,
                  AppColors.middleGrey,
                  AppColors.backgroundColor,
                  AppColors.backgroundColor,
                  currentPage == 1 ? "6" : "Blue",
                  AppColors.middleGrey,
                  null),
            ),
          ),
          // question 5
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 40),
            child: GestureDetector(
              onTap: () {
                if (clicked[whichQuestion] < 0) {
                  lostInt = 6 - currentPage;
                  setState(() {});
                }
              },
              child: button(
                  context,
                  AppColors.middleGrey,
                  AppColors.backgroundColor,
                  AppColors.backgroundColor,
                  currentPage == 1 ? "7" : "White",
                  AppColors.middleGrey,
                  null),
            ),
          ),
        ],
      ),
    );
  }

  // Hidden Cup Level
  SizedBox hiddenCupLvl() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Stack(
        children: [
          HiddenCup(
            checkAd: checkAdCup,
          ),
        ],
      ),
    );
  }

  // Hidden Cup Helper
  void checkAdCup(bool isCorrect) {
    if (isCorrect) {
      canGo = true;
      rightArrowOpacity = 1;
      setState(() {});
    } else {
      checkAd();
    }
  }

  // Find the Fox
  SizedBox findTheFox() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Center(
        child: Container(
          width: deviceWidth(context) / 1.05,
          height: deviceHeight(context) * .65,
          color: AppColors.backgroundColor,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: 625,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 25,
              childAspectRatio: (deviceWidth(context) / 1.05) /
                  (deviceHeight(context) * .65) /
                  25 *
                  25,
            ),
            itemBuilder: (context, index) {
              if (currentPage != 4) {
                return const SizedBox();
              }
              int foxRow = index ~/ 25;
              int foxCol = index % 25;
              if (foxRow < 22 && foxRow > 18 && foxCol == 20) {
                return GestureDetector(
                  onTap: () {
                    if (numTaps < 6 && !found) {
                      canGo = true;
                      rightArrowOpacity = 1;
                      found = true;
                      setState(() {});
                    }
                  },
                  child: Center(
                    key: ValueKey('$foxRow-$foxCol'),
                    child: appText(
                      foxSearch[foxRow][foxCol],
                      found ? const Color(0xff30A431) : AppColors.lightGrey,
                      deviceWidth(context) / 27,
                      FontWeight.w300,
                    ),
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    if (!found) {
                      if (numTaps > 5) {
                        lostInt = 6 - currentPage;
                        setState(() {});
                      }
                      numTaps++;
                    }
                  },
                  child: Center(
                    key: ValueKey('$foxRow-$foxCol'),
                    child: appText(
                      foxSearch[foxRow][foxCol],
                      AppColors.lightGrey,
                      deviceWidth(context) / 27,
                      FontWeight.w300,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // WHAT COWS EAT
  SizedBox whatCowsEat() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Column(
        children: [
          // question
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) * (3 / 16)),
            child: SizedBox(
              width: deviceWidth(context) / 1.1,
              height: deviceHeight(context) / 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  appText(
                      !guessed
                          ? "What does the pink cow eat?"
                          : canGo
                              ? 'It was always tacos'
                              : 'No the pink cow does NOT eat\n"${cowGuess.join('')}"',
                      AppColors.lightGrey,
                      deviceWidth(context) / 18,
                      FontWeight.w400),
                ],
              ),
            ),
          ),
          // Guess
          guessed == false
              ? Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 11),
                  child: SizedBox(
                    width: deviceWidth(context) / 1.25,
                    height: deviceHeight(context) / 22,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: deviceWidth(context) / 1.25,
                          child: appText(
                              cowGuess.join(''),
                              AppColors.middleGrey,
                              deviceWidth(context) / 20,
                              FontWeight.w600),
                        ),
                        Container(
                          width: deviceWidth(context) / 1.25,
                          height: deviceWidth(context) / 100,
                          color: AppColors.darkerGrey,
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: deviceHeight(context) * (6 / 22),
                  width: deviceWidth(context) / 1.15,
                  child: canGo
                      ? const SizedBox()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                checkAd();
                              },
                              child: SizedBox(
                                width: deviceWidth(context),
                                child: button(
                                    context,
                                    const Color(0xff97BC62),
                                    const Color(0xff2C5F2D),
                                    const Color(0xff2C5F2D),
                                    '👈 Get Back',
                                    AppColors.lightGrey,
                                    null),
                              ),
                            ),
                          ],
                        ),
                ),
          // keyboard
          Padding(
            padding: EdgeInsets.only(
                top: !guessed
                    ? deviceHeight(context) / 6.75
                    : deviceHeight(context) * (7 / 594)),
            child: Keyboard(
              onKeyTapped: onKeyTapped,
              onDeleteTapped: onDeleteTapped,
              onEnterTapped: onEnterTapped,
              onSpaceTapped: onSpaceTapped,
              isWordle: false,
            ),
          ),
        ],
      ),
    );
  }

  void onKeyTapped(String val) {
    if (cowGuess.length < 20 && !guessed) {
      HapticFeedback.selectionClick();
      cowGuess.add(val);
      setState(() {});
    } else {
      HapticFeedback.lightImpact();
    }
  }

  void onDeleteTapped() {
    if (cowGuess.isNotEmpty && !guessed) {
      HapticFeedback.selectionClick();
      cowGuess.removeLast();
      setState(() {});
    } else {
      HapticFeedback.lightImpact();
    }
  }

  void onEnterTapped() {
    if (!guessed && cowGuess.isNotEmpty) {
      HapticFeedback.lightImpact();
      guessed = true;
      String temp = cowGuess.join('');
      if (temp.contains("TACOS")) {
        canGo = true;
        rightArrowOpacity = 1;
      }
      setState(() {});
    } else {
      HapticFeedback.lightImpact();
    }
  }

  void onSpaceTapped() {
    if (cowGuess.isNotEmpty && cowGuess.length < 20 && !guessed) {
      HapticFeedback.selectionClick();
      cowGuess.add(' ');
      setState(() {});
    } else {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Top Bar and Arrows
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(
                home: showHome,
                banner1: const Color(0xff97BC62),
                banner2: const Color(0xff2C5F2D),
                banner3: const Color(0xff2C5F2D),
                title: titles[currentPage],
                opacity: 1,
                numbers: allNumbers[currentPage + 22],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xff97BC62),
                arrow2: const Color(0xff97BC62),
                arrow3: const Color(0xff2C5F2D),
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // Levels
          IndexedStack(
            index: currentPage + lostInt,
            children: <Widget>[
              reverse(),
              pinkCowQuestions(),
              hiddenCupLvl(),
              pinkCowQuestions(),
              findTheFox(),
              whatCowsEat(),
              lostLevel(),
            ],
          )
        ],
      ),
    );
  }
}

class ReverseCard extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = AppColors.lightGrey
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.arcToPoint(
      Offset(size.width * .5, size.height * .25),
      radius: Radius.circular(size.width * .5),
    );
    path.lineTo(size.width * .75, size.height * .25);
    path.lineTo(size.width * .75, 0);
    path.lineTo(size.width, size.height * .5);
    path.lineTo(size.width * .75, size.height);
    path.lineTo(size.width * .75, size.height * .75);
    path.lineTo(size.width * .45, size.height * .75);
    path.arcToPoint(Offset(0, size.height),
        radius: Radius.circular(size.width * .95), clockwise: false);
    path.close();

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Oval extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = AppColors.lightGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final rect =
        Rect.fromLTWH(0, size.height * .05, size.width, size.height * .9);
    canvas.drawOval(rect, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
