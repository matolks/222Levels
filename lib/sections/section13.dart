import 'package:levels222_0/models/connectfour_model.dart';
import 'package:levels222_0/models/flappybird_model.dart';
import 'package:levels222_0/models/minesweeper_model.dart';
import 'package:levels222_0/models/pong_model.dart';
import 'package:levels222_0/models/snake_model.dart';
import 'package:levels222_0/models/tictactoe_model.dart';
import 'package:levels222_0/pages/home.dart';

class Section13 extends StatefulWidget {
  const Section13({super.key});

  @override
  State<Section13> createState() => _Section13State();
}

class _Section13State extends State<Section13> {
  // universal logic
  bool showHome = true;
  int currentPage = 0;
  int currentAdNum = 0;
  int adCap = 8;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;
  List<String> titles = [
    'Tic-tac-toe ',
    'Connect-4',
    'Minesweeper',
    'Pong',
    'Snake',
    'Flap Bird',
  ];

  @override
  void initState() {
    super.initState();
    loadAd();
    currentAdNum = box.get('currentAd');
  }

// connect four
  bool userTurn = true;

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
      updateAd(13, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(13, currentAdNum, adCap, showAd, context);
  }

  // Back arrow logic
  void backArrow() {
    if (currentPage == 0) {
      backSection(12, context);
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
    if (currentPage > 5) {
      nextSection(13, context);
    }
    setState(() {});
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
                banner1: const Color(0xff675c5a),
                banner2: const Color(0xffcdbca8),
                banner3: const Color.fromARGB(255, 88, 106, 123),
                title: titles[currentPage],
                opacity: 1,
                numbers: allNumbers[currentPage + 84],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xff675c5a),
                arrow2: const Color(0xffcdbca8),
                arrow3: const Color.fromARGB(255, 88, 106, 123),
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // levels
          IndexedStack(
            alignment: Alignment.center,
            index: currentPage,
            children: const <Widget>[
              TicTacToe(),
              ConnectFour(
                backgroundColor: Color.fromARGB(255, 88, 106, 123),
                chipColors: [
                  Color(0xffcdbca8),
                  Color(0xff675c5a),
                ],
              ),
              Minesweeper(),
              Pong(),
              Snake(
                snakeColor: Color(0xffcdbca8),
              ),
              Flappybird()
            ],
          )
        ],
      ),
    );
  }
}
