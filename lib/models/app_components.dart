import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:levels222_0/pages/home.dart';

// Button
Stack button(
  BuildContext context,
  Color color1,
  Color color2,
  Color color3,
  String text,
  Color textColor,
  String? img,
) {
  return Stack(
    alignment: Alignment.center,
    children: [
      // Color 1 (back color)
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color1),
        width: deviceWidth(context) / 1.4,
        height: deviceWidth(context) / 7,
      ),
      // Color 2 (Middle Color)
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color2),
        width: deviceWidth(context) / 1.43,
        height: deviceWidth(context) / 7.75,
      ),
      // Color 3 (Front Color)
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color3),
        width: deviceWidth(context) / 1.46,
        height: deviceWidth(context) / 8.5,
      ),

      // IMG
      img == null
          ? const SizedBox()
          : Positioned(
              left: deviceWidth(context) / 15,
              child: SizedBox(
                width: deviceWidth(context) / 14,
                height: deviceWidth(context) / 14,
                child: Image.asset(
                  img,
                  fit: BoxFit.contain,
                ),
              ),
            ),
      // TEXT
      Padding(
        padding: EdgeInsets.only(left: img != null ? 1.5 * text.length : 0),
        child: appText(
          text,
          textColor,
          deviceWidth(context) / 25,
          FontWeight.w600,
        ),
      )
    ],
  );
}

// Left Arrow
SizedBox leftArrow(BuildContext context, Color backgroundColor, Color color1,
    Color color2, Color color3, double opacity) {
  return SizedBox(
    height: deviceWidth(context) / 7,
    width: deviceWidth(context) / 4.5,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        // Color 1
        CustomPaint(
          size: Size(deviceWidth(context) / 14, deviceWidth(context) / 7),
          painter: TrianglePainter(
            color: color1.withOpacity(opacity),
          ),
        ),
        //          SPACER
        Positioned(
          left: deviceWidth(context) * .01,
          child: CustomPaint(
            size: Size(deviceWidth(context) / 14, deviceWidth(context) / 7),
            painter: TrianglePainter(color: backgroundColor),
          ),
        ),
        // Color 1
        Positioned(
          left: deviceWidth(context) * .02,
          child: CustomPaint(
            size: Size(deviceWidth(context) / 14, deviceWidth(context) / 7),
            painter: TrianglePainter(
              color: color1.withOpacity(opacity),
            ),
          ),
        ),
        //          SPACER
        Positioned(
          left: deviceWidth(context) * .03,
          child: CustomPaint(
            size: Size(deviceWidth(context) / 14, deviceWidth(context) / 7),
            painter: TrianglePainter(color: backgroundColor),
          ),
        ),
        // Color 1
        Positioned(
          left: deviceWidth(context) * .0425,
          child: CustomPaint(
            size: Size(deviceWidth(context) / 13, deviceWidth(context) / 7),
            painter: TrianglePainter(
              color: color1.withOpacity(opacity),
            ),
          ),
        ),
        // Color 1
        Positioned(
          left: deviceWidth(context) * 621 / 5200,
          child: Container(
            width: deviceWidth(context) * 4811 / 46800,
            height: deviceWidth(context) / 12.25,
            color: color1.withOpacity(opacity),
          ),
        ),
        // Color 2
        Positioned(
          left: deviceWidth(context) * .04925,
          child: CustomPaint(
            size: Size(
                deviceWidth(context) * 28 / 429, deviceWidth(context) / 8.25),
            painter: TrianglePainter(
              color: color2.withOpacity(opacity),
            ),
          ),
        ),
        // Color 2
        Positioned(
          left: deviceWidth(context) * 196513 / 1716000,
          child: Container(
            width: deviceWidth(context) / 9.75,
            height: deviceHeight(context) / 29.75,
            color: color2.withOpacity(opacity),
          ),
        ),
        // Color 3
        Positioned(
          left: deviceWidth(context) * .0565,
          child: CustomPaint(
            size:
                Size(deviceWidth(context) * 7 / 130, deviceWidth(context) / 10),
            painter: TrianglePainter(
              color: color3.withOpacity(opacity),
            ),
          ),
        ),
        // Color 3
        Positioned(
          left: deviceWidth(context) * 2869 / 26000,
          child: Container(
            width: deviceWidth(context) / 9.75,
            height: deviceHeight(context) / 34,
            color: color3.withOpacity(opacity),
          ),
        ),
      ],
    ),
  );
}

// Right Arrow
Transform rightArrow(BuildContext context, Color backgroundColor, Color color1,
    Color color2, Color color3, double opacity) {
  return Transform.rotate(
    angle: pi,
    child: SizedBox(
      height: deviceWidth(context) / 7,
      width: deviceWidth(context) / 4.5,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Color 1
          CustomPaint(
            size: Size(deviceWidth(context) / 14, deviceWidth(context) / 7),
            painter: TrianglePainter(
              color: color1.withOpacity(opacity),
            ),
          ),
          //          SPACER
          Positioned(
            left: deviceWidth(context) * .01,
            child: CustomPaint(
              size: Size(deviceWidth(context) / 14, deviceWidth(context) / 7),
              painter: TrianglePainter(color: backgroundColor),
            ),
          ),
          // Color 1
          Positioned(
            left: deviceWidth(context) * .02,
            child: CustomPaint(
              size: Size(deviceWidth(context) / 14, deviceWidth(context) / 7),
              painter: TrianglePainter(
                color: color1.withOpacity(opacity),
              ),
            ),
          ),
          //          SPACER
          Positioned(
            left: deviceWidth(context) * .03,
            child: CustomPaint(
              size: Size(deviceWidth(context) / 14, deviceWidth(context) / 7),
              painter: TrianglePainter(color: backgroundColor),
            ),
          ),
          // Color 1
          Positioned(
            left: deviceWidth(context) * .0425,
            child: CustomPaint(
              size: Size(deviceWidth(context) / 13, deviceWidth(context) / 7),
              painter: TrianglePainter(
                color: color1.withOpacity(opacity),
              ),
            ),
          ),
          // Color 1
          Positioned(
            left: deviceWidth(context) * 621 / 5200,
            child: Container(
              width: deviceWidth(context) * 4811 / 46800,
              height: deviceWidth(context) / 12.25,
              color: color1.withOpacity(opacity),
            ),
          ),
          // Color 2
          Positioned(
            left: deviceWidth(context) * .04925,
            child: CustomPaint(
              size: Size(
                  deviceWidth(context) * 28 / 429, deviceWidth(context) / 8.25),
              painter: TrianglePainter(
                color: color2.withOpacity(opacity),
              ),
            ),
          ),
          // Color 2
          Positioned(
            left: deviceWidth(context) * 196513 / 1716000,
            child: Container(
              width: deviceWidth(context) / 9.75,
              height: deviceHeight(context) / 29.75,
              color: color2.withOpacity(opacity),
            ),
          ),
          // Color 3
          Positioned(
            left: deviceWidth(context) * .0565,
            child: CustomPaint(
              size: Size(
                  deviceWidth(context) * 7 / 130, deviceWidth(context) / 10),
              painter: TrianglePainter(
                color: color3.withOpacity(opacity),
              ),
            ),
          ),
          // Color 3
          Positioned(
            left: deviceWidth(context) * 2869 / 26000,
            child: Container(
              width: deviceWidth(context) / 9.75,
              height: deviceHeight(context) / 34,
              color: color3.withOpacity(opacity),
            ),
          ),
        ],
      ),
    ),
  );
}

// Arrow Helper
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height / 2); // left center
    path.lineTo(size.width, 0); // top right
    path.lineTo(size.width, size.height); // bottom right
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Banner
SizedBox appBanner(
  BuildContext context,
  Color color1,
  Color color2,
  Color color3,
  double opacity,
  List<String>? numbers,
) {
  return SizedBox(
    width: deviceWidth(context) / 4.5,
    height: deviceWidth(context) / 5.75,
    child: Stack(
      alignment: Alignment.topLeft,
      children: [
        // Color 1
        Container(
          width: deviceWidth(context) / 4.675,
          color: color1.withOpacity(opacity),
        ),
        Positioned(
          right: -deviceWidth(context) * .005,
          bottom: deviceWidth(context) * .017,
          child: Transform.rotate(
            angle: 35 * pi / 180,
            child: Container(
              height: sqrt(deviceHeight(context) * (2569 / 33660)),
              width: deviceWidth(context) / 15,
              color: color1.withOpacity(opacity),
            ),
          ),
        ),
        // Color 2
        Container(
          height: deviceWidth(context) * 15 / 92,
          color: color2.withOpacity(opacity),
        ),
        // Color 3
        Container(
          width: deviceWidth(context) / 4.575,
          height: deviceWidth(context) * 225 / 1403,
          color: color3.withOpacity(opacity),
        ),
        // NUMBERS
        numbers != null
            ? SizedBox(
                height: deviceWidth(context) / 5.75,
                width: deviceWidth(context) / 4.575,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: deviceWidth(context) / 18,
                      child: Image.asset(
                        numbers[0],
                        fit: BoxFit.contain,
                      ),
                    ),
                    numbers.length > 1
                        ? SizedBox(
                            width: deviceWidth(context) / 17,
                            child: Image.asset(
                              numbers[1],
                              fit: BoxFit.contain,
                            ),
                          )
                        : const SizedBox(),
                    numbers.length > 2
                        ? SizedBox(
                            width: deviceWidth(context) / 18,
                            child: Image.asset(
                              numbers[2],
                              fit: BoxFit.contain,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            : const SizedBox()
      ],
    ),
  );
}

// Home Button
SizedBox homeButton(BuildContext context) {
  return SizedBox(
    width: deviceWidth(context) / 8,
    height: deviceWidth(context) / 8,
    child: Stack(
      children: [
        //top left
        Positioned(
          top: deviceWidth(context) / 35,
          left: deviceWidth(context) / 145,
          child: Transform.rotate(
            angle: pi * 3 / 4,
            child: Container(
              height: deviceWidth(context) / 200,
              width: deviceWidth(context) / 15,
              decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ),
        //top right
        Positioned(
          top: deviceWidth(context) / 35,
          right: deviceWidth(context) / 145,
          child: Transform.rotate(
            angle: pi / 4,
            child: Container(
              height: deviceWidth(context) / 200,
              width: deviceWidth(context) / 15,
              decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ),
        // left down
        Positioned(
          bottom: deviceWidth(context) / 25,
          left: deviceWidth(context) / 180,
          child: Transform.rotate(
            angle: pi / 2,
            child: Container(
              height: deviceWidth(context) / 175,
              width: deviceWidth(context) / 25,
              decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50))),
            ),
          ),
        ),
        // right down
        Positioned(
          bottom: deviceWidth(context) / 25,
          right: deviceWidth(context) / 180,
          child: Transform.rotate(
            angle: pi / 2,
            child: Container(
              height: deviceWidth(context) / 175,
              width: deviceWidth(context) / 25,
              decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50))),
            ),
          ),
        ),
        // left bottom
        Positioned(
          bottom: deviceWidth(context) / 44,
          left: deviceWidth(context) / 40,
          child: Container(
            height: deviceWidth(context) / 175,
            width: deviceWidth(context) / 40,
            color: AppColors.lightGrey,
          ),
        ),
        // right bottom
        Positioned(
          bottom: deviceWidth(context) / 44,
          right: deviceWidth(context) / 40,
          child: Container(
            height: deviceWidth(context) / 175,
            width: deviceWidth(context) / 40,
            color: AppColors.lightGrey,
          ),
        ),
        // left inside
        Positioned(
          bottom: deviceWidth(context) / 31,
          left: deviceWidth(context) / 28,
          child: Transform.rotate(
            angle: pi / 2,
            child: Container(
              height: deviceWidth(context) / 175,
              width: deviceWidth(context) / 40,
              color: AppColors.lightGrey,
            ),
          ),
        ),
        // right inside
        Positioned(
          bottom: deviceWidth(context) / 31,
          right: deviceWidth(context) / 28,
          child: Transform.rotate(
            angle: pi / 2,
            child: Container(
              height: deviceWidth(context) / 175,
              width: deviceWidth(context) / 40,
              color: AppColors.lightGrey,
            ),
          ),
        ),
        // middle inside
        Positioned(
          bottom: deviceWidth(context) / 22,
          left: deviceWidth(context) / 22,
          child: Container(
            height: deviceWidth(context) / 175,
            width: deviceWidth(context) / 29.25,
            color: AppColors.lightGrey,
          ),
        ),
      ],
    ),
  );
}

// Game Button
SizedBox gameButton(
  BuildContext context,
  Color color1,
  Color color2,
  Color color3,
) {
  return SizedBox(
    width: deviceWidth(context) / 3,
    height: deviceWidth(context) / 2.75,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: deviceWidth(context) / 3,
          height: deviceWidth(context) / 3,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color1),
        ),
        Positioned(
          bottom: deviceWidth(context) / 30,
          child: Container(
            width: deviceWidth(context) / 3.75,
            height: deviceWidth(context) / 3.75,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color2),
          ),
        ),
        Positioned(
          bottom: deviceWidth(context) / 6,
          child: Container(
            width: deviceWidth(context) / 3.75,
            height: deviceWidth(context) / 20,
            color: color2,
          ),
        ),
        Positioned(
          bottom: deviceWidth(context) / 12,
          child: Container(
            width: deviceWidth(context) / 3.75,
            height: deviceWidth(context) / 3.75,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color3),
          ),
        ),
      ],
    ),
  );
}

// Ads Counter
class AdsCounter extends StatelessWidget {
  final String currentCount;
  final String totalCount;
  final double opacity;

  const AdsCounter(
      {super.key,
      required this.currentCount, // int.parse(currentCount)
      required this.totalCount,
      required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.darkerGrey.withOpacity(opacity),
            borderRadius: BorderRadius.circular(10)),
        width: deviceWidth(context) / 6.8,
        height: deviceWidth(context) / 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Current Ad Count
            Text(
              currentCount,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: AppColors.middleGrey.withOpacity(opacity),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none),
              ),
            ),
            // SPACER
            Text(
              "/",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: AppColors.middleGrey.withOpacity(opacity),
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    decoration: TextDecoration.none),
              ),
            ),
            // TOTAL COUNT
            Text(
              totalCount,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: AppColors.middleGrey.withOpacity(opacity),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none),
              ),
            ),
          ],
        ));
  }
}

// Checks Box
Container checkBox(BuildContext context, bool ischecked) {
  return Container(
    width: deviceWidth(context) / 10,
    height: deviceWidth(context) / 10,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.lightGrey, width: 3),
    ),
    child: ischecked
        ? Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: pi / 4,
                child: Container(
                  width: deviceWidth(context) / 10,
                  height: 3,
                  color: AppColors.lightGrey,
                ),
              ),
              Transform.rotate(
                angle: -pi / 4,
                child: Container(
                  width: deviceWidth(context) / 10,
                  height: 3,
                  color: AppColors.lightGrey,
                ),
              )
            ],
          )
        : const SizedBox(),
  );
}

// need to find a better strat
// All Level Numbers
List<List<String>> allNumbers = [
  ["lib/assets/images/number1.png"],
  ["lib/assets/images/number2.png"],
  ["lib/assets/images/number3.png"],
  ["lib/assets/images/number4.png"],
  ["lib/assets/images/number5.png"],
  ["lib/assets/images/number6.png"],
  ["lib/assets/images/number7.png"],
  ["lib/assets/images/number8.png"],
  ["lib/assets/images/number9.png"],
  ["lib/assets/images/number1.png", "lib/assets/images/number0.png"],
  ["lib/assets/images/number1.png", "lib/assets/images/number1.png"],
  ["lib/assets/images/number1.png", "lib/assets/images/number2.png"],
  ["lib/assets/images/number1.png", "lib/assets/images/number3.png"],
  ["lib/assets/images/number1.png", "lib/assets/images/number4.png"],
  ["lib/assets/images/number1.png", "lib/assets/images/number5.png"],
  ["lib/assets/images/number1.png", "lib/assets/images/number6.png"],
  ["lib/assets/images/number1.png", "lib/assets/images/number7.png"],
  ["lib/assets/images/number1.png", "lib/assets/images/number8.png"],
  ["lib/assets/images/number1.png", "lib/assets/images/number9.png"],
  ["lib/assets/images/number2.png", "lib/assets/images/number0.png"],
  ["lib/assets/images/number2.png", "lib/assets/images/number1.png"],
  ["lib/assets/images/number2.png", "lib/assets/images/number2.png"],
  ["lib/assets/images/number2.png", "lib/assets/images/number3.png"],
  ["lib/assets/images/number2.png", "lib/assets/images/number4.png"],
  ["lib/assets/images/number2.png", "lib/assets/images/number5.png"],
  ["lib/assets/images/number2.png", "lib/assets/images/number6.png"],
  ["lib/assets/images/number2.png", "lib/assets/images/number7.png"],
  ["lib/assets/images/number2.png", "lib/assets/images/number8.png"],
  ["lib/assets/images/number2.png", "lib/assets/images/number9.png"],
  ["lib/assets/images/number3.png", "lib/assets/images/number0.png"],
  ["lib/assets/images/number3.png", "lib/assets/images/number1.png"],
  ["lib/assets/images/number3.png", "lib/assets/images/number2.png"],
  ["lib/assets/images/number3.png", "lib/assets/images/number3.png"],
  ["lib/assets/images/number3.png", "lib/assets/images/number4.png"],
  ["lib/assets/images/number3.png", "lib/assets/images/number5.png"],
  ["lib/assets/images/number3.png", "lib/assets/images/number6.png"],
  ["lib/assets/images/number3.png", "lib/assets/images/number7.png"],
  ["lib/assets/images/number3.png", "lib/assets/images/number8.png"],
  ["lib/assets/images/number3.png", "lib/assets/images/number9.png"],
  ["lib/assets/images/number4.png", "lib/assets/images/number0.png"],
  ["lib/assets/images/number4.png", "lib/assets/images/number1.png"],
  ["lib/assets/images/number4.png", "lib/assets/images/number2.png"],
  ["lib/assets/images/number4.png", "lib/assets/images/number3.png"],
  ["lib/assets/images/number4.png", "lib/assets/images/number4.png"],
  ["lib/assets/images/number4.png", "lib/assets/images/number5.png"],
  ["lib/assets/images/number4.png", "lib/assets/images/number6.png"],
  ["lib/assets/images/number4.png", "lib/assets/images/number7.png"],
  ["lib/assets/images/number4.png", "lib/assets/images/number8.png"],
  ["lib/assets/images/number4.png", "lib/assets/images/number9.png"],
  ["lib/assets/images/number5.png", "lib/assets/images/number0.png"],
  ["lib/assets/images/number5.png", "lib/assets/images/number1.png"],
  ["lib/assets/images/number5.png", "lib/assets/images/number2.png"],
  ["lib/assets/images/number5.png", "lib/assets/images/number3.png"],
  ["lib/assets/images/number5.png", "lib/assets/images/number4.png"],
  ["lib/assets/images/number5.png", "lib/assets/images/number5.png"],
  ["lib/assets/images/number5.png", "lib/assets/images/number6.png"],
  ["lib/assets/images/number5.png", "lib/assets/images/number7.png"],
  ["lib/assets/images/number5.png", "lib/assets/images/number8.png"],
  ["lib/assets/images/number5.png", "lib/assets/images/number9.png"],
  ["lib/assets/images/number6.png", "lib/assets/images/number0.png"],
  ["lib/assets/images/number6.png", "lib/assets/images/number1.png"],
  ["lib/assets/images/number6.png", "lib/assets/images/number2.png"],
  ["lib/assets/images/number6.png", "lib/assets/images/number3.png"],
  ["lib/assets/images/number6.png", "lib/assets/images/number4.png"],
  ["lib/assets/images/number6.png", "lib/assets/images/number5.png"],
  ["lib/assets/images/number6.png", "lib/assets/images/number6.png"],
  ["lib/assets/images/number6.png", "lib/assets/images/number7.png"],
  ["lib/assets/images/number6.png", "lib/assets/images/number8.png"],
  ["lib/assets/images/number6.png", "lib/assets/images/number9.png"],
  ["lib/assets/images/number7.png", "lib/assets/images/number0.png"],
  ["lib/assets/images/number7.png", "lib/assets/images/number1.png"],
  ["lib/assets/images/number7.png", "lib/assets/images/number2.png"],
  ["lib/assets/images/number7.png", "lib/assets/images/number3.png"],
  ["lib/assets/images/number7.png", "lib/assets/images/number4.png"],
  ["lib/assets/images/number7.png", "lib/assets/images/number5.png"],
  ["lib/assets/images/number7.png", "lib/assets/images/number6.png"],
  ["lib/assets/images/number7.png", "lib/assets/images/number7.png"],
  ["lib/assets/images/number7.png", "lib/assets/images/number8.png"],
  ["lib/assets/images/number7.png", "lib/assets/images/number9.png"],
  ["lib/assets/images/number8.png", "lib/assets/images/number0.png"],
  ["lib/assets/images/number8.png", "lib/assets/images/number1.png"],
  ["lib/assets/images/number8.png", "lib/assets/images/number2.png"],
  ["lib/assets/images/number8.png", "lib/assets/images/number3.png"],
  ["lib/assets/images/number8.png", "lib/assets/images/number4.png"],
  ["lib/assets/images/number8.png", "lib/assets/images/number5.png"],
  ["lib/assets/images/number8.png", "lib/assets/images/number6.png"],
  ["lib/assets/images/number8.png", "lib/assets/images/number7.png"],
  ["lib/assets/images/number8.png", "lib/assets/images/number8.png"],
  ["lib/assets/images/number8.png", "lib/assets/images/number9.png"],
  ["lib/assets/images/number9.png", "lib/assets/images/number0.png"],
  ["lib/assets/images/number9.png", "lib/assets/images/number1.png"],
  ["lib/assets/images/number9.png", "lib/assets/images/number2.png"],
  ["lib/assets/images/number9.png", "lib/assets/images/number3.png"],
  ["lib/assets/images/number9.png", "lib/assets/images/number4.png"],
  ["lib/assets/images/number9.png", "lib/assets/images/number5.png"],
  ["lib/assets/images/number9.png", "lib/assets/images/number6.png"],
  ["lib/assets/images/number9.png", "lib/assets/images/number7.png"],
  ["lib/assets/images/number9.png", "lib/assets/images/number8.png"],
  ["lib/assets/images/number9.png", "lib/assets/images/number9.png"],
  [
    "lib/assets/images/number1.png",
    "lib/assets/images/number0.png",
    "lib/assets/images/number0.png",
  ],
];
