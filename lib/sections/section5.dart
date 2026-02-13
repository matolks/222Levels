import 'dart:async';
import 'dart:math';
import 'package:levels222_0/assets/rive/rive_util.dart';
import 'package:levels222_0/models/death_screen.dart';
import 'package:levels222_0/models/shattering_widget.dart';
import 'package:levels222_0/pages/home.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/image.dart' as flutter_image;

// For Lock
List<int>? thePassword;

class Section5 extends StatefulWidget {
  const Section5({super.key});

  @override
  State<Section5> createState() => _Section5State();
}

class _Section5State extends State<Section5> {
  bool showHome = true;
  int currentPage = 0;
  bool canGo = false;
  double rightArrowOpacity = .2;
  double leftArrowOpacity = 1;
  double headerOpacity = 1;
  int currentAdNum = 0;
  int adCap = 4;
  List<String> titles = ['???', 'Defuse', 'Invisible Button', 'It\'s Broken?'];
  // which level functions
  int levelGuess = -1;
  // bomb functions
  Timer? _timer;
  static const maxSeconds = 100;
  double seconds = maxSeconds / 10;
  int numCut = 0;
  List<int> wiresCut = [
    0,
    0,
    0,
    0,
    0
  ]; // blue, pink, yellow, green, white (blue/white (0/4) and yellow/green (2/3))
  bool isAlive = true;
  final GlobalKey<ShatteringWidgetState> _shatteringKey =
      GlobalKey<ShatteringWidgetState>();
  // hidden mines
  List<int> tapped = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  late List<Size> poistions = [
    Size(
      deviceWidth(context) / 4,
      deviceHeight(context) / 5,
    ),
    Size(
      deviceWidth(context) / 4,
      deviceHeight(context) / 2.75,
    ),
    Size(
      deviceWidth(context) / 1.5,
      deviceHeight(context) / 2.25,
    ),
    Size(
      deviceWidth(context) / 20,
      deviceHeight(context) / 3.25,
    ),
    Size(
      deviceWidth(context) / 3,
      deviceHeight(context) / 1.5,
    ),
    Size(
      deviceWidth(context) / 1.5,
      deviceHeight(context) / 1.5,
    ),
    Size(
      deviceWidth(context) / 1.5,
      deviceHeight(context) / 8,
    ),
    Size(
      deviceWidth(context) / 10,
      deviceHeight(context) / 1.25,
    ),
    Size(
      deviceWidth(context) / 10,
      deviceHeight(context) / 2,
    ),
    Size(
      deviceWidth(context) / 2.25,
      deviceHeight(context) / 2,
    ),
  ];
  // lock functions
  int? chooseLeft = 0;
  List<int> tempPassword = [];
  // death screen
  final GlobalKey<DeathScreenState> _death = GlobalKey<DeathScreenState>();

  @override
  void initState() {
    loadAd();
    currentAdNum = box.get('currentAd') ?? 0;
    chooseLeft = box.get('chooseLeft');
    setPassword();
    thePassword = tempPassword;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    videoAd?.dispose();
    super.dispose();
  }

  // Back Arrow Logic
  void backArrow() {
    if (currentPage == 0 && showHome) {
      backSection(4, context);
    } else if (canGo) {
      if (currentPage == 1) {
        showHome = true;
      }
      canGo = true;
      rightArrowOpacity = 1;
      currentPage--;
      setState(() {});
    }
  }

  // Front Arrow logic
  void frontArrow() {
    if (canGo && currentPage < 3) {
      if (currentPage == 0) {
        showHome = false;
        if (numCut == 0) {
          rightArrowOpacity = .2;
          leftArrowOpacity = .2;
          startTimer();
          canGo = false;
        }
      }
      if (currentPage == 1) {
        if (tapped[0] != 1) {
          headerOpacity = 0;
          rightArrowOpacity = 0;
          leftArrowOpacity = 0;
          canGo = false;
        }
      }
      if (currentPage == 2) {
        rightArrowOpacity = .2;
        leftArrowOpacity = 1;
        canGo = true;
      }
      currentPage++;
      setState(() {});
    }
  }

  // Shows Ad and Updates Counter
  void showAd() {
    videoAd!.show();
    videoAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
      updateAd(5, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(5, currentAdNum, adCap, showAd, context);
  }

  // which level is next
  SizedBox whatLevel() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: levelGuess < 0 || levelGuess == 1
          ? Column(
              children: [
                // blocker
                SafeArea(
                  bottom: false,
                  child: Row(
                    children: [
                      Container(
                        width: deviceWidth(context) / 4.575,
                        height: deviceWidth(context) * 225 / 1403,
                        color: const Color(0xff333333),
                      ),
                    ],
                  ),
                ),
                // questions
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 9.5),
                  child: SizedBox(
                    width: deviceWidth(context),
                    height: deviceHeight(context) / 15,
                    child: appText("What level is next?", AppColors.lightGrey,
                        deviceWidth(context) / 20, FontWeight.w400),
                  ),
                ),
                // 1
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 25),
                  child: GestureDetector(
                    onTap: () {
                      if (levelGuess < 0) {
                        levelGuess = 2;
                        leftArrowOpacity = .2;
                        showHome = false;
                        setState(() {});
                      }
                    },
                    child: button(
                        context,
                        AppColors.middleGrey,
                        AppColors.backgroundColor,
                        AppColors.backgroundColor,
                        '33',
                        AppColors.middleGrey,
                        null),
                  ),
                ),
                // 2
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 45),
                  child: GestureDetector(
                    onTap: () {
                      if (levelGuess < 0) {
                        levelGuess = 2;
                        leftArrowOpacity = .2;
                        showHome = false;
                        setState(() {});
                      }
                    },
                    child: button(
                        context,
                        AppColors.middleGrey,
                        AppColors.backgroundColor,
                        AppColors.backgroundColor,
                        '32',
                        AppColors.middleGrey,
                        null),
                  ),
                ),
                // 3
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 45),
                  child: GestureDetector(
                    onTap: () {
                      if (levelGuess < 0) {
                        levelGuess = 2;
                        leftArrowOpacity = .2;
                        showHome = false;
                        setState(() {});
                      }
                    },
                    child: button(
                        context,
                        AppColors.middleGrey,
                        AppColors.backgroundColor,
                        AppColors.backgroundColor,
                        '31',
                        AppColors.middleGrey,
                        null),
                  ),
                ),
                // 4
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 45),
                  child: GestureDetector(
                    onTap: () {
                      if (levelGuess < 0) {
                        levelGuess = 1;
                        canGo = true;
                        rightArrowOpacity = 1;
                        leftArrowOpacity = 1;
                        setState(() {});
                      }
                    },
                    child: button(
                        context,
                        levelGuess < 0
                            ? AppColors.middleGrey
                            : AppColors.lightGrey,
                        levelGuess < 0
                            ? AppColors.backgroundColor
                            : AppColors.lightGrey,
                        levelGuess < 0
                            ? AppColors.backgroundColor
                            : const Color(0xff30A431),
                        '30',
                        levelGuess < 0
                            ? AppColors.middleGrey
                            : AppColors.lightGrey,
                        null),
                  ),
                ),
                // 5
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 45),
                  child: GestureDetector(
                    onTap: () {
                      if (levelGuess < 0) {
                        levelGuess = 2;
                        setState(() {});
                      }
                    },
                    child: button(
                        context,
                        AppColors.middleGrey,
                        AppColors.backgroundColor,
                        AppColors.backgroundColor,
                        '29',
                        AppColors.middleGrey,
                        null),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                // blocker
                SafeArea(
                  bottom: false,
                  child: Row(
                    children: [
                      Container(
                        width: deviceWidth(context) / 4.575,
                        height: deviceWidth(context) * 225 / 1403,
                        color: const Color(0xff333333),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 5),
                  child: SizedBox(
                    width: deviceWidth(context) / 1.1,
                    child: appText(
                        'You wish that level was next..\nyou gotta pay attention',
                        AppColors.lightGrey,
                        deviceWidth(context) / 18,
                        FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 10),
                  child: GestureDetector(
                    onTap: () {
                      checkAd();
                    },
                    child: button(
                        context,
                        const Color(0xffAEFFDE),
                        const Color(0xff333333),
                        const Color(0xffE4F1FF),
                        'Redo',
                        const Color(0xff333333),
                        null),
                  ),
                )
              ],
            ),
    );
  }

  // bomb level
  SizedBox defuseDefuse() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Stack(
        children: [
          // bomb
          isAlive
              ? Center(
                  child: SizedBox(
                    width: deviceWidth(context) / 1.1,
                    height: deviceWidth(context) * (25 / 44),
                    child: ShatteringWidget(
                      key: _shatteringKey,
                      builder: (shatter) => Stack(
                        children: [
                          // bomb
                          RiveAnimation.asset(
                            bomb.src,
                            artboard: bomb.artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveModel.getRiveController(artboard,
                                      stateMachineName: bomb.stateMachineName);
                              bomb.inputInt =
                                  controller.findSMI("numbers") as SMINumber;
                            },
                          ),
                          // timer
                          Positioned(
                            bottom: deviceWidth(context) / 5.5,
                            left: deviceWidth(context) / 2.3,
                            child: appText('$seconds', const Color(0xFF30A431),
                                deviceWidth(context) / 15, FontWeight.w500),
                          ),
                          // blue wire
                          Positioned(
                            left: deviceWidth(context) / 10,
                            top: deviceWidth(context) / 14,
                            child: GestureDetector(
                              onTap: () {
                                if (numCut < 2) {
                                  numCut++;
                                  wiresCut[0] = 1;
                                  bomb.inputInt!.change(1);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: deviceWidth(context) / 4.5,
                                height: deviceWidth(context) / 4.5,
                                color: AppColors.backgroundColor.withOpacity(0),
                              ),
                            ),
                          ),
                          // pink wire
                          Positioned(
                            left: deviceWidth(context) / 3.25,
                            top: deviceWidth(context) / 10,
                            child: GestureDetector(
                              onTap: () {
                                if (numCut < 2) {
                                  wiresCut[1] = 1;
                                  numCut++;
                                  bomb.inputInt!.change(5);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: deviceWidth(context) / 6,
                                height: deviceWidth(context) / 6,
                                color: AppColors.backgroundColor.withOpacity(0),
                              ),
                            ),
                          ),
                          // green wire
                          Positioned(
                            left: deviceWidth(context) / 1.6,
                            top: deviceWidth(context) / 8,
                            child: GestureDetector(
                              onTap: () {
                                if (numCut < 2) {
                                  wiresCut[3] = 1;
                                  numCut++;
                                  bomb.inputInt!.change(2);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: deviceWidth(context) / 7,
                                height: deviceWidth(context) / 6,
                                color: AppColors.backgroundColor.withOpacity(0),
                              ),
                            ),
                          ),
                          // yellow wire
                          Positioned(
                            left: deviceWidth(context) / 2.15,
                            top: deviceWidth(context) / 14,
                            child: GestureDetector(
                              onTap: () {
                                if (numCut < 2) {
                                  wiresCut[2] = 1;
                                  numCut++;
                                  bomb.inputInt!.change(4);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: deviceWidth(context) / 5.15,
                                height: deviceWidth(context) / 5,
                                color: AppColors.backgroundColor.withOpacity(0),
                              ),
                            ),
                          ),
                          // white wire
                          Positioned(
                            left: deviceWidth(context) / 1.3,
                            top: deviceWidth(context) / 5,
                            child: GestureDetector(
                              onTap: () {
                                if (numCut < 2) {
                                  numCut++;
                                  wiresCut[4] = 1;
                                  bomb.inputInt!.change(3);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: deviceWidth(context) / 7.75,
                                height: deviceWidth(context) / 5,
                                color: AppColors.backgroundColor.withOpacity(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onShatterCompleted: () {
                        isAlive = false;
                        setState(() {});
                        _timer = Timer(
                          const Duration(milliseconds: 100),
                          () {
                            setState(() {
                              _death.currentState!.start();
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox(),
          // death screen
          numCut < 2 || isAlive
              ? const SizedBox()
              : DeathScreen(
                  key: _death,
                  adButton: () {
                    checkAd();
                  },
                ),
        ],
      ),
    );
  }

  // Bomb timer
  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        if (seconds > 0) {
          if (numCut == 2) {
            _timer?.cancel();
            checkWires();
          } else {
            seconds = ((seconds * 10) - 1) / 10;
          }
        } else {
          _timer?.cancel();
          _shatteringKey.currentState!.shatter();
        }
      });
    });
  }

  // check wires cut
  void checkWires() {
    if ((wiresCut[0] == 1 && wiresCut[4] == 1) ||
        (wiresCut[2] == 1 && wiresCut[3] == 1)) {
      canGo = true;
      rightArrowOpacity = 1;
      leftArrowOpacity = 1;
    } else {
      _shatteringKey.currentState!.shatter();
    }
    setState(() {});
  }

  // invisible button
  SizedBox invisible() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Stack(
          children: [
                // blocker
                tapped[0] != 1
                    ? SafeArea(
                        bottom: false,
                        child: Row(
                          children: [
                            Container(
                              width: deviceWidth(context) / 4.575,
                              height: deviceWidth(context) * 225 / 1403,
                              color: AppColors.backgroundColor,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                // real button
                Positioned(
                  left: deviceWidth(context) / 2,
                  top: deviceHeight(context) / 4,
                  child: GestureDetector(
                    onTap: () {
                      if (!tapped.contains(1)) {
                        tapped[0] = 1;
                        rightArrowOpacity = 1;
                        leftArrowOpacity = 1;
                        headerOpacity = 1;
                        canGo = true;
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: deviceWidth(context) / 3,
                      height: deviceWidth(context) / 2.75,
                      color: AppColors.backgroundColor.withOpacity(0),
                      child: tapped[0] == 1
                          ? gameButton(
                              context,
                              AppColors.darkGrey,
                              AppColors.darkerGrey,
                              const Color(0xffE33333),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),
              ] +
              List.generate(
                10,
                (int index) => Positioned(
                  left: poistions[index].width,
                  top: poistions[index].height,
                  child: GestureDetector(
                    onTap: () {
                      if (!tapped.contains(1)) {
                        tapped[index + 1] = 1;
                        setState(() {});
                        _timer = Timer(const Duration(milliseconds: 250), () {
                          setState(() {
                            _death.currentState!.start();
                          });
                        });
                      }
                    },
                    child: Container(
                        width: deviceWidth(context) / 4,
                        height: deviceWidth(context) / 4,
                        color: AppColors.backgroundColor.withOpacity(0),
                        child: tapped[index + 1] == 1
                            ? flutter_image.Image.asset(
                                'lib/assets/images/section5/hidden_mine.png')
                            : const SizedBox()),
                  ),
                ),
              ) +
              [
                !tapped.contains(1) || tapped[0] == 1
                    ? const SizedBox()
                    : DeathScreen(
                        key: _death,
                        adButton: () {
                          checkAd();
                        },
                      ),
              ]),
    );
  }

  // its broken?
  SizedBox brokenLock() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // lock
          SizedBox(
            width: deviceWidth(context) / 1.1,
            child: flutter_image.Image.asset(
              'lib/assets/images/section5/brokenLock.png',
              fit: BoxFit.contain,
            ),
          ),
          // stick note
          chooseLeft == 1
              ? Positioned(
                  left: deviceWidth(context) / 6,
                  top: deviceHeight(context) / 3,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Stack(
                              children: [
                                // STICKY NOTE
                                Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'lib/assets/images/section5/opened_note.png'),
                                        fit: BoxFit.contain),
                                  ),
                                ),
                                // PASSWORD
                                Positioned(
                                  top: deviceHeight(context) / 3.25,
                                  left: deviceWidth(context) / 9,
                                  child: appText2(
                                      "PASSWORD: \n${tempPassword[0]}${tempPassword[1]}${tempPassword[2]}${tempPassword[3]}${tempPassword[4]}",
                                      AppColors.darkerGrey,
                                      deviceWidth(context) / 15,
                                      FontWeight.w500),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      color: AppColors.backgroundColor.withOpacity(0),
                      width: deviceWidth(context) / 3,
                      child: flutter_image.Image.asset(
                        'lib/assets/images/section5/closed_note.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  // SET PASSWORD
  void setPassword() {
    if (thePassword != null) {
      tempPassword = thePassword!;
    } else {
      for (int i = 0; i < 5; i++) {
        tempPassword.add(Random().nextInt(10));
      }
    }
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
                banner1: const Color(0xffAEFFDE),
                banner2: const Color(0xffE4F1FF),
                banner3: const Color(0xff333333),
                title: titles[currentPage],
                opacity: headerOpacity,
                numbers: allNumbers[currentPage + 28],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xffAEFFDE),
                arrow2: const Color(0xff333333),
                arrow3: const Color(0xffE4F1FF),
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
              whatLevel(),
              defuseDefuse(),
              invisible(),
              brokenLock(),
            ],
          )
        ],
      ),
    );
  }
}
