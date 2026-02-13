import 'package:confetti/confetti.dart';
import 'package:levels222_0/pages/home.dart';

class Section1 extends StatefulWidget {
  const Section1({super.key});

  @override
  State<Section1> createState() => _Section1State();
}

class _Section1State extends State<Section1> {
  // Universal Logic
  bool showHome = true;
  int currentPage = 0;
  int quizLogic = 0;
  bool winnerOrLoser = false;
  int numRight = 0;
  int currentAdNum = 0;
  int adCap = 3;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;
  // Questions
  List<int> selected = [5, 5, 5, 5, 5, 5, 5];
  Map<String, List<List<String>>> questionData = {
    'What State in the United States is known for the most strange activities?':
        [
      [
        'Ohio',
        'Philadelphia',
        'Florida',
        'Wyoming (Doesn\'t Exist)',
        'Connecticut'
      ],
      ['Ohio'],
    ],
    'What song was played at the Tik Tok Rizz party?': [
      ['Carnival', 'Cotton Eye Joe', 'Mo Bamba', 'Sicko Mode', 'Not Like Us'],
      ['Carnival']
    ],
    'What game comes to mind when you hear the word "sus"?': [
      ['Among Us', 'Minecraft', 'Fortnite', 'Hop Scotch', 'Roblox'],
      ['Among Us'],
    ],
    'What Live Streamer is known for taxing food?': [
      ['Fanum', 'CaseOh (👀)', 'Kai Cenat', 'Lacy', 'PewDiePie'],
      ['Fanum']
    ],
    'What\'s up Brother ☝️': [
      ['Sketch', 'The Sky', 'Looksmaxxing', 'Blue Tie', 'Skibidi'],
      ['Sketch'],
    ],
    'What\'s it called when someone is giving a lot of compliments?': [
      ['Glazing', 'Gooning', 'Cool', 'Nice?', 'Simp'],
      ['Glazing']
    ],
    'Finish the lyrics. "We can go gyatt for gyatt, f*ck that we can go _________"':
        [
      [
        'Rizz for rizz',
        'Goon for goon',
        'Edge for edge',
        'Sigma for sigma',
        'To Cleveland 💀'
      ],
      ['Rizz for rizz'],
    ],
    'What is the purple deep fried shake called?': [
      [
        'Grimace Shake',
        'Mint Berry Crunch (🐐)',
        'Skibidi Shake',
        'Grape',
        'Shamarock Shake'
      ],
      ['Grimace Shake'],
    ],
    'What is it called when someone won\'t stop talking?': [
      ['Yapping', 'Quandale Dingle', 'Beta', 'A Politician', 'Chatterbox'],
      ['Yapping'],
    ],
    'Fill in the blank. "Just put the _____ in the bag"': [
      ['Fries', 'Money', 'Burger', 'Schmeckle', 'VBucks'],
      ['Fries']
    ],
    'What do you call the energy someone gives off?': [
      ['Aura', 'Mewing', 'Looksmax', 'Mogging', '-1000 for not knowing'],
      ['Aura'],
    ],
    'Who do you stick your gyatt out for?': [
      [
        'The Rizzler',
        'Livvy',
        'Skibidi Toilet',
        'Teenage Mutant Ninja Turtle',
        'Miles Morales'
      ],
      ['The Rizzler']
    ],
    'What meme is still actually suprisingly very popular?': [
      ['Low Taper Fade', 'Doge', 'Covid 19', 'PewDiePie vs TSeries', 'Math'],
      ['Low Taper Fade'],
    ],
    'What does Red Larva say?': [
      ['oí oí oí', 'Nothing', '+100 aura', 'Your SSN', 'Gyatt'],
      ['oí oí oí']
    ],
    'Finish the lyrics. "Your so skibidi, your so _________"': [
      ['Fanum Tax', 'Alpha', 'Edgemaxxing', 'Mog Champ', 'Ohio'],
      ['Fanum Tax'],
    ],
    'What is it called when somone goes into a justified rampage?': [
      [
        'Reasonable Crash Out',
        'Rage',
        'Goblin Mode',
        'Baby Gronk',
        'Mew',
      ],
      ['Reasonable Crash Out']
    ],
    'Who is the Pig calling you at 3 a.m.?': [
      [
        'John Pork',
        'Freak Bob',
        'Hamm',
        'Wilbur',
        'Porkchop',
      ],
      ['John Pork']
    ]
  };
  List<String> questions = [];
  List<List<String>> responses = [];
  // Confetti
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    setQuestions();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    loadAd();
    currentAdNum = box.get('currentAd') ?? 0;
  }

  @override
  void dispose() {
    _confettiController.dispose();
    videoAd?.dispose();
    super.dispose();
  }

  // Shows Ad and Updates Counter
  void showAd() {
    videoAd!.show();
    videoAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
      updateAd(1, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // Updates Attempt and Shows Ad
  void checkAd() {
    updateAttempt(1, currentAdNum, adCap, showAd, context);
  }

  // Back Arrow Logic
  void backArrow() {
    if (currentPage == 0) {
      Navigator.pop(context);
    } else if (currentPage + quizLogic < 7) {
      if (currentPage == 1) {
        showHome = true;
      }
      rightArrowOpacity = 1;
      currentPage--;
      setState(() {});
    }
  }

  // Front Arrow Logic
  void frontArrow() {
    if (winnerOrLoser) {
      nextSection(1, context);
    }
    if (selected[currentPage] < 5) {
      if (showHome) {
        showHome = false;
      }
      if (currentPage < 6) {
        currentPage++;
        if (selected[currentPage] == 5) {
          rightArrowOpacity = .2;
        }
        setState(() {});
      } else if (currentPage + quizLogic == 6) {
        leftArrowOpacity = .2;
        submitQuiz();
        quizLogic++;
        setState(() {});
      }
    }
  }

  // Generates Random Questions
  void setQuestions() {
    List<String> temp = questionData.keys.toList();
    temp.shuffle();
    temp.shuffle();
    for (int i = 0; i < temp.length; i++) {
      questions.add(temp[i]);
      List<List<String>> tempData = questionData[temp[i]]!;
      responses.add(tempData[0]);
      responses[i].shuffle();
    }
  }

  // Checks Quiz
  void submitQuiz() {
    for (int i = 0; i < selected.length; i++) {
      List<List<String>> tempData = questionData[questions[i]]!;
      String tempAnswer = tempData[1][0];
      int tempInt = responses[i].indexOf(tempAnswer);
      if (tempInt == selected[i]) {
        numRight++;
      }
    }
    if (numRight == 7) {
      winnerOrLoser = true;
      _confettiController.play();
      setState(() {});
    } else {
      rightArrowOpacity = .2;
      setState(() {});
    }
  }

  // Questions Body
  SafeArea questionsBody() {
    return SafeArea(
      child: SizedBox(
        width: deviceWidth(context),
        child: Column(
          children: [
            // QUESTION
            Padding(
              padding: EdgeInsets.only(
                top: deviceWidth(context) / 5.5 + deviceWidth(context) / 8,
              ),
              child: SizedBox(
                height: deviceHeight(context) / 7,
                child: Column(
                  children: [
                    SizedBox(
                      width: deviceWidth(context) / 1.1,
                      child: appText(
                          questions[currentPage],
                          AppColors.lightGrey,
                          deviceWidth(context) / 22,
                          FontWeight.w600),
                    ),

                    // QUESTION #
                    appText(
                        'Question ${currentPage + 1} of 7',
                        AppColors.darkGrey,
                        deviceWidth(context) / 27,
                        FontWeight.w400),
                  ],
                ),
              ),
            ),
            // ANSWERS
            Padding(
              padding: EdgeInsets.only(bottom: deviceHeight(context) / 38),
              child: GestureDetector(
                onTap: () {
                  selected[currentPage] = 0;
                  rightArrowOpacity = 1;
                  setState(() {});
                },
                child: button(
                    context,
                    selected[currentPage] == 0
                        ? AppColors.lightGrey
                        : AppColors.middleGrey,
                    selected[currentPage] == 0
                        ? AppColors.lightGrey
                        : AppColors.backgroundColor,
                    selected[currentPage] == 0
                        ? AppColors.darkGrey
                        : AppColors.backgroundColor,
                    responses[currentPage][0],
                    selected[currentPage] == 0
                        ? AppColors.lightGrey
                        : AppColors.middleGrey,
                    null),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: deviceHeight(context) / 38),
              child: GestureDetector(
                onTap: () {
                  selected[currentPage] = 1;
                  rightArrowOpacity = 1;
                  setState(() {});
                },
                child: button(
                    context,
                    selected[currentPage] == 1
                        ? AppColors.lightGrey
                        : AppColors.middleGrey,
                    selected[currentPage] == 1
                        ? AppColors.lightGrey
                        : AppColors.backgroundColor,
                    selected[currentPage] == 1
                        ? AppColors.darkGrey
                        : AppColors.backgroundColor,
                    responses[currentPage][1],
                    selected[currentPage] == 1
                        ? AppColors.lightGrey
                        : AppColors.middleGrey,
                    null),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: deviceHeight(context) / 38),
              child: GestureDetector(
                onTap: () {
                  selected[currentPage] = 2;
                  rightArrowOpacity = 1;
                  setState(() {});
                },
                child: button(
                    context,
                    selected[currentPage] == 2
                        ? AppColors.lightGrey
                        : AppColors.middleGrey,
                    selected[currentPage] == 2
                        ? AppColors.lightGrey
                        : AppColors.backgroundColor,
                    selected[currentPage] == 2
                        ? AppColors.darkGrey
                        : AppColors.backgroundColor,
                    responses[currentPage][2],
                    selected[currentPage] == 2
                        ? AppColors.lightGrey
                        : AppColors.middleGrey,
                    null),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: deviceHeight(context) / 38),
              child: GestureDetector(
                onTap: () {
                  selected[currentPage] = 3;
                  rightArrowOpacity = 1;
                  setState(() {});
                },
                child: button(
                    context,
                    selected[currentPage] == 3
                        ? AppColors.lightGrey
                        : AppColors.middleGrey,
                    selected[currentPage] == 3
                        ? AppColors.lightGrey
                        : AppColors.backgroundColor,
                    selected[currentPage] == 3
                        ? AppColors.darkGrey
                        : AppColors.backgroundColor,
                    responses[currentPage][3],
                    selected[currentPage] == 3
                        ? AppColors.lightGrey
                        : AppColors.middleGrey,
                    null),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: deviceHeight(context) / 38),
              child: GestureDetector(
                onTap: () {
                  selected[currentPage] = 4;
                  rightArrowOpacity = 1;
                  setState(() {});
                },
                child: button(
                    context,
                    selected[currentPage] == 4
                        ? AppColors.lightGrey
                        : AppColors.middleGrey,
                    selected[currentPage] == 4
                        ? AppColors.lightGrey
                        : AppColors.backgroundColor,
                    selected[currentPage] == 4
                        ? AppColors.darkGrey
                        : AppColors.backgroundColor,
                    responses[currentPage][4],
                    selected[currentPage] == 4
                        ? AppColors.lightGrey
                        : AppColors.middleGrey,
                    null),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Winner
  SafeArea correctQuiz() {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            width: deviceWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appText('CONGRATULATIONS', AppColors.lightGrey,
                    deviceWidth(context) / 15, FontWeight.w600),
                appText('7/7 you passed', AppColors.lightGrey,
                    deviceWidth(context) / 30, FontWeight.w400),
                appText('Your brain is cooked 💀', AppColors.lightGrey,
                    deviceWidth(context) / 22, FontWeight.w400)
              ],
            ),
          ),
          SizedBox(
            width: deviceWidth(context),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                gravity: 0.5,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Loser
  SafeArea failQuiz() {
    return SafeArea(
      child: SizedBox(
        width: deviceWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appText('🫵🤣', AppColors.lightGrey, deviceWidth(context) / 5,
                FontWeight.w600),
            appText('Your brain is healthy', AppColors.lightGrey,
                deviceWidth(context) / 22, FontWeight.w400),
            appText('$numRight/7 you failed', AppColors.lightGrey,
                deviceWidth(context) / 30, FontWeight.w400),
            Padding(
              padding: EdgeInsets.only(
                  top: deviceHeight(context) / 30,
                  bottom: deviceHeight(context) / 10),
              child: SizedBox(
                width: deviceWidth(context) / 1.2,
                child: appText(
                    'Go scroll on TikTok for hours and try again',
                    AppColors.lightGrey,
                    deviceWidth(context) / 25,
                    FontWeight.w400),
              ),
            ),
            GestureDetector(
              onTap: () {
                checkAd();
              },
              child: button(context, AppColors.babyv, AppColors.lightGrey,
                  AppColors.babyv, '👈 Try Again', AppColors.darkerGrey, null),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Top Bar and Arrows
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(
                home: showHome,
                banner1: AppColors.lightGrey,
                banner2: AppColors.babyv,
                banner3: AppColors.babyv,
                title: currentPage + quizLogic < 7
                    ? "OG Brain Rot Quiz"
                    : "You Pass?",
                opacity: 1,
                numbers: allNumbers[currentPage + quizLogic],
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
          // Questions
          IndexedStack(
            index: quizLogic,
            children: <Widget>[
              questionsBody(),
              winnerOrLoser ? correctQuiz() : failQuiz(),
            ],
          )
        ],
      ),
    );
  }
}
