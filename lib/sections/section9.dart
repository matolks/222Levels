import 'dart:async';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:levels222_0/models/keyboard.dart';
import 'package:levels222_0/models/soduko_model.dart';
import 'package:levels222_0/models/wordle_model.dart';
import 'package:levels222_0/pages/home.dart';
import 'package:quiver/iterables.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class Section9 extends StatefulWidget {
  const Section9({super.key});

  @override
  State<Section9> createState() => _Section9State();
}

class _Section9State extends State<Section9> {
  // universal logic
  bool showHome = true;
  int currentPage = 0;
  int currentAdNum = 0;
  int adCap = 6;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;
  List<String> titles = [
    'Le-Word',
    'Wheel of _____',
    'Conexiones',
    'Soduko',
  ];
  // WORDLE
  final List<Word> _board = List.generate(
    6,
    (_) => Word(letters: List.generate(5, (_) => Letter.empty())),
  );
  final List<List<GlobalKey<FlipCardState>>> _flipCardKeys = List.generate(
      6, (_) => List.generate(5, (_) => GlobalKey<FlipCardState>()));
  int _currentWordIndex = 0;
  Word? get _currentWord =>
      _currentWordIndex < _board.length ? _board[_currentWordIndex] : null;
  final Word _solution = Word.fromString(
      fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase());
  final Set<Letter> _keyboardLetter = {};
  bool isSubmitting = false;
  // WHEEL SPIN
  final StreamController<int> _wheelController = StreamController<int>();
  int wheelResult = 0;
  bool goodSpin = false;
  bool canSpin = true;
  //SODUKO
  List<BoxInner> boxInners = [];
  FocusClass focusClass = FocusClass();
  bool isFinish = false;
  bool isFull = false;
  String? tapBoxIndex;

  @override
  void initState() {
    super.initState();
    loadAd();
    currentAdNum = box.get('currentAd');
    generateSoduko();
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
      updateAd(9, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(
        9, currentAdNum, adCap, showAd, context); // input is current section #
  }

  // Back arrow logic
  void backArrow() {
    if (currentPage == 0) {
      backSection(8, context);
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
    if (currentPage > 3) {
      nextSection(9, context);
    }
    setState(() {});
  }

  // Wordle
  Column wordle() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: deviceHeight(context) / 5,
              bottom: deviceHeight(context) / 25),
          child: Board(
            board: _board,
            flipCardKeys: _flipCardKeys,
          ),
        ),
        Keyboard(
          onKeyTapped: onKeyTapped,
          onDeleteTapped: onDeleteTapped,
          onEnterTapped: onEnterTapped,
          isWordle: true,
          letters: _keyboardLetter,
        )
      ],
    );
  }

  void onKeyTapped(String val) {
    _currentWord?.addLetter(val);
    setState(() {});
  }

  void onDeleteTapped() {
    if (_currentWord != null && !isSubmitting) {
      _currentWord!.removeLetter();
      setState(() {});
    }
  }

  // when guess has double letters but answer only has one it make both yellow or both none
  Future<void> onEnterTapped() async {
    String currentWordTemp = "";
    String currentAnswerTemp = "";
    if (!_currentWord!.letters.contains(Letter.empty()) && !isSubmitting) {
      isSubmitting = true;
      // GETS ACTUAL WORD IN A STRING (IN UPPERCASE)
      for (int i = 0; i < _currentWord!.letters.length; i++) {
        currentWordTemp = "$currentWordTemp${_currentWord!.letters[i].val}";
        currentAnswerTemp = "$currentAnswerTemp${_solution.letters[i].val}";
      }
      if (fiveLetterWords.contains(currentWordTemp.toLowerCase())) {
        // IF GUESS DOUBLE LETTER
        if (doubleLetters(_currentWord)) {
          List<dynamic> guessInfo = theDoubleLetter(_currentWord);
          List<dynamic> solutionInfo = theDoubleLetter(_solution);
          // ANSWER AND GUESS HAS DOUBLE LETTERS AND ARE THE SAME (REG)
          if (solutionInfo.isNotEmpty && guessInfo[0] == solutionInfo[0]) {
            for (int i = 0; i < _currentWord!.letters.length; i++) {
              final currentWordLetter = _currentWord!.letters[i];
              final currentSolutionLetter = _solution.letters[i];
              setState(() {
                if (currentWordLetter == currentSolutionLetter) {
                  _currentWord!.letters[i] =
                      currentWordLetter.copyWith(status: LetterStatus.correct);
                } else if (_solution.letters.contains(currentWordLetter)) {
                  _currentWord!.letters[i] =
                      currentWordLetter.copyWith(status: LetterStatus.inWord);
                } else {
                  _currentWord!.letters[i] = currentWordLetter.copyWith(
                      status: LetterStatus.notInWord);
                }
              });
              final letter = _keyboardLetter.firstWhere(
                (e) => e.val == currentWordLetter.val,
                orElse: () => Letter.empty(),
              );
              if (letter.status != LetterStatus.correct) {
                _keyboardLetter
                    .removeWhere((e) => e.val == currentWordLetter.val);
                _keyboardLetter.add(_currentWord!.letters[i]);
              }

              await Future.delayed(
                const Duration(milliseconds: 100),
                () => _flipCardKeys[_currentWordIndex][i]
                    .currentState
                    ?.toggleCard(),
              );
            }
          }
          // ANSWER DOES NOT DOUBLE OR DOUBLE LETTERS ARE DIFFERENT
          else {
            // MAKE SECOND GREEN and first blank
            if (guessInfo[0] == _solution.letters[guessInfo[2]].val) {
              for (int i = 0; i < _currentWord!.letters.length; i++) {
                final currentWordLetter = _currentWord!.letters[i];
                final currentSolutionLetter = _solution.letters[i];
                setState(() {
                  if (currentWordLetter == currentSolutionLetter) {
                    _currentWord!.letters[i] = currentWordLetter.copyWith(
                        status: LetterStatus.correct);
                  } else if (_solution.letters.contains(currentWordLetter)) {
                    if (i == guessInfo[1]) {
                      _currentWord!.letters[i] = currentWordLetter.copyWith(
                          status: LetterStatus.notInWord);
                    } else {
                      _currentWord!.letters[i] = currentWordLetter.copyWith(
                          status: LetterStatus.inWord);
                    }
                  } else {
                    _currentWord!.letters[i] = currentWordLetter.copyWith(
                        status: LetterStatus.notInWord);
                  }
                });
                final letter = _keyboardLetter.firstWhere(
                  (e) => e.val == currentWordLetter.val,
                  orElse: () => Letter.empty(),
                );
                if (letter.status != LetterStatus.correct) {
                  _keyboardLetter
                      .removeWhere((e) => e.val == currentWordLetter.val);
                  _keyboardLetter.add(_currentWord!.letters[i]);
                }

                await Future.delayed(
                  const Duration(milliseconds: 100),
                  () => _flipCardKeys[_currentWordIndex][i]
                      .currentState
                      ?.toggleCard(),
                );
              }
            }
            // MAKE FIRST GREEN OR YELLOW and second blank
            else {
              for (int i = 0; i < _currentWord!.letters.length; i++) {
                final currentWordLetter = _currentWord!.letters[i];
                final currentSolutionLetter = _solution.letters[i];
                setState(() {
                  if (i == guessInfo[1]) {
                    if (guessInfo[0] == _solution.letters[guessInfo[1]].val) {
                      _currentWord!.letters[i] = currentWordLetter.copyWith(
                          status: LetterStatus.correct);
                    } else if (solutionInfo.contains(guessInfo[0])) {
                      _currentWord!.letters[i] = currentWordLetter.copyWith(
                          status: LetterStatus.inWord);
                    } else {
                      _currentWord!.letters[i] = currentWordLetter.copyWith(
                          status: LetterStatus.notInWord);
                    }
                  } else if (currentWordLetter == currentSolutionLetter) {
                    _currentWord!.letters[i] = currentWordLetter.copyWith(
                        status: LetterStatus.correct);
                  } else if (_solution.letters.contains(currentWordLetter)) {
                    if (i == guessInfo[2]) {
                      _currentWord!.letters[i] = currentWordLetter.copyWith(
                          status: LetterStatus.notInWord);
                    } else {
                      _currentWord!.letters[i] = currentWordLetter.copyWith(
                          status: LetterStatus.inWord);
                    }
                  } else {
                    _currentWord!.letters[i] = currentWordLetter.copyWith(
                        status: LetterStatus.notInWord);
                  }
                });
                final letter = _keyboardLetter.firstWhere(
                  (e) => e.val == currentWordLetter.val,
                  orElse: () => Letter.empty(),
                );
                if (letter.status != LetterStatus.correct) {
                  _keyboardLetter
                      .removeWhere((e) => e.val == currentWordLetter.val);
                  _keyboardLetter.add(_currentWord!.letters[i]);
                }

                await Future.delayed(
                  const Duration(milliseconds: 100),
                  () => _flipCardKeys[_currentWordIndex][i]
                      .currentState
                      ?.toggleCard(),
                );
              }
            }
          }
        }
        // REG
        else {
          for (int i = 0; i < _currentWord!.letters.length; i++) {
            final currentWordLetter = _currentWord!.letters[i];
            final currentSolutionLetter = _solution.letters[i];
            setState(
              () {
                if (currentWordLetter == currentSolutionLetter) {
                  _currentWord!.letters[i] =
                      currentWordLetter.copyWith(status: LetterStatus.correct);
                } else if (_solution.letters.contains(currentWordLetter)) {
                  _currentWord!.letters[i] =
                      currentWordLetter.copyWith(status: LetterStatus.inWord);
                } else {
                  _currentWord!.letters[i] = currentWordLetter.copyWith(
                      status: LetterStatus.notInWord);
                }
              },
            );
            final letter = _keyboardLetter.firstWhere(
              (e) => e.val == currentWordLetter.val,
              orElse: () => Letter.empty(),
            );
            if (letter.status != LetterStatus.correct) {
              _keyboardLetter
                  .removeWhere((e) => e.val == currentWordLetter.val);
              _keyboardLetter.add(_currentWord!.letters[i]);
            }
            await Future.delayed(
              const Duration(milliseconds: 100),
              () => _flipCardKeys[_currentWordIndex][i]
                  .currentState
                  ?.toggleCard(),
            );
          }
        }
        checkWinOrLoss();
        isSubmitting = false;
        setState(() {});
      } else {
        isSubmitting = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.darkerGrey,
            duration: Durations.long1,
            content: appText(
                '$currentWordTemp is not a valid guess',
                AppColors.lightGrey,
                deviceWidth(context) / 18,
                FontWeight.w500),
          ),
        );
      }
    }
  }

  // CHECKS WINS OR LOSS
  void checkWinOrLoss() {
    if (_currentWord!.wordString == _solution.wordString) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.darkerGrey,
          duration: const Duration(seconds: 3),
          content: appText(
            'Congrats.. hope your lucky',
            AppColors.lightGrey,
            deviceWidth(context) / 18,
            FontWeight.w500,
          ),
        ),
      );
    } else if (_currentWordIndex == 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.darkerGrey,
          duration: const Duration(seconds: 3),
          content: appText('${_solution.wordString} was the answer',
              AppColors.lightGrey, deviceWidth(context) / 18, FontWeight.w500),
        ),
      );
    } else {
      _currentWordIndex++;
    }
  }

  // CHECK IF GUESS OR ANSWER HAS DOUBLE LETTERS
  bool doubleLetters(tempWord) {
    for (int i = 0; i < 5; i++) {
      for (int j = i + 1; j < 5; j++) {
        if (tempWord.letters[i] == tempWord.letters[j]) {
          return true;
        }
      }
    }
    return false;
  }

  // GET LETTER AND INDEX THAT IS DOUBLED
  List<dynamic> theDoubleLetter(tempWord) {
    for (int i = 0; i < 5; i++) {
      for (int j = i + 1; j < 5; j++) {
        if (tempWord.letters[i] == tempWord.letters[j]) {
          return [tempWord.letters[i].val.toUpperCase(), i, j];
        }
      }
    }
    return [];
  }

  // Wheel Spin
  Column spinTheWheel() {
    return Column(
      children: [
        // WHEEL
        Padding(
          padding: EdgeInsets.only(
              top: deviceHeight(context) / 5,
              bottom: deviceHeight(context) / 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: deviceWidth(context) / 1.1,
                height: deviceWidth(context) / 1.1,
                child: FortuneWheel(
                  animateFirst: false,
                  selected: _wheelController.stream,
                  indicators: const <FortuneIndicator>[
                    FortuneIndicator(
                      alignment: Alignment.topCenter,
                      child: TriangleIndicator(
                        color: AppColors.lightGrey,
                        width: 20,
                        height: 20,
                        elevation: 0,
                      ),
                    ),
                  ],
                  onAnimationEnd: () {
                    if (goodSpin) {
                      setState(() {});
                    }
                  },
                  items: [
                    // RIGHT ONE
                    for (int i = 0; i < 25; i++) ...<FortuneItem>{
                      const FortuneItem(
                        child: Text(''),
                        style: FortuneItemStyle(
                            color: Color(0xFF141846), borderWidth: 0),
                      ),
                    },
                    // WRONG ONES
                    for (int i = 0; i < 75; i++) ...<FortuneItem>{
                      const FortuneItem(
                        child: Text(''),
                        style: FortuneItemStyle(
                            color: Color(0xFFEC8B5E), borderWidth: 0),
                      ),
                    }
                  ],
                ),
              ),
            ],
          ),
        ),
        // BUTTON
        GestureDetector(
            onTap: () {
              if (canSpin) {
                canSpin = false;
                wheelResult = Fortune.randomInt(0, 100);
                if (wheelResult < 25) {
                  goodSpin = true;
                }
                _wheelController.add(wheelResult);
                setState(() {});
              }
            },
            child: button(
                context,
                const Color(0xffec8b5e),
                const Color(0xff141846),
                const Color(0xffec8b5e),
                'Spin',
                const Color(0xff141846),
                null)),
      ],
    );
  }

  // Connexiones NEED TO DO
  Column connections() {
    return const Column(
      children: [],
    );
  }

  // Soduko
  Column sodukoLevel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // actual board
        Container(
          margin: EdgeInsets.only(
            left: deviceWidth(context) / 20,
            right: deviceWidth(context) / 20,
          ),
          padding: EdgeInsets.only(
            left: deviceWidth(context) / 100,
            right: deviceWidth(context) / 100,
          ),
          width: deviceWidth(context),
          color: AppColors.backgroundColor,
          child: GridView.builder(
            itemCount: boxInners.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemBuilder: (buildContext, index) {
              BoxInner boxInner = boxInners[index];
              return Container(
                alignment: Alignment.center,
                color: AppColors.darkerGrey,
                child: GridView.builder(
                  itemCount: boxInner.blokChars.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  itemBuilder: (buildContext, indexChar) {
                    BlokChar blokChar = boxInner.blokChars[indexChar];
                    Color color = const Color(0xFFEC8B5E);
                    // EDIT COLORS
                    if (isFinish) {
                      color = const Color.fromARGB(255, 18, 215, 48);
                    } else if (tapBoxIndex == "$index-$indexChar") {
                      color = const Color(0xFFEC8B5E).withOpacity(.8);
                    } else if (blokChar.isDefault) {
                      color = const Color(0xFFEC8B5E).withOpacity(.5);
                    }
                    return Container(
                      alignment: Alignment.center,
                      color: color,
                      child: TextButton(
                          style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory),
                          onPressed: blokChar.isDefault
                              ? null
                              : () => setFocus(index, indexChar),
                          child: appText(
                              "${blokChar.text}",
                              AppColors.lightGrey,
                              deviceWidth(context) / 30,
                              FontWeight.w500)),
                    );
                  },
                ),
              );
            },
          ),
        ),
        // INPUTS
        SizedBox(
          width: deviceWidth(context) / 1.1,
          height: deviceHeight(context) / 5,
          child: Row(
            children: [
              //NUMBERS
              SizedBox(
                  width: deviceWidth(context) / 1.8,
                  height: deviceHeight(context) / 5,
                  child: Column(
                    children: [
                      // 1-3
                      Row(
                        children: [
                          for (int i = 0; i < 3; i++) ...<GestureDetector>{
                            GestureDetector(
                              onTap: () {
                                setInput(i + 1);
                                setState(() {});
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.all(deviceHeight(context) / 360),
                                width: deviceWidth(context) / 5.4 -
                                    (deviceHeight(context) / 180),
                                height: 22 * deviceHeight(context) / 360,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF141846),
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth(context) / 75)),
                                child: appText('${i + 1}', AppColors.lightGrey,
                                    deviceWidth(context) / 20, FontWeight.w700),
                              ),
                            )
                          }
                        ],
                      ),
                      // 4-6
                      Row(
                        children: [
                          for (int i = 3; i < 6; i++) ...<GestureDetector>{
                            GestureDetector(
                              onTap: () {
                                setInput(i + 1);
                                setState(() {});
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.all(deviceHeight(context) / 360),
                                width: deviceWidth(context) / 5.4 -
                                    (deviceHeight(context) / 180),
                                height: 22 * deviceHeight(context) / 360,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF141846),
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth(context) / 75)),
                                child: appText('${i + 1}', AppColors.lightGrey,
                                    deviceWidth(context) / 20, FontWeight.w700),
                              ),
                            )
                          }
                        ],
                      ),
                      // 7-9
                      Row(
                        children: [
                          for (int i = 6; i < 9; i++) ...<GestureDetector>{
                            GestureDetector(
                              onTap: () {
                                setInput(i + 1);
                                setState(() {});
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.all(deviceHeight(context) / 360),
                                width: deviceWidth(context) / 5.4 -
                                    (deviceHeight(context) / 180),
                                height: 22 * deviceHeight(context) / 360,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF141846),
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth(context) / 75)),
                                child: appText('${i + 1}', AppColors.lightGrey,
                                    deviceWidth(context) / 20, FontWeight.w700),
                              ),
                            )
                          }
                        ],
                      )
                    ],
                  )),
              // CLEAR & SUMBIT
              SizedBox(
                height: deviceHeight(context) / 5,
                width:
                    (deviceWidth(context) / 1.1) - deviceWidth(context) / 1.8,
                child: Column(
                  children: [
                    // clear
                    GestureDetector(
                      onTap: () {
                        setInput(null);
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.all(deviceHeight(context) / 360),
                        width: ((deviceWidth(context) / 1.1) -
                                deviceWidth(context) / 1.8) -
                            (deviceHeight(context) / 180),
                        height: 34 * deviceHeight(context) / 360,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xFF141846),
                            borderRadius: BorderRadius.circular(
                                deviceWidth(context) / 75)),
                        child: appText('Clear', AppColors.lightGrey,
                            deviceWidth(context) / 20, FontWeight.w700),
                      ),
                    ),
                    // submit
                    GestureDetector(
                      onTap: () {
                        if (isFull) {
                          checkFinish();
                          setState(() {});
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(deviceHeight(context) / 360),
                        width: ((deviceWidth(context) / 1.1) -
                                deviceWidth(context) / 1.8) -
                            (deviceHeight(context) / 180),
                        height: 34 * deviceHeight(context) / 360,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: isFull
                                ? const Color(0xFF141846)
                                : const Color(0xFF141846).withOpacity(.4),
                            borderRadius: BorderRadius.circular(
                                deviceWidth(context) / 75)),
                        child: appText(
                            'Submit',
                            isFull
                                ? AppColors.lightGrey
                                : AppColors.lightGrey.withOpacity(.4),
                            deviceWidth(context) / 20,
                            FontWeight.w700),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // SETS UP PUZZLE
  void generateSoduko() {
    isFinish = false;
    focusClass = FocusClass();
    tapBoxIndex = null;
    generatePuzzle();
    setState(() {});
  }

  // CHECKS FINISH
  void checkFinish() {
    int totalUnfinish = boxInners
        .map((e) => e.blokChars)
        .expand((element) => element)
        .where((element) => !element.isCorrect)
        .length;
    isFinish = totalUnfinish == 0;
  }

  // CHECKS IF FULL
  void checkIfFull() {
    int totalFull = boxInners
        .map((e) => e.blokChars)
        .expand((element) => element)
        .where((element) => element.text == "")
        .length;
    isFull = totalFull == 0;
  }

  // GENERATES PUZZLE
  generatePuzzle() {
    boxInners.clear();
    var sodukoGenerator = SudokuGenerator(emptySquares: 48); //54
    List<List<List<int>>> completes = partition(sodukoGenerator.newSudokuSolved,
            sqrt(sodukoGenerator.newSudoku.length).toInt())
        .toList();
    partition(sodukoGenerator.newSudoku,
            sqrt(sodukoGenerator.newSudoku.length).toInt())
        .toList()
        .asMap()
        .entries
        .forEach(
      (entry) {
        List<int> tempListCompletes =
            completes[entry.key].expand((element) => element).toList();
        List<int> tempList = entry.value.expand((element) => element).toList();

        tempList.asMap().entries.forEach((entryIn) {
          int index =
              entry.key * sqrt(sodukoGenerator.newSudoku.length).toInt() +
                  (entryIn.key % 9).toInt() ~/ 3;

          if (boxInners.where((element) => element.index == index).isEmpty) {
            boxInners.add(BoxInner(index, []));
          }

          BoxInner boxInner =
              boxInners.where((element) => element.index == index).first;

          boxInner.blokChars.add(BlokChar(
            entryIn.value == 0 ? "" : entryIn.value.toString(),
            index: boxInner.blokChars.length,
            isDefault: entryIn.value != 0,
            isCorrect: entryIn.value != 0,
            correctText: tempListCompletes[entryIn.key].toString(),
          ));
        });
      },
    );
  }

  // SETS FOCUS
  setFocus(int index, int indexChar) {
    tapBoxIndex = "$index-$indexChar";
    focusClass.setData(index, indexChar);
    setState(() {});
  }

  // SETS INPUT
  setInput(int? number) {
    if (focusClass.indexBox == null) return;
    if (boxInners[focusClass.indexBox!].blokChars[focusClass.indexChar!].text ==
            number.toString() ||
        number == null) {
      boxInners.map((element) {
        element.clearExist();
        element.clearFocus();
      });
      boxInners[focusClass.indexBox!]
          .blokChars[focusClass.indexChar!]
          .setEmpty();
      tapBoxIndex = null;
      isFinish == false;
    } else {
      boxInners[focusClass.indexBox!]
          .blokChars[focusClass.indexChar!]
          .setText("$number");
    }
    checkIfFull();
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
                banner1: const Color.fromARGB(255, 98, 106, 193),
                banner2: const Color(0xffec8b5e),
                banner3: const Color(0xffec8b5e),
                title: titles[currentPage],
                opacity: 1,
                numbers: allNumbers[currentPage + 52],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xffec8b5e),
                arrow2: const Color.fromARGB(255, 98, 106, 193),
                arrow3: const Color(0xffec8b5e),
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // levels
          IndexedStack(
            index: currentPage,
            children: <Widget>[
              wordle(),
              spinTheWheel(),
              connections(),
              sodukoLevel(),
            ],
          )
        ],
      ),
    );
  }
}
