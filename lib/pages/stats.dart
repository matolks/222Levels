import 'package:levels222_0/pages/home.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}
// update
// make it so there is no border if you havent reached a level yet

class _StatsState extends State<Stats> {
  int currentLevel = 0;
  int totalAttempts = 0;
  int totalAds = 0;
  List<List<dynamic>> sections = [
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
  ];

  @override
  void initState() {
    super.initState();
    currentLevel = box.get('currentLevel') ?? 0;
    sections[0] = box.get('section1') ?? [0, 0];
    sections[1] = box.get('section2') ?? [0, 0];
    sections[2] = box.get('section3') ?? [0, 0];
    sections[3] = box.get('section4') ?? [0, 0];
    sections[4] = box.get('section5') ?? [0, 0];
    sections[5] = box.get('section6') ?? [0, 0];
    sections[6] = box.get('section7') ?? [0, 0];
    sections[7] = box.get('section8') ?? [0, 0];
    sections[8] = box.get('section9') ?? [0, 0];
    sections[9] = box.get('section10') ?? [0, 0];
    sections[10] = box.get('section11') ?? [0, 0];
    sections[11] = box.get('section12') ?? [0, 0];
    sections[12] = box.get('section13') ?? [0, 0];
    sections[13] = box.get('section14') ?? [0, 0];
    sections[14] = box.get('section15') ?? [0, 0];
    sections[15] = box.get('section16') ?? [0, 0];
    sections[16] = box.get('section17') ?? [0, 0];
    sections[17] = box.get('section18') ?? [0, 0];
    sections[19] = box.get('section19') ?? [0, 0];
    totalAttempts = sections.map((e) => e[0]).reduce((a, b) => a + b);
    totalAds = sections.map((e) => e[1]).reduce((a, b) => a + b);
  }

  // Locked Section
  Stack lockedSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        appBanner(context, AppColors.darkGrey, AppColors.darkerGrey,
            AppColors.darkerGrey, 1, null),
        SizedBox(
          height: deviceWidth(context) / 8.5,
          child: Image.asset(
            'lib/assets/images/lock.png',
            fit: BoxFit.contain,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // All Section Banners
    List<SizedBox> allSectionBanners = [
      appBanner(
        context,
        AppColors.lightGrey,
        AppColors.babyv,
        AppColors.babyv,
        1,
        ["lib/assets/images/number1.png"],
      ),
      appBanner(
        context,
        const Color(0xFFECC19C),
        Colors.black,
        const Color(0xFF1E847F),
        1,
        ["lib/assets/images/number2.png"],
      ),
      appBanner(
        context,
        const Color(0xFFFCE77D),
        const Color(0xFFF96167),
        const Color(0xFFF96167),
        1,
        ["lib/assets/images/number3.png"],
      ),
      appBanner(
        context,
        const Color(0xff97BC62),
        const Color(0xff2C5F2D),
        const Color(0xff2C5F2D),
        1,
        ["lib/assets/images/number4.png"],
      ),
      appBanner(
        context,
        const Color(0xffAEFFDE),
        const Color(0xffE4F1FF),
        const Color(0xff333333),
        1,
        ["lib/assets/images/number5.png"],
      ),
      appBanner(
        context,
        const Color(0xffF9D342),
        Colors.black,
        Colors.black,
        1,
        ["lib/assets/images/number6.png"],
      ),
      appBanner(
        context,
        const Color(0xfff2c864),
        const Color(0xff08bbd7),
        const Color(0xff0b4251),
        1,
        ["lib/assets/images/number7.png"],
      ),
      appBanner(
        context,
        const Color(0xffed1b76),
        const Color(0xff037a76),
        const Color(0xff037a76),
        1,
        ["lib/assets/images/number8.png"],
      ),
      appBanner(
        context,
        const Color.fromARGB(255, 98, 106, 193),
        const Color(0xffec8b5e),
        const Color(0xffec8b5e),
        1,
        ["lib/assets/images/number9.png"],
      ),
      appBanner(
        context,
        const Color(0xfff1f4ff),
        const Color(0xffa2a2a1),
        const Color(0xffa2a2a1),
        1,
        [
          "lib/assets/images/number1.png",
          "lib/assets/images/number0.png",
        ],
      ),
      appBanner(
        context,
        const Color(0xffdf3c5f),
        const Color(0xff6f9bd1),
        const Color(0xff6f9bd1),
        1,
        [
          "lib/assets/images/number1.png",
          "lib/assets/images/number1.png",
        ],
      ),
      appBanner(
        context,
        const Color(0xffc7395f),
        const Color(0xffded4e8),
        const Color(0xffe8ba40),
        1,
        [
          "lib/assets/images/number1.png",
          "lib/assets/images/number2.png",
        ],
      ),
      appBanner(
        context,
        const Color(0xff675c5a),
        const Color(0xffcdbca8),
        const Color.fromARGB(255, 88, 106, 123),
        1,
        [
          "lib/assets/images/number1.png",
          "lib/assets/images/number3.png",
        ],
      ),
      appBanner(
        context,
        const Color(0xff009990),
        const Color(0xffe1ffbb),
        const Color.fromARGB(255, 157, 179, 129),
        1,
        [
          "lib/assets/images/number1.png",
          "lib/assets/images/number4.png",
        ],
      ),
    ];

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < 0) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            // TOP BAR
            SafeArea(
              bottom: false,
              child: SizedBox(
                width: deviceWidth(context),
                height: deviceWidth(context) / 6,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // BACK ARROW
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: deviceWidth(context) / 6,
                          height: deviceWidth(context) / 6,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.lightGrey,
                            size: deviceWidth(context) / 11,
                          ),
                        ),
                      ),
                    ),
                    // TEXT
                    appText('Stats', AppColors.lightGrey,
                        deviceWidth(context) / 15, FontWeight.w600),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // TOP
                    Padding(
                      padding: EdgeInsets.only(top: deviceHeight(context) / 40),
                      child: Container(
                        width: deviceWidth(context),
                        height: deviceHeight(context) / 4.5,
                        color: AppColors.backgroundColor,
                        child: Column(
                          children: [
                            // current sections
                            SizedBox(
                              height: deviceHeight(context) / 36,
                              child: appText(
                                  'Current Section',
                                  AppColors.middleGrey,
                                  deviceWidth(context) / 25,
                                  FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: allSectionBanners[currentLevel],
                            ),
                            // attempts and ads watched
                            SizedBox(
                              width: deviceWidth(context) / 1.41,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: deviceHeight(context) / 36,
                                    child: appText(
                                        'Total Attempts',
                                        AppColors.middleGrey,
                                        deviceWidth(context) / 25,
                                        FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: deviceHeight(context) / 36,
                                    child: appText(
                                        'Ads Watched',
                                        AppColors.middleGrey,
                                        deviceWidth(context) / 25,
                                        FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  width: deviceWidth(context) / 4.5,
                                  height: deviceHeight(context) / 18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.darkerGrey,
                                    border: const Border(
                                      bottom: BorderSide(
                                          color: AppColors.middleGrey,
                                          width: 2.5),
                                      right: BorderSide(
                                          color: AppColors.middleGrey,
                                          width: .5),
                                    ),
                                  ),
                                  child: Center(
                                    child: appText(
                                        '$totalAttempts',
                                        AppColors.lightGrey,
                                        deviceWidth(context) / 25,
                                        FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  width: deviceWidth(context) / 4.5,
                                  height: deviceHeight(context) / 18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.darkerGrey,
                                    border: const Border(
                                      bottom: BorderSide(
                                          color: AppColors.middleGrey,
                                          width: 2.5),
                                      right: BorderSide(
                                          color: AppColors.middleGrey,
                                          width: .5),
                                    ),
                                  ),
                                  child: Center(
                                    child: appText(
                                        '$totalAds',
                                        AppColors.lightGrey,
                                        deviceWidth(context) / 25,
                                        FontWeight.w700),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // Sections
                    Padding(
                      padding: EdgeInsets.only(top: deviceHeight(context) / 35),
                      child: SizedBox(
                        width: deviceWidth(context),
                        height: deviceHeight(context) / 20,
                        child: appText('Sections', AppColors.middleGrey,
                            deviceWidth(context) / 18, FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth(context) / 1.1,
                      height: deviceHeight(context) / 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidth(context) / 25),
                            child: appText('Banners', AppColors.darkGrey,
                                deviceWidth(context) / 27, FontWeight.w300),
                          ),
                          SizedBox(
                            width: deviceWidth(context) / 25,
                          ),
                          appText('Attempts', AppColors.darkGrey,
                              deviceWidth(context) / 27, FontWeight.w300),
                          appText('Ads Watched', AppColors.darkGrey,
                              deviceWidth(context) / 27, FontWeight.w300),
                        ],
                      ),
                    ),
                    for (int i = 0;
                        i < allSectionBanners.length;
                        i++) ...<Padding>{
                      Padding(
                        padding: EdgeInsets.only(
                            top: deviceHeight(context) / 45,
                            bottom: deviceHeight(context) / 75),
                        child: Container(
                          width: deviceWidth(context) / 1.1,
                          height: deviceWidth(context) / 5.75,
                          color: AppColors.backgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // banner
                              (currentLevel >= i) || (sections[i][0] > 0)
                                  ? allSectionBanners[i]
                                  : lockedSection(),
                              SizedBox(
                                width: deviceWidth(context) / 25,
                              ),
                              Container(
                                margin: const EdgeInsets.all(5),
                                width: deviceWidth(context) / 4.5,
                                height: deviceHeight(context) / 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.darkerGrey,
                                  border: (currentLevel >= i) ||
                                          (sections[i][0] > 0)
                                      ? const Border(
                                          bottom: BorderSide(
                                              color: AppColors.middleGrey,
                                              width: 1),
                                          right: BorderSide(
                                              color: AppColors.middleGrey,
                                              width: .2),
                                        )
                                      : null,
                                ),
                                child: Center(
                                  child: appText(
                                      '${sections[i][0]}',
                                      AppColors.lightGrey,
                                      deviceWidth(context) / 28,
                                      FontWeight.w400),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(5),
                                width: deviceWidth(context) / 4.5,
                                height: deviceHeight(context) / 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.darkerGrey,
                                  border: (currentLevel >= i) ||
                                          (sections[i][0] > 0)
                                      ? const Border(
                                          bottom: BorderSide(
                                              color: AppColors.middleGrey,
                                              width: 1),
                                          right: BorderSide(
                                              color: AppColors.middleGrey,
                                              width: .2),
                                        )
                                      : null,
                                ),
                                child: Center(
                                  child: appText(
                                      '${sections[i][1]}',
                                      AppColors.lightGrey,
                                      deviceWidth(context) / 28,
                                      FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    },
                    // space
                    SizedBox(
                      height: deviceHeight(context) / 4,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
