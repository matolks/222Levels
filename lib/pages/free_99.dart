import 'package:levels222_0/pages/home.dart';

class Free99 extends StatelessWidget {
  const Free99({super.key});

  @override
  Widget build(BuildContext context) {
    // Back arrow logic
    void backArrow() {
      List<dynamic> tempList = box.get('section5');
      box.put('currentAd', 0);
      box.put('section5', [tempList[0] + 1, tempList[1]]);
      box.put('currentLevel', 5);
      sectionsRef.doc(userAuth.currentUser!.uid).update({
        'currentSection': 5,
        'section5': [tempList[0] + 1, tempList[1]],
      });
      Navigator.pop(context);
    }

    // Front arrow logic
    void frontArrow() {
      nextSection(5, context);
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Top bar and arrows
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(
                home: true,
                banner1: const Color(0xffF9D342),
                banner2: Colors.black,
                banner3: Colors.black,
                title: "Free 99",
                opacity: 1,
                numbers: allNumbers[32],
                homeFunc: backArrow,
                currentAdCount: '${box.get('currentAd')}',
                totalAdCount: '5',
              ),
              Arrows(
                backgroundColor: AppColors.backgroundColor,
                arrow1: const Color(0xffF9D342),
                arrow2: Colors.black,
                arrow3: Colors.black,
                leftArrowOpacity: 1,
                rightArrowOpacity: 1,
                leftFunction: backArrow,
                rightFunction: frontArrow,
              ),
            ],
          ),
          // levels
        ],
      ),
    );
  }
}
