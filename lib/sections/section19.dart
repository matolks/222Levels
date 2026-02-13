import 'package:levels222_0/pages/home.dart';

class Section19 extends StatefulWidget {
  const Section19({super.key});

  @override
  State<Section19> createState() => _Section19State();
}

class _Section19State extends State<Section19> {
  // universal logic
  bool showHome = true;
  int currentPage = 0;
  int currentAdNum = 0;
  int adCap = 11;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;
  List<String> titles = [
    'What\'s A Cool Word?',
    'Escape!',
    'L[]-W[]rd',
    'Luck Wheel',
    'Doors Again...',
  ];

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
      updateAd(19, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(19, currentAdNum, adCap, showAd, context);
  }

  // Back arrow logic
  void backArrow() {
    if (currentPage == 0) {
      backSection(18, context);
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
    if (currentPage > 4) {
      nextSection(19, context);
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
                banner1: AppColors.lightGrey,
                banner2: AppColors.babyv,
                banner3: AppColors.babyv,
                title: titles[currentPage],
                opacity: 1,
                numbers: allNumber(currentPage + 127),
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: AppColors.babyv,
                arrow2: AppColors.lightGrey,
                arrow3: AppColors.babyv,
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // levels
          IndexedStack(
            children: <Widget>[],
          )
        ],
      ),
    );
  }
}
