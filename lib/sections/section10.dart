import 'package:levels222_0/pages/home.dart';

// NEED TO ALPHABETIC MARKERS IN THE GUESS PART

class Section10 extends StatefulWidget {
  const Section10({super.key});

  @override
  State<Section10> createState() => _Section10State();
}

class _Section10State extends State<Section10> {
  // universal logic
  bool showHome = true;
  int currentPage = 0;
  int currentAdNum = 0;
  int adCap = 7;
  double leftArrowOpacity = 1;
  double rightArrowOpacity = .2;
  String userGuess = 'Guess?';
  String currentAnswer = ' ';
  bool hasGuessed = false;

  @override
  void initState() {
    super.initState();
    setAnswer();
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
      updateAd(10, currentAdNum, context);
      isVideoAdReady = false;
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      isVideoAdReady = false;
    });
  }

  // checks if Ad is needed
  void checkAd() {
    updateAttempt(10, currentAdNum, adCap, showAd, context);
  }

  // Back arrow logic
  void backArrow() {
    if (currentPage == 0) {
      backSection(9, context);
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
    userGuess = 'Guess?';
    hasGuessed = false;
    setAnswer();
    if (currentPage > 7) {
      nextSection(10, context);
    }
    setState(() {});
  }

  // sets answer
  void setAnswer() {
    List<String> temp = movieShowAnswers.keys.toList();
    temp.shuffle();
    currentAnswer = temp[2];
  }

  // changes guess
  void changeGuess(String newGuess) {
    userGuess = newGuess;
    if (!hasGuessed) {
      hasGuessed = true;
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
                banner1: const Color(0xfff1f4ff),
                banner2: const Color(0xffa2a2a1),
                banner3: const Color(0xffa2a2a1),
                title: "Guess the Show/Movie",
                opacity: 1,
                numbers: allNumbers[currentPage + 56],
                homeFunc: () {
                  Navigator.pop(context);
                },
                currentAdCount: '$currentAdNum',
                totalAdCount: '$adCap',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xffa2a2a1),
                arrow2: const Color(0xfff1f4ff),
                arrow3: const Color(0xffa2a2a1),
                leftArrowOpacity: leftArrowOpacity,
                rightArrowOpacity: rightArrowOpacity,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // levels
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // emojis
              Container(
                color: AppColors.backgroundColor,
                width: deviceWidth(context),
                height: deviceHeight(context) / 6,
                child: Center(
                  child: appText(
                      movieShowAnswers[currentAnswer]!,
                      AppColors.backgroundColor,
                      deviceWidth(context) / 10,
                      FontWeight.w600),
                ),
              ),
              // drop down.
              Padding(
                padding: EdgeInsets.only(
                    top: deviceHeight(context) / 14,
                    bottom: deviceHeight(context) / 10),
                child: GestureDetector(
                  onTap: () {
                    List<String> temp = movieShowAnswers.keys.toList();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: deviceHeight(context) / 10,
                                      bottom: deviceHeight(context) / 40),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: deviceWidth(context) / 1.25,
                                      height: deviceHeight(context) / 15,
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundColor,
                                        borderRadius: BorderRadius.circular(
                                          deviceWidth(context) / 20,
                                        ),
                                        border: Border.all(
                                            color: const Color(0xfff1f4ff),
                                            width: 1),
                                      ),
                                      child: Center(
                                        child: appText(
                                            'Back',
                                            const Color(0xfff1f4ff),
                                            deviceWidth(context) / 18,
                                            FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (int i = 0;
                                            i < temp.length;
                                            i++) ...<Padding>{
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top:
                                                    deviceHeight(context) / 150,
                                                bottom: deviceHeight(context) /
                                                    150),
                                            child: GestureDetector(
                                              onTap: () {
                                                changeGuess(temp[i]);
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xfff1f4ff),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          deviceWidth(context) /
                                                              25),
                                                  border: Border.all(
                                                      color:
                                                          AppColors.darkerGrey,
                                                      width: 1),
                                                ),
                                                width:
                                                    deviceWidth(context) / 1.1,
                                                height:
                                                    deviceHeight(context) / 14,
                                                child: Center(
                                                  child: appText(
                                                      temp[i],
                                                      AppColors.darkerGrey,
                                                      deviceWidth(context) / 22,
                                                      FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          )
                                        }
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: deviceWidth(context) / 1.3,
                    height: deviceHeight(context) / 10,
                    decoration: BoxDecoration(
                      color: AppColors.darkGrey,
                      border: Border.all(
                        width: 2,
                        color: hasGuessed
                            ? const Color(0xfff1f4ff)
                            : AppColors.middleGrey,
                      ),
                      borderRadius:
                          BorderRadius.circular(deviceWidth(context) / 20),
                    ),
                    child: Center(
                      child: appText(
                          userGuess,
                          hasGuessed
                              ? const Color(0xfff1f4ff)
                              : AppColors.middleGrey,
                          deviceWidth(context) / 18,
                          FontWeight.w600),
                    ),
                  ),
                ),
              ),
              // guess
              GestureDetector(
                onTap: () {
                  if (hasGuessed) {
                    print(userGuess == currentAnswer);
                  }
                },
                child: Opacity(
                  opacity: hasGuessed ? 1 : 0,
                  child: button(
                      context,
                      const Color(0xffa2a2a1),
                      const Color(0xfff1f4ff),
                      const Color(0xffa2a2a1),
                      "Submit Guess",
                      const Color(0xfff1f4ff),
                      null),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Map<String, String> movieShowAnswers = {
  'Adventure Time': '🗡️👑🍔🎨🌈',
  'American Psycho': '💼👔🔪🩸🌆😱',
  'Avatar: The Last Airbender': '🌊🔥🌪️🌏🌀',
  'Avengers: Endgame': '🦸‍♂️💎👊🟣👽',
  'Better Call Saul': '📉👨‍⚖️💼⚖️📜',
  'BoJack Horseman': '🐴🎬🍸😢📺',
  'Braveheart': '⚔️🛡️🏴💔🔵⚪',
  'Breaking Bad': '👨‍🔬⚗️🔵💊💰',
  'Brooklyn Nine-Nine': '🚔🗽👮‍♂️🤣',
  'Catch Me If You Can': '🎭🏃🛫💰👮‍♂️',
  'Coach Carter': '🏀📚💪🏾🎓✨',
  'Dexter': '🧪🕵️‍♂️🔪🩸😈',
  'E.T. the Extra-Terrestrial': '👽🚲🌕📞🪐',
  'Euphoria': '💊💔🎭🌟💄',
  'Fight Club': '👊🤫🧼🏢💥',
  'Forest Gump': '🇺🇸🎖️🏃‍♂️🍫🦐',
  'Friends': '🛋️☕🏙️📺🤣',
  'Game of Thrones': '🐉⚔️👑🔥❄️',
  'Gladiator': '⚔️🛡️🏟️👑💔',
  'Good Will Hunting': '🧠🛠️📝👨‍🏫❤️',
  'Gravity Falls': '👫🧩🔦🏕🌲🌀',
  'How I Met Your Mother': '🍻🗽❤️💼🤣',
  'Inception': '🛌🌀⏰🧠💡',
  'Interstellar': '🚀🪐⏳🌌❤️',
  'It\'s Always Sunny in Philadelphia': '☀️🏙️🤣🍻',
  'Jaws': '🦈🚤🌊⚠️',
  'Jurassic Park': '🦖🦕🚙🏃‍♀️🏃‍♂️',
  'Miracle Ice': '🏒🥇🇺🇸❄️🏆',
  'Moneyball': '⚾💡📊📈💰',
  'Momma Mia': '🏝️👗❤️🎤🎶',
  'Modern Family': '👨‍👩‍👧‍👦🏠📺❤️🤣📺',
  'Naruto': '🥷🍥💨👊🦊⛩️',
  'One Piece': '👒🏴‍☠️🛳️🍖💪🌟',
  'Peaky Blinders': '🎩🚬💰🔪🇬🇧👊🍺',
  'Prisoners': '👧🔍🕵️‍♂️🚪⛓️😨🌧️',
  'Regular Show': '🐦🦝🎮🛋️🤣',
  'Rick and Morty': '👴🧪👨‍🔬👽🛸😂',
  'Rocky': '🥊🏆💪🇺🇸🎶',
  'Saving Private Ryan': '🌊🪖💥✝️🪦🎖️',
  'Shrek': '🟢👹🐴🏰🐉🧅👸',
  'Shutter Island': '🏝️🏥🔐🧠🕵️‍♂️🌫️😱',
  'South Park': '👦🎒🏫🏔️🤣🔞',
  'SpongeBob': '🐌🍍🦑🌊🍔🦀',
  'Star Wars': '🌟⚔️🤖👾🚀🌌👑',
  'Stranger Things': '🚲📺🧇🔦🌲',
  'The Sandlot': '⚾👦🏽🐶🤮🎢',
  'The Shawshank Redemption': '🪜⛓️👨‍💼🏴‍☠️🔓⛈️',
  'The Simpsons': '🟡🏠👨‍👩‍👧‍👦🍩😂📺',
  'The Sopranos': '🍝🕴️💰🔪🇮🇹🚬',
  'The Big Short': ' 📉🏦💸💡🏠🧐🎥',
  'The Blind Side': '🏈🏠👩‍👦‍👦❤️📚🎓',
  'The Boys': '🦸‍♂️🩸💥⚡🤬🌃🔥',
  'The Dark Knight Trilogy': '🦇🏙️🃏👊🔥',
  'The Departed': '👮🔫💼👿☘️🏢💣',
  'The Godfather': '🕴️🍷🔫🎻🇮🇹🔪',
  'The Great Gatsby': '🎩🥂💎🏰🚗🌺',
  'The Hobbit Trilogy': '🧙‍♂️⚔️💍🐉🏞️🏰🗺️',
  'The Imitation Game': '🧑‍💻🕵️‍♂️📖📜💡🇬🇧📡',
  'The Office': '🎥🏢☕📄👔😂',
  'The Pursuit of Happieness': '👨‍👦💼📊😔❤️🌟😊',
  'The Walking Dead': '🧟‍♂️🔪🏹🌾🏠',
  'The Wizard of Oz': '🌈🌀🧙🏻‍♀️👠🦁✨',
  'Titanic': '🚢💔🌊🎻🌹😢',
  'Whiplash': '🥁🎼😡👨‍🏫🎵',
  'Wolf of Wall Street': '🤑📈💼💊🚁🍸🎉',
};
