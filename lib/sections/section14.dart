import 'package:levels222_0/models/keyboard.dart';
import 'package:levels222_0/pages/home.dart';

class Section14 extends StatefulWidget {
  const Section14({super.key});

  @override
  State<Section14> createState() => _Section14State();
}

class _Section14State extends State<Section14> {
  // universal logic
  bool showHome = true;
  int currentPage = 0;
  int currentAdNum = 0;
  int adCap = 9;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;

  @override
  void initState() {
    super.initState();
    loadAd();
    currentAdNum = box.get('currentAd');
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
      updateAd(14, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(14, currentAdNum, adCap, showAd, context);
  }

  // Back arrow logic
  void backArrow() {
    if (currentPage == 0) {
      backSection(13, context);
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
      nextSection(
          14, context); // current section input and sends to the next section
    }
    setState(() {});
  }

  void onKeyTapped(letter) {}

  void onDeleteTapped() {}

  void onEnterTapped() {}

  void onSpaceTapped() {}

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
                banner1: const Color(0xff009990),
                banner2: const Color(0xffe1ffbb),
                banner3: const Color.fromARGB(255, 157, 179, 129),
                title: "Decipher",
                opacity: 1,
                numbers: allNumber(currentPage + 90),
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xff009990),
                arrow2: const Color(0xffe1ffbb),
                arrow3: const Color.fromARGB(255, 157, 179, 129),
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // levels
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              SizedBox(
                height:
                    deviceHeight(context) * .47 - (deviceWidth(context) / 2),
                child: Image.asset(
                  'lib/assets/images/section12/character.png',
                  fit: BoxFit.contain,
                ),
              ),
              // box
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: deviceHeight(context) * .03),
                child: Container(
                  width: deviceWidth(context) * .95,
                  height: deviceHeight(context) * .2,
                  decoration: BoxDecoration(
                      color: AppColors.darkerGrey,
                      borderRadius:
                          BorderRadius.circular(deviceWidth(context) * .05)),
                ),
              ),
              Keyboard(
                onKeyTapped: onKeyTapped,
                onDeleteTapped: onDeleteTapped,
                onEnterTapped: onEnterTapped,
                isWordle: false,
                onSpaceTapped: onSpaceTapped,
                backgroundColor: const Color.fromARGB(255, 157, 179, 129),
                textColor: const Color(0xffe1ffbb),
              )
            ],
          )
        ],
      ),
    );
  }
}
