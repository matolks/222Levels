import 'package:levels222_0/pages/home.dart';
import 'package:levels222_0/pages/settings.dart';
import 'package:levels222_0/pages/terms_policy.dart';

class AcceptTerms extends StatefulWidget {
  const AcceptTerms({
    super.key,
    required this.contact,
  });

  final String contact;

  @override
  State<AcceptTerms> createState() => _AcceptTermsState();
}

class _AcceptTermsState extends State<AcceptTerms> {
  bool termsAccepted = false;

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
                        Navigator.pop(context, false);
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
                  appText('Account', AppColors.lightGrey,
                      deviceWidth(context) / 15, FontWeight.w600),
                ],
              ),
            ),
          ),
          // Contact
          Padding(
            padding: EdgeInsets.only(
                top: deviceWidth(context) / 6,
                bottom: deviceHeight(context) / 50),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform(
                  transform: Matrix4.skewX(-0.4),
                  alignment: Alignment.center,
                  child: Container(
                    width: deviceWidth(context) / 1.2,
                    height: deviceHeight(context) / 20,
                    color: AppColors.lightGrey.withOpacity(.5),
                  ),
                ),
                appText('Contact:', AppColors.darkerGrey,
                    deviceWidth(context) / 18, FontWeight.w600)
              ],
            ),
          ),
          // EMAIL
          Container(
            width: deviceWidth(context),
            height: deviceHeight(context) / 25,
            color: AppColors.darkerGrey,
            child: Center(
              child: appText(widget.contact, AppColors.lightGrey,
                  deviceWidth(context) / 25, FontWeight.w400),
            ),
          ),
          // Disclaimer
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 100),
            child: SizedBox(
              width: deviceWidth(context) / 1.1,
              child: appText(
                  'This is for if you win that we are able to contact you out of the app. If you would like to change it sign in with a different account\nNOTE: you can not change your email once you are signed in',
                  AppColors.darkGrey,
                  deviceWidth(context) / 45,
                  FontWeight.w400),
            ),
          ),
          // ACCCEPT TERMS
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight(context) / 10,
                bottom: deviceHeight(context) / 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                appText('Accept Terms:', AppColors.lightGrey,
                    deviceWidth(context) / 20, FontWeight.w600),
                GestureDetector(
                    onTap: () {
                      termsAccepted = !termsAccepted;
                      setState(() {});
                    },
                    child: checkBox(context, termsAccepted))
              ],
            ),
          ),
          // DISCLAIMER
          SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText(
                'By checking this box you agree that you have read and consented to the terms and conditions',
                AppColors.middleGrey,
                deviceWidth(context) / 45,
                FontWeight.w400),
          ),
          // TERMS AND POLICY
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // TERMS
                GestureDetector(
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
                  child: Column(
                    children: [
                      Container(
                        height: deviceWidth(context) / 18,
                        color: AppColors.backgroundColor,
                        child: appText('TERMS', AppColors.babyv,
                            deviceWidth(context) / 27, FontWeight.w600),
                      ),
                      Container(
                        height: 2,
                        color: AppColors.babyv,
                        width: deviceWidth(context) / 10,
                      )
                    ],
                  ),
                ),
                // PRIVACY POLICY
                GestureDetector(
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
                  child: Column(
                    children: [
                      Container(
                        height: deviceWidth(context) / 18,
                        color: AppColors.backgroundColor,
                        child: appText('PRIVACY POLICY', AppColors.babyv,
                            deviceWidth(context) / 30, FontWeight.w600),
                      ),
                      Container(
                        height: 2,
                        color: AppColors.babyv,
                        width: deviceWidth(context) / 4,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // CREATE
          termsAccepted
              ? Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, termsAccepted);
                    },
                    child: button(context, AppColors.babyv, AppColors.lightGrey,
                        AppColors.babyv, 'Create', AppColors.darkerGrey, null),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
