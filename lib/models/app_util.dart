import 'package:levels222_0/pages/home.dart';

// Header
class Header extends StatelessWidget {
  final bool home;
  final Color banner1;
  final Color banner2;
  final Color banner3;
  final double opacity;
  final String title;
  final List<String> numbers;
  final VoidCallback homeFunc;
  final String currentAdCount;
  final String totalAdCount;

  const Header({
    super.key,
    required this.homeFunc,
    required this.banner1,
    required this.banner2,
    required this.banner3,
    required this.title,
    required this.opacity,
    required this.numbers,
    required this.home,
    required this.currentAdCount,
    required this.totalAdCount,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // BANNER
              appBanner(context, banner1, banner2, banner3, opacity, numbers),
              // TITLE
              appText(title, AppColors.lightGrey.withOpacity(opacity),
                  deviceWidth(context) / 22, FontWeight.w600),
              // HOME
              GestureDetector(
                onTap: () {
                  if (home) {
                    homeFunc();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: deviceWidth(context) / 20,
                  ),
                  child: Container(
                    width: deviceWidth(context) / 8,
                    height: deviceWidth(context) / 8,
                    color: AppColors.backgroundColor,
                    child: home
                        ? homeButton(context)
                        : AdsCounter(
                            currentCount: currentAdCount,
                            totalCount: totalAdCount,
                            opacity: opacity,
                          ),
                  ),
                ),
              ),
            ],
          ),
          home
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(right: deviceWidth(context) / 20),
                      child: AdsCounter(
                        currentCount: currentAdCount,
                        totalCount: totalAdCount,
                        opacity: opacity,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

// Arrows
class Arrows extends StatelessWidget {
  final Color backgroundColor;
  final Color arrow1;
  final Color arrow2;
  final Color arrow3;
  final double leftArrowOpacity;
  final double rightArrowOpacity;
  final VoidCallback leftFunction;
  final VoidCallback rightFunction;
  const Arrows(
      {super.key,
      required this.backgroundColor,
      required this.arrow1,
      required this.arrow2,
      required this.arrow3,
      required this.leftArrowOpacity,
      required this.rightArrowOpacity,
      required this.leftFunction,
      required this.rightFunction});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Center(
        child: SizedBox(
          width: deviceWidth(context) / 1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  leftFunction();
                },
                child: Container(
                  height: deviceWidth(context) / 6.5,
                  color: AppColors.backgroundColor.withOpacity(0),
                  child: leftArrow(context, backgroundColor, arrow1, arrow2,
                      arrow3, leftArrowOpacity),
                ),
              ),
              GestureDetector(
                onTap: () {
                  rightFunction();
                },
                child: Container(
                  height: deviceWidth(context) / 6.5,
                  color: AppColors.backgroundColor.withOpacity(0),
                  child: rightArrow(context, backgroundColor, arrow1, arrow2,
                      arrow3, rightArrowOpacity),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
