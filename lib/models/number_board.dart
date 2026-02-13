import 'package:levels222_0/pages/home.dart';

List<List<dynamic>> numbers = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  ["ENT", 0, "DEL"] // 10 => DEL, 11 => ENT
];

class NumberBoard extends StatelessWidget {
  const NumberBoard(
      {super.key,
      required this.onKeyTapped,
      required this.onDeleteTapped,
      required this.onEnterTapped,
      required this.textColor,
      required this.backgroundColor,
      required this.opacitys});

  final void Function(String) onKeyTapped;
  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;
  final Color textColor;
  final Color backgroundColor;
  final double opacitys;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numbers
          .map(
            (keyRow) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: keyRow.map((input) {
                if (input == 'DEL') {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceWidth(context) / 200,
                      horizontal: deviceWidth(context) / 300,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        onDeleteTapped();
                      },
                      child: Opacity(
                        opacity: opacitys,
                        child: Container(
                          width: deviceWidth(context) / 6,
                          height: deviceWidth(context) / 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  deviceWidth(context) / 60),
                              color: backgroundColor),
                          child: Center(
                            child: appText("DELETE", textColor,
                                deviceWidth(context) / 28, FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (input == 'ENT') {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceWidth(context) / 200,
                      horizontal: deviceWidth(context) / 300,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        onEnterTapped();
                      },
                      child: Opacity(
                        opacity: opacitys,
                        child: Container(
                          width: deviceWidth(context) / 6,
                          height: deviceWidth(context) / 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  deviceWidth(context) / 60),
                              color: backgroundColor),
                          child: Center(
                            child: appText('ENTER', textColor,
                                deviceWidth(context) / 28, FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceWidth(context) / 200,
                      horizontal: deviceWidth(context) / 300,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        onKeyTapped("$input");
                      },
                      child: Container(
                        width: deviceWidth(context) / 6,
                        height: deviceWidth(context) / 8,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(deviceWidth(context) / 60),
                          color: backgroundColor,
                        ),
                        child: Center(
                          child: appText('$input', textColor,
                              deviceWidth(context) / 24, FontWeight.w800),
                        ),
                      ),
                    ),
                  );
                }
              }).toList(),
            ),
          )
          .toList(),
    );
  }
}
