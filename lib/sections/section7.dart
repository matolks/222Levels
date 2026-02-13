import 'package:flip_card/flip_card.dart';
import 'package:levels222_0/pages/home.dart';

class Section7 extends StatefulWidget {
  const Section7({super.key});

  @override
  State<Section7> createState() => _Section7State();
}

class _Section7State extends State<Section7> {
  bool showHome = true;
  int currentPage = 0;
  int currentAdNum = 0;
  int adCap = 5;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;
  List<int> numTiles = [4, 12, 16, 24, 0];
  List<int> gridWidth = [2, 3, 4, 4];
  late List<double> iconSize = [
    deviceWidth(context) / 2,
    deviceWidth(context) / 3.5,
    deviceWidth(context) / 3.5,
    deviceWidth(context) / 5,
    deviceWidth(context) / 5,
  ];
  List<GlobalKey<FlipCardState>> _flipCardKeys =
      List.generate(48, (_) => GlobalKey<FlipCardState>());
  List<IconData> icons = [
    Icons.psychology,
    Icons.insert_emoticon_sharp,
    Icons.spa,
    Icons.cabin,
    Icons.access_alarm,
    Icons.ac_unit,
    Icons.currency_bitcoin,
    Icons.self_improvement,
    Icons.headphones,
    Icons.factory,
    Icons.propane_tank,
    Icons.face_retouching_natural,
    Icons.dangerous,
    Icons.cable,
    Icons.wallet,
    Icons.model_training,
    Icons.wash,
    Icons.water_drop,
    Icons.water,
    Icons.table_restaurant,
    Icons.umbrella,
    Icons.ice_skating,
    Icons.oil_barrel_outlined,
    Icons.gavel
  ];
  List<Color> colors = [
    const Color(0xfff2c864),
    const Color(0xff08bbd7),
    const Color(0xff0b4251),
    const Color.fromARGB(255, 143, 189, 227),
    const Color.fromARGB(255, 82, 204, 86),
    const Color.fromARGB(255, 213, 10, 152),
    const Color.fromARGB(255, 246, 246, 246),
    const Color.fromARGB(255, 117, 98, 193),
    const Color.fromARGB(255, 184, 72, 92),
    const Color.fromARGB(255, 0, 0, 0),
    const Color.fromARGB(255, 252, 134, 0),
    const Color.fromARGB(255, 15, 197, 140),
    const Color.fromARGB(255, 60, 24, 168),
    const Color.fromARGB(255, 225, 255, 0),
    const Color.fromARGB(255, 52, 171, 25),
    const Color.fromARGB(255, 82, 36, 131),
    const Color.fromARGB(255, 139, 79, 79),
    const Color.fromARGB(255, 39, 46, 120),
    const Color.fromARGB(255, 68, 0, 0),
    const Color.fromARGB(255, 195, 54, 255),
    const Color.fromARGB(255, 116, 141, 148),
    const Color.fromARGB(255, 102, 87, 53),
    const Color.fromARGB(255, 26, 93, 4),
    const Color.fromARGB(255, 119, 177, 31),
  ];
  late List<IconData> currentSet = [];
  int numTapped = 0;
  List<List<int>> tappedIndex = [];
  List<int> key1Indexs = [];

  @override
  void initState() {
    super.initState();
    loadAd();
    currentAdNum = box.get('currentAd');
    reset();
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
      updateAd(7, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(7, currentAdNum, adCap, showAd, context);
  }

  // Back arrow logic
  void backArrow() {
    if (currentPage == 0) {
      backSection(6, context);
    } else {
      showHome = true;
      currentPage--;
      reset();
      setState(() {});
    }
  }

  // Front arrow logic
  void frontArrow() {
    currentPage++;
    setState(() {});
    if (currentPage == 4) {
      nextSection(7, context);
    } else {
      reset();
    }
    showHome = false;
    setState(() {});
  }

  void reset() {
    numTapped = 0;
    tappedIndex = [];
    key1Indexs = [];
    currentSet = [];
    icons.shuffle();
    colors.shuffle();
    _flipCardKeys = List.generate(48, (_) => GlobalKey<FlipCardState>());
    for (int i = 0; i < (numTiles[currentPage]) / 2; i++) {
      currentSet.add(icons[i]);
      currentSet.add(icons[i]);
    }
    currentSet.shuffle();
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
                banner1: const Color(0xfff2c864),
                banner2: const Color(0xff08bbd7),
                banner3: const Color(0xff0b4251),
                title: "Memory",
                opacity: 1,
                numbers: allNumbers[currentPage + 40],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xfff2c864),
                arrow2: const Color(0xff08bbd7),
                arrow3: const Color(0xff0b4251),
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // levels
          Center(
            child: GridView.builder(
              shrinkWrap: true,
              padding:
                  EdgeInsets.symmetric(horizontal: deviceWidth(context) / 15),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridWidth[currentPage],
                crossAxisSpacing: deviceWidth(context) / 35,
                mainAxisSpacing: deviceWidth(context) / 35,
              ),
              itemCount: numTiles[currentPage],
              itemBuilder: (context, index) {
                int adder = 0;
                IconData currentIcon = currentSet.removeLast();
                int colorIndex = icons.indexOf(currentIcon);
                if (key1Indexs.contains(colorIndex)) {
                  adder = 24;
                } else {
                  key1Indexs.add(colorIndex);
                }
                return FlipCard(
                  key: _flipCardKeys[colorIndex + adder],
                  flipOnTouch: false,
                  direction: FlipDirection.VERTICAL,
                  front: GestureDetector(
                    onTap: () async {
                      if (tappedIndex.isEmpty) {
                        if (adder == 24) {
                          _flipCardKeys[colorIndex + 24]
                              .currentState
                              ?.toggleCard();
                          tappedIndex.add([colorIndex, colorIndex + 24]);
                        } else {
                          _flipCardKeys[colorIndex].currentState?.toggleCard();
                          tappedIndex.add([colorIndex, colorIndex]);
                        }
                      } else if (tappedIndex.length == 1) {
                        if (adder == 24) {
                          _flipCardKeys[colorIndex + 24]
                              .currentState
                              ?.toggleCard();
                          tappedIndex.add([colorIndex, colorIndex + 24]);
                        } else {
                          _flipCardKeys[colorIndex].currentState?.toggleCard();
                          tappedIndex.add([colorIndex, colorIndex]);
                        }
                        if (tappedIndex[0][0] != colorIndex) {
                          await Future.delayed(const Duration(seconds: 1), () {
                            _flipCardKeys[tappedIndex[0][1]]
                                .currentState
                                ?.toggleCard();
                            _flipCardKeys[tappedIndex[1][1]]
                                .currentState
                                ?.toggleCard();
                          });
                        }
                        tappedIndex = [];
                      }
                    },
                    child: MemTile(
                      icon: null,
                      color: AppColors.babyv,
                      width: deviceWidth(context) / 3,
                    ),
                  ),
                  back: MemTile(
                    icon: currentIcon,
                    color: colors[colorIndex],
                    width: iconSize[currentPage],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class MemTile extends StatelessWidget {
  final IconData? icon;
  final Color color;
  final double width;
  const MemTile({
    super.key,
    required this.icon,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
          color: AppColors.darkerGrey,
          borderRadius: BorderRadius.circular(width * .1)),
      child: Center(
        child: icon == null
            ? const SizedBox()
            : Icon(
                icon,
                color: color,
                size: width * .5,
              ),
      ),
    );
  }
}
