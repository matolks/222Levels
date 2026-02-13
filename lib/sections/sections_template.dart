import 'package:levels222_0/pages/home.dart';

class Template extends StatefulWidget {
  const Template({super.key});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  // universal logic
  bool showHome = true;
  int currentPage = 0;
  int currentAdNum = 0;
  int adCap = 3;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;
  List<String> titles = ['', '', '', '', '', '', '', ''];

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
      updateAd(2, currentAdNum, context); // input is current section #
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(
        1, currentAdNum, adCap, showAd, context); // input is current section #
  }

  // Back arrow logic
  void backArrow() {
    if (currentPage == 0) {
      backSection(1, context); // input is to the section #
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
    if (currentPage > 10) {
      nextSection(
          1, context); // current section input and sends to the next section
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
                title: "Brain Rot Quiz",
                opacity: 1,
                numbers: allNumber(currentPage + 1),
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
