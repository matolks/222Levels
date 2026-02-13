import 'dart:async';
import 'dart:math';

import 'package:levels222_0/pages/home.dart';

class Section11 extends StatefulWidget {
  const Section11({super.key});

  @override
  State<Section11> createState() => _Section11State();
}

class _Section11State extends State<Section11> {
  // universal logic
  bool showHome = true;
  int currentPage = 0;
  int currentAdNum = 0;
  int adCap = 7;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;
  List<String> titles = [
    'Get moving',
    'On the double',
    'Act now',
    'Pick up the pace',
    'Push forward',
    'Step on it',
    'Time\'s ticking',
    'Off you go',
    'Race against time',
    'Every second counts',
    'Fast Enough?'
  ];
  double alignX = 0;
  double alignY = 0;
  Timer? _timer;
  double seconds = 0;
  bool fastEnough = false;

  @override
  void initState() {
    super.initState();
    loadAd();
    changeLocation();
    startTimer();
    currentAdNum = box.get('currentAd');
  }

  @override
  void dispose() {
    videoAd?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // Shows Ad and Updates Counter
  void showAd() {
    videoAd!.show();
    videoAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
      updateAd(11, currentAdNum, context); // input is current section #
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(11, currentAdNum, adCap, showAd, context);
  }

  // Back arrow logic
  void backArrow() {
    if (currentPage == 0) {
      backSection(10, context);
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
      nextSection(11, context);
    }
    setState(() {});
  }

  // changes target location - need to ajust
  void changeLocation() {
    Random random = Random();
    alignX = (random.nextDouble() * 2) - 1;
    alignY = (random.nextDouble() * 2) - 1;
    currentPage++;
    if (currentPage == 10) {
      cancelTimer();
    }
    setState(() {});
  }

  // START TIMER
  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        seconds = ((seconds * 10) + 1) / 10;
      });
    });
  }

  // CANCEL TIMER && CHECK TIME
  void cancelTimer() {
    _timer?.cancel();
    if (seconds <= 3.9) {
      fastEnough = true;
    }
  }

  // Fast Enough? - add the initialism queue
  Column didYouPass() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TIME
        SizedBox(
          width: deviceWidth(context),
          child: appText("$seconds s", AppColors.lightGrey,
              deviceWidth(context) / 10, FontWeight.w700),
        ),
        // TEXT
        Padding(
          padding: EdgeInsets.fromLTRB(0, deviceHeight(context) / 12, 0, 0),
          child: SizedBox(
            width: deviceWidth(context),
            child: appText(
                fastEnough
                    ? "  Perfect amount of time IMO...\n too long some would say"
                    : "Damn you slow \n try again",
                AppColors.lightGrey,
                deviceWidth(context) / 18,
                FontWeight.w700),
          ),
        ),
        // TRY AGAIN BUTTON
        fastEnough
            ? const SizedBox()
            : Padding(
                padding: EdgeInsets.only(
                  top: deviceHeight(context) / 8,
                ),
                child: GestureDetector(
                    onTap: () {},
                    child: button(
                        context,
                        const Color(0xff6f9bd1),
                        const Color(0xffdf3c5f),
                        const Color(0xff6f9bd1),
                        'Try Again',
                        const Color(0xffdf3c5f),
                        null)),
              ),
      ],
    );
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
                banner1: const Color(0xffdf3c5f),
                banner2: const Color(0xff6f9bd1),
                banner3: const Color(0xff6f9bd1),
                title: titles[currentPage],
                opacity: 1,
                numbers: allNumbers[currentPage + 64],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xff6f9bd1),
                arrow2: const Color(0xffdf3c5f),
                arrow3: const Color(0xff6f9bd1),
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // levels
          currentPage < 10
              ? Center(
                  child: SizedBox(
                    width: deviceWidth(context),
                    height: deviceHeight(context) * .7,
                    child: Align(
                      alignment: Alignment(alignX, alignY),
                      child: GestureDetector(
                        onTap: () {
                          changeLocation();
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: deviceWidth(context) / 4.5,
                          height: deviceWidth(context) / 4.5,
                          child: CustomPaint(
                            painter: Target(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : // final page
              didYouPass()
        ],
      ),
    );
  }
}

class Target extends CustomPainter {
  Target({
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paint = Paint()
      ..color = const Color(0xffdf3c5f)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color.fromARGB(255, 239, 239, 239)
      ..style = PaintingStyle.fill;

    final path = Path();
    final path2 = Path();
    final path3 = Path();
    path.moveTo(0, size.height * .5);
    path.arcToPoint(
      Offset(size.width, size.height * .5),
      radius: const Radius.circular(.1),
    );
    path.arcToPoint(
      Offset(0, size.height * .5),
      radius: const Radius.circular(.1),
    );
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, fillStroke);

    path2.moveTo(size.width * .2, size.height * .5);
    path2.arcToPoint(
      Offset(size.width * .8, size.height * .5),
      radius: const Radius.circular(.1),
    );
    path2.arcToPoint(
      Offset(size.width * .2, size.height * .5),
      radius: const Radius.circular(.1),
    );
    path2.close();
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path2, fillStroke);

    path3.moveTo(size.width * .35, size.height * .5);
    path3.arcToPoint(
      Offset(size.width * .65, size.height * .5),
      radius: const Radius.circular(.1),
    );
    path3.arcToPoint(
      Offset(size.width * .35, size.height * .5),
      radius: const Radius.circular(.1),
    );
    path3.close();
    canvas.drawPath(path3, paint);
    canvas.drawPath(path3, fillStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
