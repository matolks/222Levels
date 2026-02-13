import 'package:levels222_0/models/shattering_widget.dart';
import 'package:levels222_0/pages/home.dart';

class Section8 extends StatefulWidget {
  const Section8({super.key});

  @override
  State<Section8> createState() => _Section8State();
}

// should add back arrow to start

class _Section8State extends State<Section8> with TickerProviderStateMixin {
  bool showHome = true;
  int currentPage = 0; // 0-7  (8 pages)
  int currentAdNum = 0;
  int adCap = 6;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;
  late AnimationController controller;
  late AnimationController controller2;
  final GlobalKey<ShatteringWidgetState> _shatteringKeyL =
      GlobalKey<ShatteringWidgetState>();
  final GlobalKey<ShatteringWidgetState> _shatteringKeyR =
      GlobalKey<ShatteringWidgetState>();
  // first visible
  Animation<double>? adj11;
  Animation<double>? adj12;
  Animation<Size>? sz1;
  Animation<Alignment>? alm1L;
  Animation<Alignment>? alm1R;
  // first visible
  Animation<double>? adj21;
  Animation<double>? adj22;
  Animation<Size>? sz2;
  Animation<Alignment>? alm2L;
  Animation<Alignment>? alm2R;
  // back
  Animation<double>? adj31;
  Animation<double>? adj32;
  Animation<Size>? sz3;
  Animation<Alignment>? alm3L;
  Animation<Alignment>? alm3R;
  // middle
  Animation<double>? adj41;
  Animation<double>? adj42;
  Animation<Size>? sz4;
  Animation<Alignment>? alm4L;
  Animation<Alignment>? alm4R;
  // current
  Animation<double>? adj51;
  Animation<double>? adj52;
  Animation<Size>? sz5;
  Animation<Alignment>? alm5L;
  Animation<Alignment>? alm5R;
  // front
  Animation<double>? adj61;
  Animation<double>? adj62;
  Animation<Size>? sz6;
  Animation<Alignment>? alm6L;
  Animation<Alignment>? alm6R;
  Animation<double>? hiddenOne;
  // ending platform
  Animation<double>? adjPlat;
  Animation<Size>? szPlat;
  Animation<double>? almPlat;

  List<List<double>> adjustments = [
    [.06, .99],
    [.1, .97],
    [.125, .96],
    [.175, .945],
    [.25, .925],
    [.2, .925],
    [.2, .925],
  ];
  late List<Size> sizes = [
    Size(
      deviceWidth(context) / 4.5,
      deviceHeight(context) / 100,
    ),
    Size(
      deviceWidth(context) / 4.1,
      deviceHeight(context) / 45,
    ),
    Size(
      deviceWidth(context) / 3.6,
      deviceHeight(context) / 30,
    ),
    Size(
      deviceWidth(context) / 2.975,
      deviceHeight(context) / 17,
    ),
    Size(
      deviceWidth(context) / 2.25,
      deviceHeight(context) / 10,
    ),
    Size(
      deviceWidth(context) / 1.95,
      deviceHeight(context) / 10,
    ),
    Size(
      deviceWidth(context) / 1.95,
      deviceHeight(context) / 10,
    ),
  ];
  List<Alignment> alignmentsLeft = [
    const Alignment(-.29, .165),
    const Alignment(-.33, .21),
    const Alignment(-.42, .295),
    const Alignment(-.59, .45),
    const Alignment(-1, .75),
    const Alignment(-1.5, 1.175),
    const Alignment(-1.7, 1.275),
  ];
  List<Alignment> alignmentsRight = [
    const Alignment(.29, .165),
    const Alignment(.33, .21),
    const Alignment(.42, .295),
    const Alignment(.59, .45),
    const Alignment(1, .75),
    const Alignment(1.5, 1.175),
    const Alignment(1.7, 1.275),
  ];

  @override
  void initState() {
    super.initState();
    loadAd();
    currentAdNum = box.get('currentAd');
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    controller.addListener(() {
      setState(() {
        if (controller.isCompleted && currentPage < 7) {
          controller.reset();
          if (currentPage > 3) {
            controller2.stop();
          }
          currentPage++;
        }
      });
    });
    controller2 = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    adj11 = Tween<double>(
      begin: adjustments[0][0],
      end: adjustments[1][0],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    adj12 = Tween<double>(
      begin: adjustments[0][1],
      end: adjustments[1][1],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    sz1 = Tween<Size>(
      begin: sizes[0],
      end: sizes[1],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm1L = Tween<Alignment>(
      begin: alignmentsLeft[0],
      end: alignmentsLeft[1],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm1R = Tween<Alignment>(
      begin: alignmentsRight[0],
      end: alignmentsRight[1],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );

    adj21 = Tween<double>(
      begin: adjustments[1][0],
      end: adjustments[2][0],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    adj22 = Tween<double>(
      begin: adjustments[1][1],
      end: adjustments[2][1],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    sz2 = Tween<Size>(
      begin: sizes[1],
      end: sizes[2],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm2L = Tween<Alignment>(
      begin: alignmentsLeft[1],
      end: alignmentsLeft[2],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm2R = Tween<Alignment>(
      begin: alignmentsRight[1],
      end: alignmentsRight[2],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );

    adj31 = Tween<double>(
      begin: adjustments[2][0],
      end: adjustments[3][0],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    adj32 = Tween<double>(
      begin: adjustments[2][1],
      end: adjustments[3][1],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    sz3 = Tween<Size>(
      begin: sizes[2],
      end: sizes[3],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm3L = Tween<Alignment>(
      begin: alignmentsLeft[2],
      end: alignmentsLeft[3],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm3R = Tween<Alignment>(
      begin: alignmentsRight[2],
      end: alignmentsRight[3],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );

    adj41 = Tween<double>(
      begin: adjustments[3][0],
      end: adjustments[4][0],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    adj42 = Tween<double>(
      begin: adjustments[3][1],
      end: adjustments[4][1],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    sz4 = Tween<Size>(
      begin: sizes[3],
      end: sizes[4],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm4L = Tween<Alignment>(
      begin: alignmentsLeft[3],
      end: alignmentsLeft[4],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm4R = Tween<Alignment>(
      begin: alignmentsRight[3],
      end: alignmentsRight[4],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );

    adj51 = Tween<double>(
      begin: adjustments[4][0],
      end: adjustments[5][0],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    adj52 = Tween<double>(
      begin: adjustments[4][1],
      end: adjustments[5][1],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    sz5 = Tween<Size>(
      begin: sizes[4],
      end: sizes[5],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm5L = Tween<Alignment>(
      begin: alignmentsLeft[4],
      end: alignmentsLeft[5],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm5R = Tween<Alignment>(
      begin: alignmentsRight[4],
      end: alignmentsRight[5],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );

    adj61 = Tween<double>(
      begin: adjustments[5][0],
      end: adjustments[6][0],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    adj62 = Tween<double>(
      begin: adjustments[5][1],
      end: adjustments[6][1],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    sz6 = Tween<Size>(
      begin: sizes[5],
      end: sizes[6],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm6L = Tween<Alignment>(
      begin: alignmentsLeft[5],
      end: alignmentsLeft[6],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    alm6R = Tween<Alignment>(
      begin: alignmentsRight[5],
      end: alignmentsRight[6],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    hiddenOne = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInExpo),
    );

    adjPlat = Tween<double>(
      begin: .06,
      end: .04,
    ).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.linear,
      ),
    );
    szPlat = Tween<Size>(
      begin: Size(
        deviceWidth(context) / 2.5,
        deviceHeight(context) / 50,
      ),
      end: Size(
        deviceWidth(context) / 1.1,
        deviceHeight(context) / 10,
      ),
    ).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.linear,
      ),
    );
    almPlat = Tween<double>(
      begin: .2,
      end: .8,
    ).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.linear,
      ),
    );

    super.didChangeDependencies();
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
      updateAd(8, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(8, currentAdNum, adCap, showAd, context);
  }

  // Back arrow logic // not used rn
  void backArrow() {
    if (currentPage == 0) {
      backSection(7, context);
    } else {
      showHome = true;
      currentPage--;
      setState(() {});
    }
  }

  // Front arrow logic // not used rn
  void frontArrow() {
    currentPage++;
    showHome = false;
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
                banner1: const Color(0xffed1b76),
                banner2: const Color(0xff037a76),
                banner3: const Color(0xff037a76),
                title: "Death Bridge",
                opacity: 1,
                numbers: allNumbers[currentPage + 44],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
            ],
          ),
          // TILES
          // front -> gone
          currentPage > 0
              ? Align(
                  alignment: alm6L?.value ?? const Alignment(0, 0),
                  child: SizedBox(
                    width: sz6?.value.width ?? 0,
                    height: sz6?.value.height ?? 0,
                    child: CustomPaint(
                      painter: Platform(
                          isLeft: true,
                          adjustments: [adj61?.value ?? 0, adj62?.value ?? 0]),
                    ),
                  ),
                )
              : const SizedBox(),
          currentPage > 0
              ? Align(
                  alignment: alm6R?.value ?? const Alignment(0, 0),
                  child: SizedBox(
                    width: sz6?.value.width ?? 0,
                    height: sz6?.value.height ?? 0,
                    child: CustomPaint(
                      painter: Platform(
                          isLeft: false,
                          adjustments: [adj61?.value ?? 0, adj62?.value ?? 0]),
                    ),
                  ),
                )
              : const SizedBox(),
          // current -> front
          currentPage < 7
              ? GestureDetector(
                  onTap: () {
                    //_shatteringKey.currentState!.shatter();
                    if (!controller.isAnimating) {
                      controller.forward();
                      if (currentPage > 3) {
                        controller2.forward();
                      }
                    }
                  },
                  child: ShatteringWidget(
                    key: _shatteringKeyL,
                    builder: (shatter) => Align(
                      alignment: alm5L?.value ?? const Alignment(0, 0),
                      child: SizedBox(
                        width: sz5?.value.width ?? 0,
                        height: sz5?.value.height ?? 0,
                        child: CustomPaint(
                          painter: Platform(isLeft: true, adjustments: [
                            adj51?.value ?? 0,
                            adj52?.value ?? 0
                          ]),
                        ),
                      ),
                    ),
                    onShatterCompleted: () {},
                  ),
                )
              : const SizedBox(),
          currentPage < 7
              ? GestureDetector(
                  onTap: () {
                    //_shatteringKey.currentState!.shatter();
                    if (!controller.isAnimating) {
                      controller.forward();
                      if (currentPage > 3) {
                        controller2.forward();
                      }
                    }
                  },
                  child: ShatteringWidget(
                    key: _shatteringKeyR,
                    builder: (shatter) => Align(
                      alignment: alm5R?.value ?? const Alignment(0, 0),
                      child: SizedBox(
                        width: sz5?.value.width ?? 0,
                        height: sz5?.value.height ?? 0,
                        child: CustomPaint(
                          painter: Platform(isLeft: false, adjustments: [
                            adj51?.value ?? 0,
                            adj52?.value ?? 0
                          ]),
                        ),
                      ),
                    ),
                    onShatterCompleted: () {},
                  ),
                )
              : const SizedBox(),
          // middle front -> current
          currentPage < 6
              ? Align(
                  alignment: alm4L?.value ?? const Alignment(0, 0),
                  child: SizedBox(
                    width: sz4?.value.width ?? 0,
                    height: sz4?.value.height ?? 0,
                    child: CustomPaint(
                      painter: Platform(
                          isLeft: true,
                          adjustments: [adj41?.value ?? 0, adj42?.value ?? 0]),
                    ),
                  ),
                )
              : const SizedBox(),
          currentPage < 6
              ? Align(
                  alignment: alm4R?.value ?? const Alignment(0, 0),
                  child: SizedBox(
                    width: sz4?.value.width ?? 0,
                    height: sz4?.value.height ?? 0,
                    child: CustomPaint(
                      painter: Platform(
                          isLeft: false,
                          adjustments: [adj41?.value ?? 0, adj42?.value ?? 0]),
                    ),
                  ),
                )
              : const SizedBox(),
          // middle back -> middle front
          currentPage < 5
              ? Align(
                  alignment: alm3L?.value ?? const Alignment(0, 0),
                  child: SizedBox(
                    width: sz3?.value.width ?? 0,
                    height: sz3?.value.height ?? 0,
                    child: CustomPaint(
                      painter: Platform(
                          isLeft: true,
                          adjustments: [adj31?.value ?? 0, adj32?.value ?? 0]),
                    ),
                  ),
                )
              : const SizedBox(),
          currentPage < 5
              ? Align(
                  alignment: alm3R?.value ?? const Alignment(0, 0),
                  child: SizedBox(
                    width: sz3?.value.width ?? 0,
                    height: sz3?.value.height ?? 0,
                    child: CustomPaint(
                      painter: Platform(
                          isLeft: false,
                          adjustments: [adj31?.value ?? 0, adj32?.value ?? 0]),
                    ),
                  ),
                )
              : const SizedBox(),
          // back -> middle back
          currentPage < 4
              ? Align(
                  alignment: alm2L?.value ?? const Alignment(0, 0),
                  child: SizedBox(
                    width: sz2?.value.width ?? 0,
                    height: sz2?.value.height ?? 0,
                    child: CustomPaint(
                      painter: Platform(
                          isLeft: true,
                          adjustments: [adj21?.value ?? 0, adj22?.value ?? 0]),
                    ),
                  ),
                )
              : const SizedBox(),
          currentPage < 4
              ? Align(
                  alignment: alm2R?.value ?? const Alignment(0, 0),
                  child: SizedBox(
                    width: sz2?.value.width ?? 0,
                    height: sz2?.value.height ?? 0,
                    child: CustomPaint(
                      painter: Platform(
                          isLeft: false,
                          adjustments: [adj21?.value ?? 0, adj22?.value ?? 0]),
                    ),
                  ),
                )
              : const SizedBox(),
          // hidden -> back
          currentPage < 3
              ? Opacity(
                  opacity: hiddenOne?.value ?? 0,
                  child: Align(
                    alignment: alm1L?.value ?? const Alignment(0, 0),
                    child: SizedBox(
                      width: sz1?.value.width ?? 0,
                      height: sz1?.value.height ?? 0,
                      child: CustomPaint(
                        painter: Platform(isLeft: true, adjustments: [
                          adj11?.value ?? 0,
                          adj12?.value ?? 0
                        ]),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          currentPage < 3
              ? Opacity(
                  opacity: hiddenOne?.value ?? 0,
                  child: Align(
                    alignment: alm1R?.value ?? const Alignment(0, 0),
                    child: SizedBox(
                      width: sz1?.value.width ?? 0,
                      height: sz1?.value.height ?? 0,
                      child: CustomPaint(
                        painter: Platform(isLeft: false, adjustments: [
                          adj11?.value ?? 0,
                          adj12?.value ?? 0
                        ]),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),

          // End Platform (only need to make two then I can have it stop when that other animation stops)

          currentPage > 3
              ? GestureDetector(
                  onTap: () {
                    if (currentPage == 7) {
                      nextSection(8, context);
                    }
                  },
                  child: Align(
                    alignment: Alignment(0, almPlat?.value ?? 0),
                    child: SizedBox(
                      width: szPlat?.value.width ?? 0,
                      height: szPlat?.value.height ?? 0,
                      child: CustomPaint(
                        painter:
                            EndingPlatform(adjustments: adjPlat?.value ?? 0),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class Platform extends CustomPainter {
  final bool isLeft;
  final List<double> adjustments;
  final List<Color> grad = [
    const Color.fromARGB(255, 116, 154, 225),
    const Color.fromARGB(255, 149, 183, 222),
    const Color.fromARGB(255, 98, 136, 207)
  ];

  Platform({
    super.repaint,
    required this.isLeft,
    required this.adjustments,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = isLeft
        ? LinearGradient(
            colors: grad,
            begin: const Alignment(1, 1),
            end: const Alignment(-.15, -.9),
          )
        : LinearGradient(
            colors: grad,
            begin: const Alignment(-1, 1),
            end: const Alignment(.15, -.9),
          );
    final paint = Paint()..shader = gradient.createShader(rect);
    final path = Path();
    if (isLeft) {
      path.moveTo(size.width * adjustments[0], 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width * adjustments[1], size.height);
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(size.width * (1 - adjustments[0]), 0);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width * (1 - adjustments[1]), size.height);
      path.lineTo(0, 0);
    }
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, fillStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class EndingPlatform extends CustomPainter {
  final double adjustments;

  EndingPlatform({
    super.repaint,
    required this.adjustments,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 193, 182, 107)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color.fromARGB(255, 135, 124, 55)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * .9);
    path.lineTo(size.width, size.height * .9);
    path.lineTo(size.width * (1 - adjustments), 0);
    path.lineTo(size.width * adjustments, 0);
    path.close();
    final path2 = Path();
    path2.moveTo(0, size.height * .9);
    path2.lineTo(size.width, size.height * .9);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path, fillStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
