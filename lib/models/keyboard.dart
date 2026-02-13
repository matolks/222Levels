import 'package:levels222_0/models/wordle_model.dart';
import 'package:levels222_0/pages/home.dart';

List<List<String>> qwerty(isWordle) {
  return !isWordle
      ? [
          ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
          ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
          ['ENT', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL'],
          ['SPACE'],
        ]
      : [
          ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
          ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
          ['ENT', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL'],
        ];
}

// KEYBOARD
class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    this.onSpaceTapped,
    this.letters,
    required this.isWordle,
    this.backgroundColor = AppColors.lightGrey,
    this.textColor = AppColors.backgroundColor,
    this.opacity = 1,
  });

  final void Function(String) onKeyTapped;
  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;
  final VoidCallback? onSpaceTapped;
  final Set<Letter>? letters;
  final bool isWordle;
  final Color? backgroundColor;
  final Color? textColor;
  final double? opacity;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: qwerty(isWordle)
            .map(
              (keyRow) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: keyRow.map((letter) {
                  if (letter == 'DEL') {
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
                          opacity: opacity!,
                          child: Container(
                            width: deviceWidth(context) / 7.75,
                            height: deviceWidth(context) / 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    deviceWidth(context) / 60),
                                color: backgroundColor!),
                            child: Center(
                              child: appText(letter, textColor!,
                                  deviceWidth(context) / 24, FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (letter == 'ENT') {
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
                          opacity: opacity!,
                          child: Container(
                            width: deviceWidth(context) / 7.75,
                            height: deviceWidth(context) / 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    deviceWidth(context) / 60),
                                color: backgroundColor!),
                            child: Center(
                              child: appText(letter, textColor!,
                                  deviceWidth(context) / 24, FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (letter == 'SPACE') {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: deviceWidth(context) / 200,
                        horizontal: deviceWidth(context) / 300,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (onSpaceTapped != null) {
                            onSpaceTapped!();
                          }
                        },
                        child: Opacity(
                          opacity: opacity!,
                          child: Container(
                            width: deviceWidth(context) / 2.75,
                            height: deviceWidth(context) / 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    deviceWidth(context) / 60),
                                color: backgroundColor!),
                            child: Center(
                              child: appText(letter, textColor!,
                                  deviceWidth(context) / 24, FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  Color color = backgroundColor!;
                  if (isWordle == true) {
                    final letterKey = letters!.firstWhere(
                      (e) => e.val == letter,
                      orElse: () => Letter.empty(),
                    );
                    if (letterKey != Letter.empty()) {
                      color = letterKey.backgroundColor;
                    }
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceWidth(context) / 200,
                      horizontal: deviceWidth(context) / 300,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        onKeyTapped(letter);
                      },
                      child: Container(
                        width: deviceWidth(context) / 11,
                        height: deviceWidth(context) / 8,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(deviceWidth(context) / 60),
                          color: color,
                        ),
                        child: Center(
                          child: appText(letter, textColor!,
                              deviceWidth(context) / 24, FontWeight.w800),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
            .toList());
  }
}
