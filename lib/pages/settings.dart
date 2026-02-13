import 'dart:async';
import 'package:levels222_0/pages/free_99.dart';
import 'package:levels222_0/pages/home.dart';
import 'package:levels222_0/pages/terms_policy.dart';

/// NEED TO ADD A SECTION WHERE ITS USER INFO SO THEY CAN SEE WHAT EMAIL YOU INPUTTED

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  // Password functions
  List<int> tempPassword = [];
  List<int> actual = [50, 50, 50, 50, 50];
  bool correctPassword = false;
  bool alreadyPassed = false;
  bool? loading;
  Timer? _timer;

  @override
  void initState() {
    int currentLevel = box.get('currentLevel') ?? 0;
    if (currentLevel > 4) {
      alreadyPassed = true;
    } else if (thePassword != null) {
      actual = thePassword!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // SUPPORT
  Expanded support() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 50),
            child: SizedBox(
              width: deviceWidth(context) / 1.1,
              child: appText(
                  'If you encounter a bug or a small issue let us know on X or in our Tik Tok comment section ',
                  AppColors.lightGrey,
                  deviceWidth(context) / 25,
                  FontWeight.w400),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight(context) / 25,
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
                    child: Image.asset('lib/assets/images/xApp.png'),
                  ),
                  appText('@222levels', AppColors.lightGrey,
                      deviceWidth(context) / 14, FontWeight.w600)
                ],
              ),
            ),
          ),
          SizedBox(
            width: deviceWidth(context) / 1.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: deviceWidth(context) / 8,
                  height: deviceWidth(context) / 8,
                  child: Image.asset('lib/assets/images/tiktok.png'),
                ),
                appText('@222levels', AppColors.lightGrey,
                    deviceWidth(context) / 14, FontWeight.w600)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 25),
            child: SizedBox(
              width: deviceWidth(context) / 1.1,
              child: appText(
                  'For a bigger issue you can contact YorMedia22@outlook.com for support',
                  AppColors.lightGrey,
                  deviceWidth(context) / 25,
                  FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  // SIGN OUT
  void signOut() async {
    await userAuth.signOut();
    await googleSignIn.signOut();
    await box.clear();
    await userAuth.signOut();
    setState(() {});
    if (mounted) {
      Navigator.pop(context);
    }
  }

  // DELETE

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
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
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: deviceWidth(context) / 6,
                          height: deviceWidth(context) / 6,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.lightGrey,
                            size: deviceWidth(context) / 11,
                          ),
                        ),
                      ),
                    ),
                    // TEXT
                    appText('Settings', AppColors.lightGrey,
                        deviceWidth(context) / 15, FontWeight.w600),
                  ],
                ),
              ),
            ),
            // BODY
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    // LEGAL YADA YADA
                    Padding(
                      padding: EdgeInsets.only(
                          top: deviceHeight(context) / 50,
                          bottom: deviceHeight(context) / 100),
                      child: Container(
                        color: AppColors.lightGrey.withOpacity(.5),
                        width: deviceWidth(context),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              deviceWidth(context) / 22, 5, 0, 5),
                          child: appText('Legal Yada Yada', AppColors.darkGrey,
                              deviceWidth(context) / 25, FontWeight.w600),
                        ),
                      ),
                    ),
                    ///// Privacy Policy
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPart(
                                  title: 'Privacy Policy',
                                  part: privacyPolicyData(context)),
                            ),
                          );
                        },
                        child: Container(
                          width: deviceWidth(context),
                          height: deviceHeight(context) / 12,
                          color: AppColors.darkerGrey,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: deviceWidth(context) / 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                appText('Privacy Policy', AppColors.middleGrey,
                                    deviceWidth(context) / 22, FontWeight.w400),
                                SizedBox(
                                  width: deviceWidth(context) / 6,
                                  height: deviceWidth(context) / 6,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.middleGrey,
                                    size: deviceWidth(context) / 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ///// Terms
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPart(
                                  title: 'Terms & Conditons',
                                  part: termsAndConditions(context)),
                            ),
                          );
                        },
                        child: Container(
                          width: deviceWidth(context),
                          height: deviceHeight(context) / 12,
                          color: AppColors.darkerGrey,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: deviceWidth(context) / 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                appText(
                                    'Terms & Conditions',
                                    AppColors.middleGrey,
                                    deviceWidth(context) / 22,
                                    FontWeight.w400),
                                SizedBox(
                                  width: deviceWidth(context) / 6,
                                  height: deviceWidth(context) / 6,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.middleGrey,
                                    size: deviceWidth(context) / 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SUPPORT
                    Padding(
                      padding: EdgeInsets.only(
                          top: deviceHeight(context) / 100,
                          bottom: deviceHeight(context) / 100),
                      child: Container(
                        color: AppColors.lightGrey.withOpacity(.5),
                        width: deviceWidth(context),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              deviceWidth(context) / 22, 5, 0, 5),
                          child: appText('Support', AppColors.darkGrey,
                              deviceWidth(context) / 25, FontWeight.w600),
                        ),
                      ),
                    ),
                    ///// Support
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPart(
                                  title: 'Support', part: support()),
                            ),
                          );
                        },
                        child: Container(
                          width: deviceWidth(context),
                          height: deviceHeight(context) / 12,
                          color: AppColors.darkerGrey,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: deviceWidth(context) / 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                appText('Support', AppColors.middleGrey,
                                    deviceWidth(context) / 22, FontWeight.w400),
                                SizedBox(
                                  width: deviceWidth(context) / 6,
                                  height: deviceWidth(context) / 6,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.middleGrey,
                                    size: deviceWidth(context) / 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // FO YOU
                    !alreadyPassed
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: deviceHeight(context) / 100,
                                bottom: deviceHeight(context) / 100),
                            child: Container(
                              color: AppColors.lightGrey.withOpacity(.5),
                              width: deviceWidth(context),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    deviceWidth(context) / 22, 5, 0, 5),
                                child: appText('Fo You', AppColors.darkGrey,
                                    deviceWidth(context) / 25, FontWeight.w600),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    ///// password
                    !alreadyPassed
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: GestureDetector(
                              onTap: () {
                                tempPassword = [];
                                correctPassword = false;
                                loading = null;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        void checkPassword() {
                                          bool temp = true;
                                          for (int i = 0; i < 5; i++) {
                                            if (tempPassword[i] != actual[i]) {
                                              temp = false;
                                            }
                                          }
                                          if (mounted) {
                                            setState(() {});
                                          }
                                          _timer = Timer(
                                            const Duration(milliseconds: 2250),
                                            () {
                                              correctPassword = temp;
                                              loading = false;
                                              if (mounted) {
                                                setState(() {});
                                              }
                                              _timer = Timer(
                                                const Duration(
                                                    milliseconds: 2250),
                                                () {
                                                  if (correctPassword) {
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacement(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                                animation1,
                                                                animation2) =>
                                                            const Free99(),
                                                        transitionDuration:
                                                            Duration.zero,
                                                        reverseTransitionDuration:
                                                            Duration.zero,
                                                      ),
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          );
                                        }

                                        return SizedBox(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              // TO RETURN
                                              GestureDetector(
                                                onTap: () {
                                                  _timer?.cancel();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: deviceWidth(context),
                                                  height: deviceHeight(context),
                                                  color: AppColors.darkGrey
                                                      .withOpacity(0),
                                                ),
                                              ),
                                              // LOCK
                                              Container(
                                                width: deviceWidth(context),
                                                height:
                                                    deviceWidth(context) * 1.25,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'lib/assets/images/section5/workingLock.png'),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              // 1 input
                                              Positioned(
                                                left:
                                                    deviceWidth(context) / 6.25,
                                                top: deviceWidth(context) / 1.5,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (tempPassword.length <
                                                        5) {
                                                      tempPassword.add(1);
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      if (tempPassword.length ==
                                                          5) {
                                                        loading = true;
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        checkPassword();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width:
                                                        deviceWidth(context) /
                                                            5,
                                                    height:
                                                        deviceWidth(context) /
                                                            5,
                                                    color: AppColors
                                                        .backgroundColor
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ),
                                              // 2 input
                                              Positioned(
                                                left:
                                                    deviceWidth(context) / 2.5,
                                                top: deviceWidth(context) / 1.5,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (tempPassword.length <
                                                        5) {
                                                      tempPassword.add(2);
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      if (tempPassword.length ==
                                                          5) {
                                                        loading = true;
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        checkPassword();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width:
                                                        deviceWidth(context) /
                                                            5,
                                                    height:
                                                        deviceWidth(context) /
                                                            5,
                                                    color: AppColors
                                                        .backgroundColor
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ),
                                              // 3 input
                                              Positioned(
                                                right:
                                                    deviceWidth(context) / 6.25,
                                                top: deviceWidth(context) / 1.5,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (tempPassword.length <
                                                        5) {
                                                      tempPassword.add(3);
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      if (tempPassword.length ==
                                                          5) {
                                                        loading = true;
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        checkPassword();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width:
                                                        deviceWidth(context) /
                                                            5,
                                                    height:
                                                        deviceWidth(context) /
                                                            5,
                                                    color: AppColors
                                                        .backgroundColor
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ),
                                              // 4 input
                                              Positioned(
                                                left:
                                                    deviceWidth(context) / 6.25,
                                                top:
                                                    deviceWidth(context) / 1.14,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (tempPassword.length <
                                                        5) {
                                                      tempPassword.add(4);
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      if (tempPassword.length ==
                                                          5) {
                                                        loading = true;
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        checkPassword();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width:
                                                        deviceWidth(context) /
                                                            5,
                                                    height:
                                                        deviceWidth(context) /
                                                            5,
                                                    color: AppColors
                                                        .backgroundColor
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ),
                                              // 5 input
                                              Positioned(
                                                left:
                                                    deviceWidth(context) / 2.5,
                                                top:
                                                    deviceWidth(context) / 1.14,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (tempPassword.length <
                                                        5) {
                                                      tempPassword.add(5);
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      if (tempPassword.length ==
                                                          5) {
                                                        loading = true;
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        checkPassword();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width:
                                                        deviceWidth(context) /
                                                            5,
                                                    height:
                                                        deviceWidth(context) /
                                                            5,
                                                    color: AppColors
                                                        .backgroundColor
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ),
                                              // 6 input
                                              Positioned(
                                                right:
                                                    deviceWidth(context) / 6.25,
                                                top:
                                                    deviceWidth(context) / 1.14,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (tempPassword.length <
                                                        5) {
                                                      tempPassword.add(6);
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      if (tempPassword.length ==
                                                          5) {
                                                        loading = true;
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        checkPassword();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width:
                                                        deviceWidth(context) /
                                                            5,
                                                    height:
                                                        deviceWidth(context) /
                                                            5,
                                                    color: AppColors
                                                        .backgroundColor
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ),
                                              // 7 input
                                              Positioned(
                                                left:
                                                    deviceWidth(context) / 6.25,
                                                top: deviceWidth(context) *
                                                    1.085,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (tempPassword.length <
                                                        5) {
                                                      tempPassword.add(7);
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      if (tempPassword.length ==
                                                          5) {
                                                        loading = true;
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        checkPassword();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width:
                                                        deviceWidth(context) /
                                                            5,
                                                    height:
                                                        deviceWidth(context) /
                                                            5,
                                                    color: AppColors
                                                        .backgroundColor
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ),
                                              // 8 input
                                              Positioned(
                                                left:
                                                    deviceWidth(context) / 2.5,
                                                top: deviceWidth(context) *
                                                    1.085,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (tempPassword.length <
                                                        5) {
                                                      tempPassword.add(8);
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      if (tempPassword.length ==
                                                          5) {
                                                        loading = true;
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        checkPassword();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width:
                                                        deviceWidth(context) /
                                                            5,
                                                    height:
                                                        deviceWidth(context) /
                                                            5,
                                                    color: AppColors
                                                        .backgroundColor
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ),
                                              // 9 input
                                              Positioned(
                                                right:
                                                    deviceWidth(context) / 6.25,
                                                top: deviceWidth(context) *
                                                    1.085,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (tempPassword.length <
                                                        5) {
                                                      tempPassword.add(9);
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      if (tempPassword.length ==
                                                          5) {
                                                        loading = true;
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        checkPassword();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width:
                                                        deviceWidth(context) /
                                                            5,
                                                    height:
                                                        deviceWidth(context) /
                                                            5,
                                                    color: AppColors
                                                        .backgroundColor
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ),
                                              // 0 input
                                              Positioned(
                                                left:
                                                    deviceWidth(context) / 2.5,
                                                top: deviceWidth(context) *
                                                    1.295,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (tempPassword.length <
                                                        5) {
                                                      tempPassword.add(0);
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      if (tempPassword.length ==
                                                          5) {
                                                        loading = true;
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        checkPassword();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width:
                                                        deviceWidth(context) /
                                                            5,
                                                    height:
                                                        deviceWidth(context) /
                                                            5,
                                                    color: AppColors
                                                        .backgroundColor
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ),
                                              // right or wrong
                                              correctPassword
                                                  ? Positioned(
                                                      top:
                                                          deviceWidth(context) /
                                                              1.91,
                                                      left:
                                                          deviceWidth(context) /
                                                              2.66,
                                                      child: Container(
                                                        width: deviceWidth(
                                                                context) /
                                                            12,
                                                        height: deviceWidth(
                                                                context) /
                                                            12,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0xff00FF30),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                    )
                                                  : Positioned(
                                                      top:
                                                          deviceWidth(context) /
                                                              1.91,
                                                      right:
                                                          deviceWidth(context) /
                                                              2.66,
                                                      child: Container(
                                                        width: deviceWidth(
                                                                context) /
                                                            12,
                                                        height: deviceWidth(
                                                                context) /
                                                            12,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: loading == null
                                                              ? Colors
                                                                  .transparent
                                                              : loading == true
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      229,
                                                                      225,
                                                                      20)
                                                                  : const Color(
                                                                      0xffFF3737),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: deviceWidth(context),
                                height: deviceHeight(context) / 12,
                                color: AppColors.darkerGrey,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: deviceWidth(context) / 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      appText(
                                          'Password',
                                          AppColors.middleGrey,
                                          deviceWidth(context) / 22,
                                          FontWeight.w400),
                                      SizedBox(
                                        width: deviceWidth(context) / 6,
                                        height: deviceWidth(context) / 6,
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: AppColors.middleGrey,
                                          size: deviceWidth(context) / 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    // DANGER ZONE
                    Padding(
                      padding: EdgeInsets.only(
                          top: deviceHeight(context) / 100,
                          bottom: deviceHeight(context) / 100),
                      child: Container(
                        color: AppColors.lightGrey.withOpacity(.5),
                        width: deviceWidth(context),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              deviceWidth(context) / 22, 5, 0, 5),
                          child: appText('DANGER ZONE', AppColors.darkGrey,
                              deviceWidth(context) / 25, FontWeight.w600),
                        ),
                      ),
                    ),
                    ///// Sign Out
                    Padding(
                      padding: EdgeInsets.only(top: deviceHeight(context) / 18),
                      child: GestureDetector(
                        onTap: () {
                          signOut();
                        },
                        child: button(
                            context,
                            AppColors.middleGrey,
                            AppColors.darkerGrey,
                            AppColors.backgroundColor,
                            'Sign Out',
                            AppColors.lightGrey,
                            null),
                      ),
                    ),
                    ///// DELETE ACCOUNT
                    GestureDetector(
                      onTap: () {
                        print("hello");
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: deviceHeight(context) / 15,
                            bottom: deviceHeight(context) / 4),
                        child: button(
                            context,
                            AppColors.redError,
                            AppColors.middleGrey,
                            AppColors.redError,
                            'DELETE ACCOUNT',
                            AppColors.backgroundColor,
                            null),
                      ),
                    ),
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

// Support, Terms, Privacy Policy
class SettingsPart extends StatefulWidget {
  const SettingsPart({super.key, required this.part, required this.title});

  final Widget part;
  final String title;

  @override
  State<SettingsPart> createState() => _SettingsPartState();
}

class _SettingsPartState extends State<SettingsPart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: deviceWidth(context) / 7,
                        height: deviceWidth(context) / 7,
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.lightGrey,
                          size: deviceWidth(context) / 11,
                        ),
                      ),
                    ),
                  ),
                  // TEXT
                  appText(widget.title, AppColors.lightGrey,
                      deviceWidth(context) / 18, FontWeight.w600),
                ],
              ),
            ),
          ),
          // BODY
          widget.part
        ],
      ),
    );
  }
}
