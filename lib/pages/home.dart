import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:levels222_0/assets/rive/rive_util.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/image.dart' as flutter_image;
import 'package:levels222_0/data%20models/password.dart';
import 'package:levels222_0/data%20models/sections.dart';
import 'package:levels222_0/data%20models/user.dart';
import 'package:levels222_0/data%20models/winner.dart';
import 'package:levels222_0/pages/settings.dart';
import 'package:levels222_0/pages/stats.dart';
import 'package:levels222_0/pages/terms_policy.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:levels222_0/pages/accept_terms.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:levels222_0/models/app_util_export.dart';
import 'package:levels222_0/sections/sections_export.dart';
export 'package:levels222_0/models/app_util_export.dart';
export 'package:google_mobile_ads/google_mobile_ads.dart';
export 'package:levels222_0/sections/sections_export.dart';

/////////////
// GLOBALS //
/////////////

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
/////// DATA ////////
final passwordRef = FirebaseFirestore.instance.collection('password');
final winnerRef = FirebaseFirestore.instance.collection('winners');
final usersRef = FirebaseFirestore.instance.collection('users');
final sectionsRef = FirebaseFirestore.instance.collection('sections');
/////// LOCAL DATA ///////
late var box;
/////// LOGINS ////////
final FirebaseAuth userAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: const [
    'email',
  ],
);
/////// ADS ////////
InterstitialAd? videoAd;
bool isVideoAdReady = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Base
  bool isAuth = false;
  // User
  final String timestamp = DateTime.now().toString();
  late UserData theUser; // not sure if i need tbh
  late Sections sectionData; // need this to set local data
  late Password password; // not sure if i need tbh
  late Winners winners; // not sure if i need
  // Rules
  final PageController _pageController = PageController(initialPage: 0);
  final List<String> rulesTitles = [
    'Levels',
    'Sections/Checkpoints',
    'Ads (😂)',
    'Hidden Clues',
    'Winner'
  ];
  int rulesPage = 0;
  List<bool> whichPage = [
    true,
    false,
    false,
    false,
    false,
  ];

////////////////////////
//// AUTH MECHANICS ////
////////////////////////

  @override
  void initState() {
    isUserSignedIn();
    super.initState();
  }

  // checks if user exsists
  Future<void> isUserSignedIn() async {
    box = await Hive.openBox('box');
    final User? user = userAuth.currentUser;
    if (user != null) {
      // USER IS SIGNED IN
      int? currentLevel = box.get('currentLevel');
      if (currentLevel == null) {
        getUserData(user.uid);
      }
      isAuth = true;
      setState(() {});
      return;
    }
    return;
  }

  // sets local data - update for num sections
  Future<void> setLocalData() async {
    box.put('currentAd', 0);
    box.put('currentLevel', sectionData.currentSetion);
    box.put('chooseLeft', 0);
    box.put('section1', sectionData.section1);
    box.put('section2', sectionData.section2);
    box.put('section3', sectionData.section3);
    box.put('section4', sectionData.section4);
    box.put('section5', sectionData.section5);
    box.put('section6', sectionData.section6);
    box.put('section7', sectionData.section7);
    box.put('section8', sectionData.section8);
    box.put('section9', sectionData.section9);
    box.put('section10', sectionData.section10);
    box.put('section11', sectionData.section11);
    box.put('section12', sectionData.section12);
    box.put('section13', sectionData.section13);
    box.put('section14', sectionData.section14);
    box.put('section15', sectionData.section15);
    box.put('section16', sectionData.section16);
    box.put('section17', sectionData.section17);
    box.put('section18', sectionData.section18);
    box.put('section19', sectionData.section19);
    return;
  }

  // gets userdata
  Future<bool> getUserData(userUid) async {
    final DocumentSnapshot docUser = await usersRef.doc(userUid).get();
    final DocumentSnapshot docSections = await sectionsRef.doc(userUid).get();
    if (mounted && docUser.exists && docSections.exists) {
      // IF DOCS EXSIST GRAB THEM
      theUser = UserData.fromDoc(docUser);
      sectionData = Sections.fromDoc(docSections);
      setState(() {});
      await setLocalData();
      return true;
    } else {
      // IF THEY DONT SET FALSE
      return false;
    }
  }

  // IF NEW ACCOUNT IS CREATED SETS USER STATE
  Future<void> setCurrentUser(userId) async {
    final DocumentSnapshot docUser = await usersRef.doc(userId).get();
    final DocumentSnapshot docSections = await sectionsRef.doc(userId).get();
    if (mounted && docUser.exists) {
      // IF DOCS EXSIST GRAB THEM
      theUser = UserData.fromDoc(docUser);
      sectionData = Sections.fromDoc(docSections);
      setState(() {});
      await setLocalData();
    }
    return;
  }

// SEND TO TERNS PAGE
  Future<bool?> createUser(String? contact) async {
    contact ??= 'N/a';
    bool acceptedTerm = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => AcceptTerms(
          contact: contact!,
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
    return acceptedTerm;
  }

  // google sign in
  Future<void> handleGoogleSignIn() async {
    final GoogleSignInAccount? googleUser =
        await googleSignIn.signIn(); // SIGN USER IN AND RETURN IF NOT SIGNED IN
    if (googleUser == null) {
      print("error signing in");
      return;
    }
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication; // GET CREDIENTIALS AND SEE IF USER ALREADY EXISTS
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await userAuth.signInWithCredential(credential);
    } catch (e) {
      print("error authenticating firebase");
      return;
    }
    final User? user = userAuth.currentUser;
    if (user == null || !mounted) {
      print("error with user");
      return;
    }
    bool userExist = await getUserData(user.uid);
    if (userExist) {
      // IF THEY EXSIST SET AUTH = TRUE AND RETURN
      isAuth = true;
      setState(() {});
      return;
    } else {
      // IF THEY DONT CREATE ACCOUNT
      bool? acceptedTerm = await createUser(
        user.email,
      );
      if (acceptedTerm == true) {
        await usersRef.doc(user.uid).set({
          'id': user.uid,
          'startTime': timestamp,
          'contact': user.email,
          'name': user.displayName,
          'provider': "GOOGLE",
          'admin': true,
        });
        await sectionsRef.doc(user.uid).set({
          'currentSection': 0,
          'section1': [0, 0],
          'section2': [0, 0],
          'section3': [0, 0],
          'section4': [0, 0],
          'section5': [0, 0],
          'section6': [0, 0],
          'section7': [0, 0],
          'section8': [0, 0],
          'section9': [0, 0],
          'section10': [0, 0],
          'section11': [0, 0],
          'section12': [0, 0],
          'section13': [0, 0],
          'section14': [0, 0],
          'section15': [0, 0],
          'section16': [0, 0],
          'section17': [0, 0],
          'section18': [0, 0],
          'section19': [0, 0],
        });
        isAuth = true;
        setState(() {});
        setCurrentUser(user.uid);
      } else {
        googleSignIn.signOut();
        await box.clear();
        await userAuth.signOut();
      }
      return;
    }
  }

  // apple sign in
  Future<void> handleAppleSignIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print("Apple Credential: $credential");
      // Create an OAuth credential from the Apple ID credential
      final oAuthProvider = OAuthProvider('apple.com');
      final authCredential = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      // Sign in with Firebase using the Apple credentials
      try {
        await userAuth.signInWithCredential(authCredential);
      } catch (e) {
        print('Firebase sign-in error: $e');
        return;
      }
      final User? user = userAuth.currentUser;
      if (user == null || !mounted) {
        print("error with user");
        return;
      }
      bool userExist = await getUserData(user.uid);
      if (userExist) {
        // IF THEY EXSIST SET AUTH = TRUE AND RETURN
        isAuth = true;
        setState(() {});
        return;
      } else {
        // IF THEY DONT CREATE ACCOUNT
        bool? acceptedTerm = await createUser(
          user.email,
        );
        if (acceptedTerm == true) {
          await usersRef.doc(user.uid).set({
            'id': user.uid,
            'startTime': timestamp,
            'contact': user.email ?? "EMAIL",
            'name': user.displayName ?? "NAME",
            'provider': "APPLE",
            'admin': true,
          });
          await sectionsRef.doc(user.uid).set({
            'currentSection': 0,
            'section1': [0, 0],
            'section2': [0, 0],
            'section3': [0, 0],
            'section4': [0, 0],
            'section5': [0, 0],
            'section6': [0, 0],
            'section7': [0, 0],
            'section8': [0, 0],
            'section9': [0, 0],
            'section10': [0, 0],
            'section11': [0, 0],
            'section12': [0, 0],
            'section13': [0, 0],
            'section14': [0, 0],
            'section15': [0, 0],
            'section16': [0, 0],
            'section17': [0, 0],
            'section18': [0, 0],
            'section19': [0, 0],
          });
          isAuth = true;
          setState(() {});
          setCurrentUser(user.uid);
        } else {
          await box.clear();
          await userAuth.signOut();
        }
        return;
      }
    } catch (e) {
      print("Error during Apple sign-in: $e");
      return;
    }
  }

  // X sign in (AUTH EMAIL IN X DEVELOPER)
  Future<void> handleXSignIn() async {

    final authResult = await twitterLogin.login();

    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // Handle successful login
        final twitterSession = authResult.authToken; 
        final twitterSessionSecret = authResult.authTokenSecret;

        // Create a credential from the Twitter token
        final AuthCredential credential = TwitterAuthProvider.credential(
          accessToken: twitterSession!,
          secret: twitterSessionSecret!,
        );
        // Sign in to Firebase with the Twitter credentials AND IF IT FAILS RETURN
        try {
          await userAuth.signInWithCredential(credential);
        } catch (e) {
          print('Firebase sign-in error: $e');
          return;
        }
        final User? user = userAuth.currentUser;
        if (user == null || !mounted) {
          print("error with user");
          return;
        }

        bool userExist = await getUserData(user.uid);
        if (userExist) {
          // IF THEY EXSIST SET AUTH = TRUE AND RETURN
          isAuth = true;
          setState(() {});
          return;
        } else {
          // IF THEY DONT CREATE ACCOUNT
          bool? acceptedTerm = await createUser(
            user.email,
          );
          if (acceptedTerm == true) {
            await usersRef.doc(user.uid).set({
              'id': user.uid,
              'startTime': timestamp,
              'contact': user.email ?? "CONTACT",
              'name': user.displayName,
              'provider': "X",
              'admin': true,
            });
            await sectionsRef.doc(user.uid).set({
              'currentSection': 0,
              'section1': [0, 0],
              'section2': [0, 0],
              'section3': [0, 0],
              'section4': [0, 0],
              'section5': [0, 0],
              'section6': [0, 0],
              'section7': [0, 0],
              'section8': [0, 0],
              'section9': [0, 0],
              'section10': [0, 0],
              'section11': [0, 0],
              'section12': [0, 0],
              'section13': [0, 0],
              'section14': [0, 0],
              'section15': [0, 0],
              'section16': [0, 0],
              'section17': [0, 0],
              'section18': [0, 0],
              'section19': [0, 0],
            });
            isAuth = true;
            setState(() {});
            setCurrentUser(user.uid);
          } else {
            await box.clear();
            await userAuth.signOut();
          }
          return;
        }

      case TwitterLoginStatus.cancelledByUser:
        // Handle login cancellation
        print('Login cancelled by user.');
        return;

      case TwitterLoginStatus.error:
        // Handle login error
        print('Login error: ${authResult.errorMessage}');
        return;

      default:
        print('Unknown status: ${authResult.status}');
        return;
    }
  }

////////////////
//// UNAUTH ////
////////////////

// Privacy Policy
  Container privacyPolicy() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.darkGrey,
            width: 1,
          ),
          left: BorderSide(
            color: AppColors.darkGrey,
            width: 1,
          ),
          right: BorderSide(
            color: AppColors.darkGrey,
            width: 1,
          ),
        ),
        color: AppColors.darkerGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
      ),
      width: deviceWidth(context),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight(context) / 45,
                bottom: deviceHeight(context) / 100),
            child: appText("Privacy Policy", AppColors.lightGrey,
                deviceWidth(context) / 28, FontWeight.w600),
          ),
          privacyPolicyData(context)
        ],
      ),
    );
  }

// UnAuth
  Column unAuth() {
    return Column(
      children: [
        // LOGO
        Expanded(
          flex: 10,
          child: SizedBox(
            width: deviceWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: deviceWidth(context) / 1.2,
                  height: deviceHeight(context) / 3.3,
                  child: RiveAnimation.asset(
                    logo.src,
                    artboard: logo.artboard,
                  ),
                ),
              ],
            ),
          ),
        ),
        // SIGN IN
        Expanded(
          flex: 9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // GOOGLE
              GestureDetector(
                onTap: handleGoogleSignIn,
                child: button(
                    context,
                    AppColors.babyv,
                    AppColors.lightGrey,
                    AppColors.babyv,
                    "Continue With Google",
                    AppColors.darkerGrey,
                    "lib/assets/images/google.png"),
              ),
              // APPLE
              GestureDetector(
                onTap: handleAppleSignIn,
                child: button(
                    context,
                    AppColors.babyv,
                    AppColors.lightGrey,
                    AppColors.babyv,
                    "Continue With Apple",
                    AppColors.darkerGrey,
                    "lib/assets/images/apple.png"),
              ),
              // X
              GestureDetector(
                onTap: handleXSignIn,
                child: button(
                    context,
                    AppColors.babyv,
                    AppColors.lightGrey,
                    AppColors.babyv,
                    "Continue With X",
                    AppColors.darkerGrey,
                    "lib/assets/images/xApp.png"),
              ),
            ],
          ),
        ),
        // PRIVACY POLICY
        Expanded(
          flex: 5,
          child: SafeArea(
              child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: deviceHeight(context) * 0.8,
                      ),
                      child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: privacyPolicy()));
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: deviceHeight(context) / 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  appText("PRIVACY POLICY", AppColors.lightGrey,
                      deviceWidth(context) / 45, FontWeight.w400),
                  Container(
                    width: deviceWidth(context) / 6,
                    height: 1,
                    color: AppColors.lightGrey,
                  )
                ],
              ),
            ),
          )),
        ),
      ],
    );
  }

//////////////
//// AUTH ////
//////////////

// Rules
  GestureDetector rules(StateSetter setState) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: SizedBox(
        height: deviceHeight(context) / 1.25,
        width: deviceWidth(context) / 1.15,
        child: Column(
          children: [
            // HEADER
            Expanded(
              flex: 1,
              child: Container(
                width: deviceWidth(context) / 1.15,
                decoration: BoxDecoration(
                  color: AppColors.darkerGrey.withOpacity(.95),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    // TEXT
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: appText(
                          rulesTitles[rulesPage],
                          AppColors.lightGrey,
                          deviceWidth(context) / 20,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                    // CIRCLES
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: deviceWidth(context) / 6,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whichPage[0]
                                      ? AppColors.lightGrey
                                      : AppColors.backgroundColor),
                            ),
                            Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whichPage[1]
                                      ? AppColors.lightGrey
                                      : AppColors.backgroundColor),
                            ),
                            Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whichPage[2]
                                      ? AppColors.lightGrey
                                      : AppColors.backgroundColor),
                            ),
                            Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whichPage[3]
                                      ? AppColors.lightGrey
                                      : AppColors.backgroundColor),
                            ),
                            Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whichPage[4]
                                      ? AppColors.lightGrey
                                      : AppColors.backgroundColor),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // BODY
            Expanded(
              flex: 8,
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    rulesPage = value;
                    for (int i = 0; i < whichPage.length; i++) {
                      whichPage[i] = false;
                    }
                    whichPage[value] = true;
                  });
                },
                scrollDirection: Axis.horizontal,
                children: [
                  // PAGE 1
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkerGrey.withOpacity(.95),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: deviceHeight(context) / 50),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'Complete each level and use the arrows to navigate between levels',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: appText(
                                      'backwards',
                                      AppColors.lightGrey,
                                      deviceWidth(context) / 40,
                                      FontWeight.w600),
                                ),
                                leftArrow(
                                    context,
                                    AppColors.darkerGrey,
                                    AppColors.babyv,
                                    AppColors.lightGrey,
                                    AppColors.babyv,
                                    1),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: appText(
                                      'forwards',
                                      AppColors.lightGrey,
                                      deviceWidth(context) / 40,
                                      FontWeight.w600),
                                ),
                                rightArrow(
                                    context,
                                    AppColors.darkerGrey,
                                    AppColors.babyv,
                                    AppColors.lightGrey,
                                    AppColors.babyv,
                                    1),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) / 20,
                              bottom: deviceHeight(context) / 50),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'If the level is uncomplete or you cannot go move the arrows will be faded',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            leftArrow(
                                context,
                                AppColors.darkerGrey,
                                AppColors.babyv,
                                AppColors.lightGrey,
                                AppColors.babyv,
                                .2),
                            rightArrow(
                                context,
                                AppColors.darkerGrey,
                                AppColors.babyv,
                                AppColors.lightGrey,
                                AppColors.babyv,
                                .2),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: deviceHeight(context) / 20,
                          ),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'Most arrows will be in plain sight, some may be hidden or disguised',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // PAGE 2
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkerGrey.withOpacity(.95),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: deviceHeight(context) / 50,
                          ),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'Groups of levels are combined to form seperate sections distinguishable by the color of banner',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                        appBanner(context, AppColors.lightGrey, AppColors.babyv,
                            AppColors.babyv, 1, [
                          'lib/assets/images/number2.png',
                          'lib/assets/images/number2.png',
                          'lib/assets/images/number2.png'
                        ]),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) / 20,
                              bottom: deviceHeight(context) / 50),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'At the beginning of each section there will be a home button so you can navigate to home and also signaling that your position is saved at that section',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                        homeButton(context),
                        Padding(
                          padding: EdgeInsets.only(
                            top: deviceHeight(context) / 25,
                          ),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'NOTE: If you return to a level prior to your current checkpoint, your checkpoint will revert to that sections checkpoint',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // PAGE 3
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkerGrey.withOpacity(.95),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: deviceHeight(context) / 50,
                          ),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'An ad will play each time you fail a level',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) / 50,
                              bottom: deviceHeight(context) / 50),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'Sections will have a ad threshold denoted by the counter on top, once met there is no more ads for that section until you change sections',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                        appText(
                            'ex: (ads watched / threshold)',
                            AppColors.lightGrey,
                            deviceWidth(context) / 40,
                            FontWeight.w400),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            width: deviceWidth(context) / 5.5,
                            height: deviceWidth(context) / 8.5,
                            color: AppColors.lightGrey.withOpacity(.5),
                            child: const Center(
                              child: AdsCounter(
                                currentCount: '1',
                                totalCount: '4',
                                opacity: 1,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) / 50,
                              bottom: deviceHeight(context) / 25),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'Failure to watch the ad will cause the counter to not go up',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // PAGE 4
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkerGrey.withOpacity(.95),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        appText('C', AppColors.lightGrey,
                            deviceWidth(context) / 3, FontWeight.w400),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: deviceHeight(context) / 40),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'There may be hidden letters like this one in certain levels needed for later. Keep an eye out',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) / 40,
                              bottom: deviceHeight(context) / 10),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                '(not entirely sure tho)',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // PAGE 5
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkerGrey.withOpacity(.95),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: deviceHeight(context) / 50),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'When you complete all 222 levels and hit the winning button, if you win a prize you will be reached out to via the email or X account you signed up with',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                        gameButton(
                          context,
                          const Color(0xff2991C9),
                          const Color(0xff926F34),
                          const Color(0xffDFBD69),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) / 25,
                              bottom: deviceHeight(context) / 50),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.3,
                            child: appText(
                                'Check our X for current prize pool updates',
                                AppColors.lightGrey,
                                deviceWidth(context) / 30,
                                FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: deviceHeight(context) / 25),
                          child: SizedBox(
                            width: deviceWidth(context) / 1.5,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: deviceWidth(context) / 8,
                                  height: deviceWidth(context) / 8,
                                  child: flutter_image.Image.asset(
                                      'lib/assets/images/xApp.png'),
                                ),
                                appText('@222levels', AppColors.lightGrey,
                                    deviceWidth(context) / 16, FontWeight.w600)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // BOTTOM
            Expanded(
              flex: 1,
              child: Container(
                width: deviceWidth(context) / 1.15,
                decoration: BoxDecoration(
                  color: AppColors.darkerGrey.withOpacity(.95),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Auth
  Column auth() {
    return Column(
      children: [
        // SETTINGS
        SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // STATS
              Padding(
                padding: EdgeInsets.only(
                    left: deviceWidth(context) / 25,
                    top: deviceHeight(context) / 100),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Stats(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-2, 0.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: SizedBox(
                    width: deviceWidth(context) / 7,
                    height: deviceWidth(context) / 7,
                    child: Icon(
                      Icons.bar_chart_sharp,
                      size: deviceWidth(context) / 12,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              ),
              // SETTINGS
              Padding(
                padding: EdgeInsets.only(
                    right: deviceWidth(context) / 25,
                    top: deviceHeight(context) / 100),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SettingsPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(2.0, 0.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: SizedBox(
                    width: deviceWidth(context) / 7,
                    height: deviceWidth(context) / 7,
                    child: flutter_image.Image.asset(
                      'lib/assets/images/settings.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        // LOGO
        Expanded(
          flex: 6,
          child: SizedBox(
            width: deviceWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: deviceWidth(context) / 1.2,
                  height: deviceHeight(context) / 3.3,
                  child: RiveAnimation.asset(
                    logo.src,
                    artboard: logo.artboard,
                  ),
                ),
              ],
            ),
          ),
        ),
        // BUTTONS
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // BEGIN
              GestureDetector(
                onTap: () {
                  setCurrentLevel(context, true);
                },
                child: button(context, AppColors.babyv, AppColors.lightGrey,
                    AppColors.babyv, 'Begin', AppColors.darkerGrey, null),
              ),
              // RULES
              GestureDetector(
                onTap: () {
                  whichPage = [
                    true,
                    false,
                    false,
                    false,
                    false,
                  ];
                  rulesPage = 0;
                  showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Center(
                              child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            width: deviceWidth(context) / 1.15,
                            height: deviceHeight(context) / 1.25,
                            child: rules(setState),
                          ));
                        },
                      );
                    },
                  );
                },
                child: button(context, AppColors.babyv, AppColors.lightGrey,
                    AppColors.babyv, 'Rules', AppColors.darkerGrey, null),
              ),
            ],
          ),
        ),
        // SPACE
        const Expanded(
          flex: 4,
          child: SizedBox(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: isAuth ? auth() : unAuth(),
    );
  }
}

////////////////////
//// ADS & DATA ////
////////////////////

List<String> allNumber(int levelNum) {
  return levelNum
      .toString()
      .split('')
      .map((digit) => "lib/assets/images/number$digit.png")
      .toList();
}

// loads ad
void loadAd() {
  InterstitialAd.load(
    adUnitId:
        'ca-app-pub-3940256099942544/4411468910', //'ca-app-pub-6857429276607959/8587103541',
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        videoAd = ad;
        isVideoAdReady = true;
        print("loaded");
      },
      onAdFailedToLoad: (error) {
        print("failed: $error");
        isVideoAdReady = false;
        videoAd!.dispose();
      },
    ),
  );
}

// updates attempt, ads and resets section
void updateAttempt(
  int currentSection,
  int currentAdNum,
  int adCap,
  VoidCallback watchAd,
  BuildContext context,
) {
  if (isVideoAdReady && currentAdNum < adCap) {
    watchAd();
  } else {
    List<dynamic> tempList = box.get('section$currentSection');
    int tempCount = tempList[0] + 1;
    box.put('section$currentSection', [tempList[0] + 1, tempList[1]]);
    if (tempCount <= 5) {
      sectionsRef.doc(userAuth.currentUser!.uid).update({
        'section$currentSection': [tempList[0] + 1, tempList[1]],
      });
    } else if (tempCount % 5 == 0) {
      sectionsRef.doc(userAuth.currentUser!.uid).update({
        'section$currentSection': [tempList[0] + 1, tempList[1]],
      });
    }
    setCurrentLevel(context, false);
  }
}

// succsesful ad watch
void updateAd(int currentSection, int currentAdNum, BuildContext context) {
  List<dynamic> tempList = box.get('section$currentSection');
  currentAdNum++;
  box.put('currentAd', currentAdNum);
  box.put('section$currentSection', [tempList[0] + 1, tempList[1] + 1]);
  sectionsRef.doc(userAuth.currentUser!.uid).update({
    'section$currentSection': [tempList[0] + 1, tempList[1] + 1],
  });
  setCurrentLevel(context, false);
}

// updates attempt and sends to next section
void nextSection(int currentSection, BuildContext context) {
  List<dynamic> tempList = box.get('section$currentSection');
  box.put('currentAd', 0);
  box.put('section$currentSection', [tempList[0] + 1, tempList[1]]);
  box.put('currentLevel', currentSection);
  sectionsRef.doc(userAuth.currentUser!.uid).update({
    'currentSection': currentSection,
    'section$currentSection': [tempList[0] + 1, tempList[1]],
  });
  setCurrentLevel(context, false);
}

// returns to a section (make sure to input the section headed too)
void backSection(int toSection, BuildContext context) {
  box.put('currentLevel', toSection - 1);
  box.put('currentAd', 0);
  sectionsRef.doc(userAuth.currentUser!.uid).update({
    'currentSection': toSection - 1,
  });
  setCurrentLevel(context, false);
}

// Current Level
List<StatefulWidget> allLevels = [
  const Section1(),
  const Section2(),
  const Section3(),
  const Section4(),
  const Section5(),
  const Section6(),
  const Section7(),
  const Section8(),
  const Section9(),
  const Section10(),
  const Section11(),
  const Section12(),
  const Section13(),
  const Section14(),
  const Section15(),
  const Section16(),
  const Section17(),
  const Section18(),
  const Section19(),
];

Future<dynamic> setCurrentLevel(BuildContext context, bool begin) {
  int currentLevel = box.get('currentLevel');
  if (begin) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => allLevels[currentLevel],
      ),
    );
  } else {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            allLevels[currentLevel],
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
