import 'package:levels222_0/models/door_model.dart';
import 'package:levels222_0/pages/home.dart';

class Section2 extends StatefulWidget {
  const Section2({super.key});

  @override
  State<Section2> createState() => _Section2State();
}

class _Section2State extends State<Section2> {
  // Universal Logic
  bool showHome = true;
  int currentPage = 0;
  List<String> titles = ["Pink Cow", "Choose a Door", "Monty Hall", "🐐?"];
  int currentAdNum = 0;
  int adCap = 3;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = 1;
  bool? canGo;
  // Pink Cow
  final GlobalKey<DoorModelState> door1 = GlobalKey<DoorModelState>();
  final GlobalKey<DoorModelState> door2 = GlobalKey<DoorModelState>();
  List<int> isDoorOpen = [0, 0];
  // Monty Hall
  bool isGuessing = false;
  bool isDone = false;
  final GlobalKey<DoorModelState> door3 = GlobalKey<DoorModelState>();
  final GlobalKey<DoorModelState> door4 = GlobalKey<DoorModelState>();
  final GlobalKey<DoorModelState> door5 = GlobalKey<DoorModelState>();
  List<int> whichDoor = [0, 0, 0];
  List<int> cyberTruck = [0, 1, 0];
  // Bon Bon
  bool hasPicked = false;

  @override
  void initState() {
    super.initState();
    loadAd();
    currentAdNum = box.get('currentAd') ?? 0;
  }

  @override
  void dispose() {
    videoAd?.dispose();
    super.dispose();
  }

  // Shows Ad and Updates Counter
  void showAd() {
    videoAd!.show();
    videoAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
      updateAd(2, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if add is needed
  void checkAd() {
    updateAttempt(2, currentAdNum, adCap, showAd, context);
  }

  // Back Arrow Logic
  void backArrow() {
    if (currentPage == 0) {
      backSection(1, context);
    } else if (!isGuessing) {
      if (currentPage == 1) {
        rightArrowOpacity = 1;
        showHome = true;
      }
      if (currentPage == 2) {
        rightArrowOpacity = 0;
      }
      if (currentPage == 3) {
        rightArrowOpacity = 1;
        canGo = true;
      }
      currentPage--;
      setState(() {});
    }
  }

  // Front Arrow Logic
  void frontArrow() {
    if (currentPage == 3 && canGo == true) {
      nextSection(2, context);
    } else if (currentPage == 0) {
      rightArrowOpacity = 0;
      currentPage++;
      showHome = false;
      setState(() {});
    } else if (canGo == true && currentPage > 1) {
      currentPage++;
      if (!hasPicked) {
        canGo = null;
        rightArrowOpacity = .2;
      }
      setState(() {});
    }
  }

  // Pink Cow
  SizedBox pinkCow() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: deviceWidth(context) / 1.1,
            child: Image.asset('lib/assets/images/section2/pink_cow.png'),
          ),
          Positioned(
            left: 0,
            top: deviceHeight(context) / 10,
            child: SafeArea(
              child: SizedBox(
                width: deviceWidth(context) / 6,
                child: Image.asset('lib/assets/images/section2/tacos.png'),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Pick a Door
  SizedBox pickADoor() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Column(
        children: [
          // doors
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 2.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // door 1
                GestureDetector(
                  onTap: () {
                    if (isDoorOpen[0] == 1) {
                      if (!isDone) {
                        cyberTruck.shuffle();
                      }
                      box.put('chooseLeft', 1);
                      currentPage++;
                      if (canGo == null) {
                        rightArrowOpacity = .2;
                      } else {
                        rightArrowOpacity = 1;
                      }
                    } else {
                      if (isDoorOpen[1] == 1) {
                        door2.currentState!.moveDoor(false);
                        isDoorOpen[1] = 0;
                      }
                      isDoorOpen[0] = 1;
                      door1.currentState!.moveDoor(true);
                    }
                    setState(() {});
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      rightArrow(
                          context,
                          AppColors.backgroundColor,
                          const Color(0xFFECC19C),
                          Colors.black,
                          const Color(0xFF1E847F),
                          1),
                      DoorModel(
                        doorSize: Size(deviceWidth(context) / 3.3,
                            deviceHeight(context) / 4.4),
                        key: door1,
                      ),
                    ],
                  ),
                ),
                // door 2
                GestureDetector(
                  onTap: () {
                    if (isDoorOpen[1] == 1) {
                      if (!isDone) {
                        cyberTruck.shuffle();
                      }
                      box.put('chooseLeft', 0);
                      currentPage++;
                      if (canGo == null) {
                        rightArrowOpacity = .2;
                      } else {
                        rightArrowOpacity = 1;
                      }
                    } else {
                      if (isDoorOpen[0] == 1) {
                        door1.currentState!.moveDoor(false);
                        isDoorOpen[0] = 0;
                      }
                      isDoorOpen[1] = 1;
                      door2.currentState!.moveDoor(true);
                    }
                    setState(() {});
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      rightArrow(
                          context,
                          AppColors.backgroundColor,
                          const Color(0xFFECC19C),
                          Colors.black,
                          const Color(0xFF1E847F),
                          1),
                      DoorModel(
                        doorSize: Size(deviceWidth(context) / 3.3,
                            deviceHeight(context) / 4.4),
                        key: door2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // text
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight(context) / 40,
                right: deviceWidth(context) / 25),
            child: appText2('This may matter', AppColors.darkGrey,
                deviceWidth(context) / 28, FontWeight.w400),
          ),
        ],
      ),
    );
  }

  // Monty Hall
  SizedBox montyHall() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Column(
        children: [
          // winning text
          SizedBox(
            width: deviceWidth(context),
            height: deviceHeight(context) / 2.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: deviceHeight(context) / 15),
                  child: canGo == null
                      ? appText(
                          !isGuessing ? 'Pick a door' : 'Keep or Switch?',
                          AppColors.lightGrey,
                          deviceWidth(context) / 18,
                          FontWeight.w400)
                      : appText(
                          canGo! ? 'Winner!\nThank You Mr. Musk!' : 'Loser!',
                          AppColors.lightGrey,
                          deviceWidth(context) / 18,
                          FontWeight.w400),
                ),
              ],
            ),
          ),
          // doors
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // door 1
              GestureDetector(
                onTap: () {
                  if (!isGuessing && !isDone) {
                    isGuessing = true;
                    whichDoor[0] = 1;
                    leftArrowOpacity = .2;
                    if (cyberTruck[2] == 1) {
                      door4.currentState!.moveDoor(true);
                      whichDoor[1] = 2;
                    } else {
                      door5.currentState!.moveDoor(true);
                      whichDoor[2] = 2;
                    }
                    setState(() {});
                  }
                },
                child: Container(
                  width: deviceWidth(context) / 3.3,
                  height: deviceHeight(context) / 5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: whichDoor[0] == 1
                          ? const Color(0xffFFD700)
                          : AppColors.backgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      SizedBox(
                        width: deviceWidth(context) / 4,
                        child: Image.asset(cyberTruck[0] == 1
                            ? 'lib/assets/images/section2/cybertruck.png'
                            : 'lib/assets/images/section2/goat.png'),
                      ),
                      DoorModel(
                        doorSize: Size(deviceWidth(context) / 3.9,
                            deviceHeight(context) / 5.2),
                        key: door3,
                      ),
                    ],
                  ),
                ),
              ),
              // door 2
              GestureDetector(
                onTap: () {
                  if (!isGuessing && !isDone) {
                    isGuessing = true;
                    whichDoor[1] = 1;
                    leftArrowOpacity = .2;
                    if (cyberTruck[2] == 1) {
                      door3.currentState!.moveDoor(true);
                      whichDoor[0] = 2;
                    } else {
                      door5.currentState!.moveDoor(true);
                      whichDoor[2] = 2;
                    }
                    setState(() {});
                  }
                },
                child: Container(
                  width: deviceWidth(context) / 3.3,
                  height: deviceHeight(context) / 5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.3,
                      color: whichDoor[1] == 1
                          ? const Color(0xffFFD700)
                          : AppColors.backgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      SizedBox(
                        width: deviceWidth(context) / 4,
                        child: Image.asset(cyberTruck[1] == 1
                            ? 'lib/assets/images/section2/cybertruck.png'
                            : 'lib/assets/images/section2/goat.png'),
                      ),
                      DoorModel(
                        doorSize: Size(deviceWidth(context) / 3.9,
                            deviceHeight(context) / 5.2),
                        key: door4,
                      ),
                    ],
                  ),
                ),
              ),
              // door 3
              GestureDetector(
                onTap: () {
                  if (!isGuessing && !isDone) {
                    isGuessing = true;
                    whichDoor[2] = 1;
                    leftArrowOpacity = .2;
                    if (cyberTruck[1] == 1) {
                      door3.currentState!.moveDoor(true);
                      whichDoor[0] = 2;
                    } else {
                      door4.currentState!.moveDoor(true);
                      whichDoor[1] = 2;
                    }
                    setState(() {});
                  }
                },
                child: Container(
                  width: deviceWidth(context) / 3.3,
                  height: deviceHeight(context) / 5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: whichDoor[2] == 1
                          ? const Color(0xffFFD700)
                          : AppColors.backgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      SizedBox(
                        width: deviceWidth(context) / 4,
                        child: Image.asset(cyberTruck[2] == 1
                            ? 'lib/assets/images/section2/cybertruck.png'
                            : 'lib/assets/images/section2/goat.png'),
                      ),
                      DoorModel(
                        doorSize: Size(deviceWidth(context) / 3.9,
                            deviceHeight(context) / 5.2),
                        key: door5,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // Keep
          isGuessing && canGo == null
              ? Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 20),
                  child: GestureDetector(
                    onTap: () {
                      if (whichDoor.indexOf(1) == cyberTruck.indexOf(1)) {
                        isGuessing = false;
                        canGo = true;
                        rightArrowOpacity = 1;
                        leftArrowOpacity = 1;
                      } else {
                        canGo = false;
                      }
                      isDone = true;
                      door3.currentState!.moveDoor(true);
                      door4.currentState!.moveDoor(true);
                      door5.currentState!.moveDoor(true);
                      setState(() {});
                    },
                    child: button(
                        context,
                        const Color(0xFFECC19C),
                        Colors.black,
                        const Color(0xFF1E847F),
                        'Keep Door?',
                        AppColors.lightGrey,
                        null),
                  ),
                )
              : const SizedBox(),
          // Switch
          isGuessing && canGo == null
              ? Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 20),
                  child: GestureDetector(
                    onTap: () {
                      if (whichDoor.indexOf(1) != cyberTruck.indexOf(1)) {
                        canGo = true;
                        isGuessing = false;
                        rightArrowOpacity = 1;
                        leftArrowOpacity = 1;
                      } else {
                        canGo = false;
                      }
                      if (whichDoor.indexOf(2) == 0) {
                        int temp = whichDoor[1];
                        whichDoor[1] = whichDoor[2];
                        whichDoor[2] = temp;
                      } else if (whichDoor.indexOf(2) == 1) {
                        int temp = whichDoor[0];
                        whichDoor[0] = whichDoor[2];
                        whichDoor[2] = temp;
                      } else {
                        int temp = whichDoor[1];
                        whichDoor[1] = whichDoor[0];
                        whichDoor[0] = temp;
                      }
                      isDone = true;
                      door3.currentState!.moveDoor(true);
                      door4.currentState!.moveDoor(true);
                      door5.currentState!.moveDoor(true);
                      setState(() {});
                    },
                    child: button(
                        context,
                        const Color(0xFFECC19C),
                        Colors.black,
                        const Color(0xFF1E847F),
                        'Switch Door?',
                        AppColors.lightGrey,
                        null),
                  ),
                )
              : const SizedBox(),
          canGo != null && canGo == false
              ? Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 16),
                  child: GestureDetector(
                    onTap: () {
                      checkAd();
                    },
                    child: button(
                        context,
                        const Color(0xFFECC19C),
                        Colors.black,
                        const Color(0xFF1E847F),
                        '👈 Back to the Cow',
                        AppColors.lightGrey,
                        null),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  // Whos the Goat
  SizedBox whosTheGoat() {
    return SizedBox(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Column(
        children: [
          // Text
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 4),
            child: SizedBox(
              width: deviceWidth(context) / 1.2,
              child: appText(
                  canGo == null
                      ? 'Who is the absolute, undisputed 🐐 of basketball?'
                      : canGo == true
                          ? "Correct!\nYou got ball knowledge 🧠👈"
                          : "Wrong\nYou got no ball knowledge",
                  AppColors.lightGrey,
                  deviceWidth(context) / 18,
                  FontWeight.w400),
            ),
          ),
          // Bron
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 10),
            child: GestureDetector(
              onTap: () {
                if (!hasPicked) {
                  canGo = true;
                  hasPicked = true;
                  rightArrowOpacity = 1;
                  setState(() {});
                }
              },
              child: button(
                  context,
                  canGo == true ? AppColors.lightGrey : AppColors.middleGrey,
                  canGo == true
                      ? AppColors.lightGrey
                      : AppColors.backgroundColor,
                  canGo == true
                      ? const Color(0xff30A431)
                      : AppColors.backgroundColor,
                  'LeBron James',
                  canGo == true ? AppColors.lightGrey : AppColors.middleGrey,
                  null),
            ),
          ),
          // MJ
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 18),
            child: GestureDetector(
              onTap: () {
                if (!hasPicked) {
                  canGo = false;
                  hasPicked = true;
                  isGuessing = true;
                  leftArrowOpacity = .2;
                  setState(() {});
                }
              },
              child: button(
                  context,
                  canGo == false ? AppColors.lightGrey : AppColors.middleGrey,
                  canGo == false
                      ? AppColors.lightGrey
                      : AppColors.backgroundColor,
                  canGo == false
                      ? const Color(0xffE33333)
                      : AppColors.backgroundColor,
                  'Michael Jordan',
                  canGo == false ? AppColors.lightGrey : AppColors.middleGrey,
                  null),
            ),
          ),
          // return button
          canGo != null && canGo == false
              ? Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 12),
                  child: GestureDetector(
                    onTap: () {
                      checkAd();
                    },
                    child: button(
                        context,
                        const Color(0xFFECC19C),
                        Colors.black,
                        const Color(0xFF1E847F),
                        '👈 Back to the Cow',
                        AppColors.lightGrey,
                        null),
                  ),
                )
              : const SizedBox()
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
          // TOP BAR && ARROWS
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(
                home: showHome,
                banner1: const Color(0xFFECC19C),
                banner2: Colors.black,
                banner3: const Color(0xFF1E847F),
                title: titles[currentPage],
                opacity: 1,
                numbers: allNumbers[currentPage + 8],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xFFECC19C),
                arrow2: Colors.black,
                arrow3: const Color(0xFF1E847F),
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // LEVELS
          IndexedStack(
            index: currentPage,
            children: <Widget>[
              pinkCow(),
              pickADoor(),
              montyHall(),
              whosTheGoat(),
            ],
          )
        ],
      ),
    );
  }
}
