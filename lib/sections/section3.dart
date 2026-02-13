import 'dart:async';
import 'package:levels222_0/pages/home.dart';

class Section3 extends StatefulWidget {
  const Section3({super.key});

  @override
  State<Section3> createState() => _Section3State();
}

class _Section3State extends State<Section3> with TickerProviderStateMixin {
  // Universal Logic
  bool showHome = true;
  bool canGo = false;
  int currentPage = 0;
  int currentAdNum = 0;
  int adCap = 4;
  double rightArrowOpacity = .2;
  double leftArrowOpacity = 1;
  int failedLevel = 0; // = (10 - currentPage)
  // Heart Logic
  late AnimationController heart1;
  late AnimationController heart2;
  Animation<Size>? heart1Pos;
  Animation<Size>? heart2Pos;
  Animation<Size>? heart1Sz;
  Animation<Size>? heart2Sz;
  // Questions
  List<List<String>> questionData = [
    [
      "The answer",
      "Not this one",
      "Correct",
      "Indubitably",
    ],
    [
      "∞",
      "AYE",
      "Very large",
      "Blue Whale",
    ],
    [
      "15",
      "16",
      "Idk",
      "18",
    ],
    [
      "A.     C     ",
      "B.     A     ",
      "C.     B     ",
      "D.     D     ",
    ],
    [
      "Eno siht ton",
      "KO",
      "Daer ay edam",
      "Tacocat",
    ],
    [
      "It is this one",
      "No, it is this one",
      "No, it is this one",
      "No, it is this one",
    ],
  ];
  List<String> questions = [
    "the answer",
    "The answer is very large",
    "33 - 16 =",
    "The answer is A",
    "Tcerroc eb ot evah eseht fo eno",
    "You can't get this one wrong",
  ];
  int placeMarker = 0;
  List<int> clicked = [-1, -1, -1, -1, -1, -1];
  List<bool> lives = [true, true];
  bool canTapButton = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    loadAd();
    currentAdNum = box.get('currentAd') ?? 0;
    heart1 = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    heart1.addListener(() {
      setState(() {});
    });
    heart2 = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    heart2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    heart1Pos = Tween<Size>(
      begin: Size(
        deviceWidth(context) * 25 / 64,
        0,
      ),
      end: Size(
        deviceWidth(context) * 20 / 32,
        deviceWidth(context) / 4,
      ),
    ).animate(
      CurvedAnimation(
        parent: heart1,
        curve: Curves.easeOutQuad,
      ),
    );
    heart1Sz = Tween<Size>(
      begin: Size(
        deviceWidth(context) / 8,
        deviceWidth(context) / 10,
      ),
      end: const Size(
        0,
        0,
      ),
    ).animate(
      CurvedAnimation(
        parent: heart1,
        curve: Curves.linearToEaseOut,
      ),
    );
    heart2Pos = Tween<Size>(
      begin: Size(
        deviceWidth(context) * 33 / 64,
        0,
      ),
      end: Size(
        deviceWidth(context) * 24 / 32,
        deviceWidth(context) / 4,
      ),
    ).animate(
      CurvedAnimation(
        parent: heart2,
        curve: Curves.easeOutQuad,
      ),
    );
    heart2Sz = Tween<Size>(
      begin: Size(
        deviceWidth(context) / 8,
        deviceWidth(context) / 10,
      ),
      end: const Size(
        0,
        0,
      ),
    ).animate(
      CurvedAnimation(
        parent: heart2,
        curve: Curves.linearToEaseOut,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    heart1.dispose();
    heart2.dispose();
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
      updateAd(3, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // Checks if add is needed
  void checkAd() {
    updateAttempt(3, currentAdNum, adCap, showAd, context);
  }

  // Back Arrow Logic
  void backArrow() {
    if (currentPage == 0 && showHome) {
      backSection(2, context);
    } else if (!canGo) {
      lossLife();
    }
  }

  // Front Arrow Logic
  void frontArrow() {
    if (canGo) {
      if (currentPage == 9) {
        nextSection(3, context);
      }
      currentPage++;
      canGo = false;
      setState(() {});
      rightArrowOpacity = .2;
      if (currentPage != 1 &&
          currentPage != 3 &&
          currentPage != 3 &&
          currentPage != 5 &&
          currentPage != 9) {
        placeMarker++;
      }
      if (currentPage == 3) {
        waitForButton();
      }
      setState(() {});
    } else {
      lossLife();
    }
  }

  // Removes Life
  void lossLife() {
    if (lives[0]) {
      heart1.forward();
      lives[0] = false;
    } else if (lives[1]) {
      heart2.forward();
      lives[1] = false;
      failedLevel = 10 - currentPage;
    }
    if (showHome) {
      showHome = false;
    }
    setState(() {});
  }

  // 1, 3, 5, 7, 8, 9
  SafeArea impossibleQuestions1() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // questions
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 5),
            child: SizedBox(
              width: deviceWidth(context),
              height: deviceHeight(context) / 10,
              child: GestureDetector(
                onTap: () {
                  if (placeMarker == 0) {
                    showHome = false;
                    leftArrowOpacity = .2;
                    canGo = true;
                    rightArrowOpacity = 1;
                  } else if (!canGo) {
                    leftArrowOpacity = .2;
                    lossLife();
                  }
                  setState(() {});
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        currentPage == 0
                            ? appText2("Click ", AppColors.lightGrey,
                                deviceWidth(context) / 19, FontWeight.w500)
                            : const SizedBox(),
                        appText(
                            questions[placeMarker],
                            currentPage == 0 && canGo
                                ? const Color(0xff30A431)
                                : AppColors.lightGrey,
                            deviceWidth(context) / 19,
                            FontWeight.w500),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 1
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 40),
            child: GestureDetector(
              onTap: () {
                if (!canGo) {
                  clicked[placeMarker] = 0;
                  leftArrowOpacity = .2;
                  if (placeMarker == 3 || placeMarker == 5) {
                    canGo = true;
                    rightArrowOpacity = 1;
                  } else {
                    lossLife();
                  }
                  setState(() {});
                }
              },
              child: button(
                  context,
                  clicked[placeMarker] != 0
                      ? AppColors.middleGrey
                      : placeMarker == 3 || placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  clicked[placeMarker] != 0
                      ? AppColors.backgroundColor
                      : placeMarker == 3 || placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.backgroundColor,
                  clicked[placeMarker] != 0
                      ? AppColors.backgroundColor
                      : placeMarker == 3 || placeMarker == 5
                          ? const Color(0xff30A431)
                          : AppColors.backgroundColor,
                  questionData[placeMarker][0],
                  clicked[placeMarker] != 0
                      ? AppColors.middleGrey
                      : placeMarker == 3 || placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  null),
            ),
          ),
          // 2
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 25),
            child: GestureDetector(
              onTap: () {
                if (!canGo) {
                  clicked[placeMarker] = 1;
                  leftArrowOpacity = .2;
                  if (placeMarker == 4 || placeMarker == 5) {
                    canGo = true;
                    rightArrowOpacity = 1;
                  } else {
                    lossLife();
                  }
                  setState(() {});
                }
              },
              child: button(
                  context,
                  clicked[placeMarker] != 1
                      ? AppColors.middleGrey
                      : placeMarker == 4 || placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  clicked[placeMarker] != 1
                      ? AppColors.backgroundColor
                      : placeMarker == 4 || placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.backgroundColor,
                  clicked[placeMarker] != 1
                      ? AppColors.backgroundColor
                      : placeMarker == 4 || placeMarker == 5
                          ? const Color(0xff30A431)
                          : AppColors.backgroundColor,
                  questionData[placeMarker][1],
                  clicked[placeMarker] != 1
                      ? AppColors.middleGrey
                      : placeMarker == 4 || placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  null),
            ),
          ),
          // 3
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 25),
            child: GestureDetector(
              onTap: () {
                if (!canGo) {
                  clicked[placeMarker] = 2;
                  leftArrowOpacity = .2;
                  if (placeMarker == 5) {
                    canGo = true;
                    rightArrowOpacity = 1;
                  } else {
                    lossLife();
                  }
                  setState(() {});
                }
              },
              child: button(
                  context,
                  clicked[placeMarker] != 2
                      ? AppColors.middleGrey
                      : placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  clicked[placeMarker] != 2
                      ? AppColors.backgroundColor
                      : placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.backgroundColor,
                  clicked[placeMarker] != 2
                      ? AppColors.backgroundColor
                      : placeMarker == 5
                          ? const Color(0xff30A431)
                          : AppColors.backgroundColor,
                  questionData[placeMarker][2],
                  clicked[placeMarker] != 2
                      ? AppColors.middleGrey
                      : placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  null),
            ),
          ),
          // 4
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 25),
            child: GestureDetector(
              onTap: () {
                if (!canGo) {
                  clicked[placeMarker] = 3;
                  leftArrowOpacity = .2;
                  if (placeMarker == 1 || placeMarker == 5) {
                    canGo = true;
                    rightArrowOpacity = 1;
                  } else {
                    lossLife();
                  }
                  setState(() {});
                }
              },
              child: button(
                  context,
                  clicked[placeMarker] != 3
                      ? AppColors.middleGrey
                      : placeMarker == 1 || placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  clicked[placeMarker] != 3
                      ? AppColors.backgroundColor
                      : placeMarker == 1 || placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.backgroundColor,
                  clicked[placeMarker] != 3
                      ? AppColors.backgroundColor
                      : placeMarker == 1 || placeMarker == 5
                          ? const Color(0xff30A431)
                          : AppColors.backgroundColor,
                  questionData[placeMarker][3],
                  clicked[placeMarker] != 3
                      ? AppColors.middleGrey
                      : placeMarker == 1 || placeMarker == 5
                          ? AppColors.lightGrey
                          : AppColors.middleGrey,
                  null),
            ),
          ),
        ],
      ),
    );
  }

  // 2, 6
  SafeArea impossibleQuestions2() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // questions
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 5),
            child: SizedBox(
              width: deviceWidth(context),
              height: deviceHeight(context) / 15,
              child: GestureDetector(
                onTap: () {
                  if (currentPage == 1) {
                    rightArrowOpacity = 1;
                    canGo = true;
                    setState(() {});
                  } else if (!canGo) {
                    lossLife();
                  }
                },
                child: currentPage > 4
                    ? appText(
                        "How many letters are in the box?",
                        AppColors.lightGrey,
                        deviceWidth(context) / 22,
                        FontWeight.w500)
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              appText2(
                                  "Tap the smallest c",
                                  AppColors.lightGrey,
                                  deviceWidth(context) / 22,
                                  FontWeight.w500),
                              appText2(
                                  "i",
                                  canGo && currentPage == 1
                                      ? const Color(0xff30A431)
                                      : AppColors.lightGrey,
                                  deviceWidth(context) / 22,
                                  FontWeight.w500),
                              appText2("rcle", AppColors.lightGrey,
                                  deviceWidth(context) / 22, FontWeight.w500)
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ),
          currentPage > 4
              ? SizedBox(
                  height: deviceHeight(context) / 6,
                  child: Image.asset(
                    'lib/assets/images/section3/letterBox.png',
                    fit: BoxFit.contain,
                  ),
                )
              : const SizedBox(),
          // Answers 1 & 2
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 20),
            child: SizedBox(
              width: deviceWidth(context),
              height: currentPage > 4
                  ? deviceWidth(context) / 5
                  : deviceWidth(context) / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 1
                  GestureDetector(
                    onTap: () {
                      if (!canGo) {
                        lossLife();
                      }
                    },
                    child: Container(
                      width: deviceWidth(context) / 3,
                      height: currentPage > 4
                          ? deviceWidth(context) / 5
                          : deviceWidth(context) / 3,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        border: Border.all(
                          color: AppColors.middleGrey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: currentPage > 4
                          ? Center(
                              child: appText('4', AppColors.lightGrey,
                                  deviceWidth(context) / 16, FontWeight.w500),
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: deviceWidth(context) / 7,
                                  height: deviceWidth(context) / 7,
                                  decoration: const BoxDecoration(
                                    color: AppColors.lightGrey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  // 2
                  GestureDetector(
                    onTap: () {
                      if (!canGo) {
                        lossLife();
                      }
                    },
                    child: Container(
                      width: deviceWidth(context) / 3,
                      height: currentPage > 4
                          ? deviceWidth(context) / 5
                          : deviceWidth(context) / 3,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        border: Border.all(
                          color: AppColors.middleGrey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: currentPage > 4
                          ? Center(
                              child: appText('5', AppColors.lightGrey,
                                  deviceWidth(context) / 16, FontWeight.w500),
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: deviceWidth(context) / 7.75,
                                  height: deviceWidth(context) / 7.75,
                                  decoration: const BoxDecoration(
                                    color: AppColors.lightGrey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Answers 3 & 4
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 25),
            child: SizedBox(
              width: deviceWidth(context),
              height: currentPage > 4
                  ? deviceWidth(context) / 5
                  : deviceWidth(context) / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 3
                  GestureDetector(
                    onTap: () {
                      if (currentPage == 5) {
                        rightArrowOpacity = 1;
                        canGo = true;
                        setState(() {});
                      } else if (!canGo) {
                        lossLife();
                      }
                    },
                    child: Container(
                      width: deviceWidth(context) / 3,
                      height: currentPage > 4
                          ? deviceWidth(context) / 5
                          : deviceWidth(context) / 3,
                      decoration: BoxDecoration(
                        color: canGo && currentPage == 5
                            ? const Color(0xff30A431)
                            : AppColors.backgroundColor,
                        border: Border.all(
                          color: canGo && currentPage == 5
                              ? AppColors.lightGrey
                              : AppColors.middleGrey,
                          width: canGo && currentPage == 5 ? 3.0 : 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: currentPage > 4
                          ? Center(
                              child: appText('6', AppColors.lightGrey,
                                  deviceWidth(context) / 16, FontWeight.w500),
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: deviceWidth(context) / 7.2,
                                  height: deviceWidth(context) / 7.2,
                                  decoration: const BoxDecoration(
                                    color: AppColors.lightGrey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  // 4
                  GestureDetector(
                    onTap: () {
                      if (!canGo) {
                        lossLife();
                      }
                    },
                    child: Container(
                      width: deviceWidth(context) / 3,
                      height: currentPage > 4
                          ? deviceWidth(context) / 5
                          : deviceWidth(context) / 3,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        border: Border.all(
                          color: AppColors.middleGrey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: currentPage > 4
                          ? Center(
                              child: appText('7', AppColors.lightGrey,
                                  deviceWidth(context) / 16, FontWeight.w500),
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: deviceWidth(context) / 7.5,
                                  height: deviceWidth(context) / 7.5,
                                  decoration: const BoxDecoration(
                                    color: AppColors.lightGrey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
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

  // 4, 10
  SafeArea impossibleQuestions3() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // questions
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 4),
            child: SizedBox(
              width: deviceWidth(context),
              height: deviceHeight(context) / 15,
              child: GestureDetector(
                onTap: () {
                  if (!canGo) {
                    lossLife();
                  }
                },
                child: appText(
                    currentPage > 7
                        ? "Eye for an eye"
                        : canTapButton
                            ? "Ok, your good"
                            : "Do NOT touch",
                    AppColors.lightGrey,
                    deviceWidth(context) / 18,
                    FontWeight.w500),
              ),
            ),
          ),
          // Buttons
          currentPage < 6
              ? Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 50),
                  child: GestureDetector(
                    onTap: () {
                      if (canTapButton) {
                        canGo = true;
                        rightArrowOpacity = 1;
                        setState(() {});
                      } else if (!canGo) {
                        lossLife();
                      }
                    },
                    child: SizedBox(
                      width: deviceWidth(context) / 3,
                      height: deviceWidth(context) / 2.75,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          gameButton(
                            context,
                            AppColors.darkGrey,
                            AppColors.darkerGrey,
                            canTapButton
                                ? const Color(0xff30A431)
                                : const Color(0xffE33333),
                          ),
                          Container(
                            color: AppColors.backgroundColor.withOpacity(0),
                            width: deviceWidth(context) / 3.75,
                            height: deviceWidth(context) / 3.75,
                            child: CustomPaint(
                              painter: SmileFrown(
                                  color: AppColors.backgroundColor,
                                  canTap: canTapButton),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 25),
                  child: GestureDetector(
                    onTap: () {
                      if (!canGo) {
                        lossLife();
                        canGo = true;
                        rightArrowOpacity = 1;
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: deviceWidth(context) / 1.75,
                      height: deviceWidth(context) / 3,
                      color: AppColors.backgroundColor,
                      child: CustomPaint(
                        painter: Eye(),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  // button functionability
  void waitForButton() {
    _timer = Timer(const Duration(seconds: 30), () {
      setState(() {
        canTapButton = true;
      });
    });
  }

  //lost quiz
  SizedBox lostQuiz() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 3),
            child: appText('You are a idiot', AppColors.lightGrey,
                deviceWidth(context) / 16, FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 10),
            child: GestureDetector(
              onTap: () {
                checkAd();
              },
              child: button(
                  context,
                  const Color(0xFFF96167),
                  const Color(0xFFFCE77D),
                  const Color(0xFFF96167),
                  '👈  try again',
                  AppColors.lightGrey,
                  null),
            ),
          )
        ],
      ),
    );
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
                banner1: const Color(0xFFFCE77D),
                banner2: const Color(0xFFF96167),
                banner3: const Color(0xFFF96167),
                title: "Impossible Quiz",
                opacity: 1,
                numbers: allNumbers[currentPage + 12],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xFFF96167),
                arrow2: const Color(0xFFFCE77D),
                arrow3: const Color(0xFFF96167),
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // Hearts
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: deviceHeight(context) / 13),
              child: SizedBox(
                width: deviceWidth(context),
                child: Stack(
                  children: [
                    // HEART 1
                    Positioned(
                      left: deviceWidth(context) * 25 / 64,
                      top: 0,
                      child: SizedBox(
                        width: deviceWidth(context) / 8,
                        height: deviceWidth(context) / 10,
                        child: CustomPaint(
                          painter: Lives(
                              color: AppColors.backgroundColor, isBorder: true),
                        ),
                      ),
                    ),
                    // HEART 2
                    Positioned(
                      left: deviceWidth(context) * 33 / 64,
                      top: 0,
                      child: SizedBox(
                        width: deviceWidth(context) / 8,
                        height: deviceWidth(context) / 10,
                        child: CustomPaint(
                          painter: Lives(
                              color: AppColors.backgroundColor, isBorder: true),
                        ),
                      ),
                    ),
                    // HEART 1 Animation
                    Positioned(
                      left: heart1Pos != null
                          ? heart1Pos!.value.width
                          : deviceWidth(context) * 25 / 64,
                      top: heart1Pos != null ? heart1Pos!.value.height : 0,
                      child: SizedBox(
                        width: heart1Sz != null
                            ? heart1Sz!.value.width
                            : deviceWidth(context) / 8,
                        height: heart1Sz != null
                            ? heart1Sz!.value.height
                            : deviceWidth(context) / 10,
                        child: CustomPaint(
                          painter: Lives(
                              color: const Color(0xFFF96167), isBorder: false),
                        ),
                      ),
                    ),
                    // HEART 2 Animation
                    Positioned(
                      left: heart2Pos != null
                          ? heart2Pos!.value.width
                          : deviceWidth(context) * 33 / 64,
                      top: heart2Pos != null ? heart2Pos!.value.height : 0,
                      child: SizedBox(
                        width: heart2Sz != null
                            ? heart2Sz!.value.width
                            : deviceWidth(context) / 8,
                        height: heart2Sz != null
                            ? heart2Sz!.value.height
                            : deviceWidth(context) / 10,
                        child: CustomPaint(
                          painter: Lives(
                              color: const Color(0xFFF96167), isBorder: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Answers
          SafeArea(
            child: SizedBox(
              width: deviceWidth(context),
              height: deviceWidth(context) / 5.75,
              child: Row(
                children: [
                  // banner button
                  GestureDetector(
                    onTap: () {
                      if (currentPage == 4) {
                        rightArrowOpacity = 1;
                        canGo = true;
                        setState(() {});
                      } else if (!canGo) {
                        leftArrowOpacity = .2;
                        lossLife();
                      }
                    },
                    child: Container(
                      color: AppColors.backgroundColor.withOpacity(0),
                      width: deviceWidth(context) / 4.5,
                      height: deviceWidth(context) / 5.75,
                    ),
                  ),
                  // Rand life loss
                  GestureDetector(
                    onTap: () {
                      if (!canGo) {
                        leftArrowOpacity = .2;
                        lossLife();
                      }
                    },
                    child: Container(
                      color: AppColors.backgroundColor.withOpacity(0),
                      width: deviceWidth(context) / 2,
                      height: deviceWidth(context) / 5.75,
                    ),
                  )
                ],
              ),
            ),
          ),
          // Body
          IndexedStack(
            index: currentPage + failedLevel,
            children: <Widget>[
              impossibleQuestions1(),
              impossibleQuestions2(),
              impossibleQuestions1(),
              impossibleQuestions3(),
              impossibleQuestions1(),
              impossibleQuestions2(),
              impossibleQuestions1(),
              impossibleQuestions1(),
              impossibleQuestions1(),
              impossibleQuestions3(),
              lostQuiz(),
            ],
          )
        ],
      ),
    );
  }
}

class Eye extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = const Color(0xFFF96167)
      ..style = PaintingStyle.fill;

    final fillStroke = Paint()
      ..color = AppColors.middleGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final fillPaint2 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final fillStroke2 = Paint()
      ..color = const Color(0xFFFCE77D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final path = Path();
    final path2 = Path();
    path2.moveTo(size.width * .05, size.height / 2);
    path2.arcToPoint(
      Offset(size.width * .95, size.height / 2),
      radius: Radius.circular(size.width * .5),
    );
    path2.arcToPoint(
      Offset(size.width * .05, size.height / 2),
      radius: Radius.circular(size.width * 0.55),
    );
    path2.close();
    path.moveTo(size.width * .38, size.height / 2);
    path.arcToPoint(
      Offset(size.width * .62, size.height / 2),
      radius: const Radius.circular(.1),
    );
    path.arcToPoint(
      Offset(size.width * .38, size.height / 2),
      radius: const Radius.circular(.1),
    );
    path.close();
    canvas.drawPath(path2, fillStroke);
    canvas.drawPath(path2, fillPaint2);
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, fillStroke2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SmileFrown extends CustomPainter {
  final Color color;
  final bool canTap;

  SmileFrown({required this.color, required this.canTap});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final fillStroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final path2 = Path();
    path.moveTo(size.width * .25, size.height * .75);
    path.arcToPoint(
      Offset(size.width * .75, size.height * .75),
      radius: Radius.circular(size.width * 0.6),
      clockwise: !canTap,
    );

    if (!canTap) {
      path.moveTo(size.width * .25, size.height * .27);
      path.lineTo(size.width * .45, size.height * .35);
      path.moveTo(size.width * .75, size.height * .27);
      path.lineTo(size.width * .55, size.height * .35);
    }

    path2.moveTo(size.width * .35, size.height * .42);
    path2.arcToPoint(
      Offset(size.width * .43, size.height * .42),
      radius: const Radius.circular(0.1),
      clockwise: true,
    );
    path2.arcToPoint(
      Offset(size.width * .35, size.height * .42),
      radius: const Radius.circular(.1),
      clockwise: true,
    );
    path2.moveTo(size.width * .65, size.height * .42);
    path2.arcToPoint(
      Offset(size.width * .57, size.height * .42),
      radius: const Radius.circular(0.1),
      clockwise: true,
    );
    path2.arcToPoint(
      Offset(size.width * .65, size.height * .42),
      radius: const Radius.circular(.1),
      clockwise: true,
    );

    canvas.drawPath(path, fillStroke);
    canvas.drawPath(path2, fillPaint);
    canvas.drawPath(path2, fillStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Lives extends CustomPainter {
  final Color color;
  final bool isBorder;

  Lives({required this.color, required this.isBorder});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final fillStroke = Paint()
      ..color = AppColors.lightGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(size.width * .1, size.height * .5);
    path.arcToPoint(
      Offset(size.width / 2, size.height * .3),
      radius: Radius.circular(size.width * 0.2),
    );
    path.arcToPoint(
      Offset(size.width * .9, size.height * .5),
      radius: Radius.circular(size.width * 0.2),
    );
    path.close();

    canvas.drawPath(path, fillPaint);
    if (isBorder) {
      canvas.drawPath(path, fillStroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
