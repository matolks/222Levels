import 'package:levels222_0/pages/home.dart';

// Privacy Policy
Expanded privacyPolicyData(BuildContext context) {
  return Expanded(
      child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      children: [
        // EFFECTIVE DATE
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 30),
          child: SizedBox(
            width: deviceWidth(context) / 1.15,
            child: appText2(
                'Effective Date: September 1st, 2024',
                AppColors.lightGrey,
                deviceWidth(context) / 30,
                FontWeight.w600),
          ),
        ),
        // INTRO
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('Introduction', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              '222 Levels (“we," "our," "us") values your privacy. This Privacy Policy explains how we collect, use, and protect your information when you use our trivia app ("App"). By using the App, you agree to the practices described in this Privacy Policy.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Information We Collect
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('Information We Collect', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'The only information we collect is the method you use to sign in to the App. Specifically, we collect:\n\t\t\t•  Sign-in information provided by Google, X (formerly Twitter), or Apple.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Eligibility and Data Collection
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2(
                'Eligibility and Data Collection',
                AppColors.lightGrey,
                deviceWidth(context) / 24,
                FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'We only collect and process personal data from users who meet our eligibility requirements, including being at least 17 years old and residing in the United States. If we discover that we have collected information from individuals who do not meet these requirements, we will take steps to delete this information as soon as possible.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // How We Use Your Information
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('How We Use Your Information', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'The information we collect is used solely to authenticate your identity and allow you access to the App. The information we collect is also so we are able to reach you if you win the prize. We do not use your information for any other purpose.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Data Retention
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('Data Retention', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'We retain your sign-in information as long as your account is active and the App is operational. If the App is discontinued, we will delete your information within a reasonable timeframe.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Third-Party Sharing
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('Third-Party Sharing', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'We do not share your sign-in information with any third parties, except as required by law or in connection with legal claims or compliance.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Cookies and Tracking Technologies
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2(
                'Cookies and Tracking Technologies',
                AppColors.lightGrey,
                deviceWidth(context) / 24,
                FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'We do not use cookies or similar tracking technologies within the App. However, third-party services integrated with our App may use cookies, and their practices are governed by their privacy policies.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Third-Party Links
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('Third-Party Links', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'Our App may contain links to third-party websites or services that we do not operate. We are not responsible for the privacy practices or content of these third-party sites. Please review the privacy policies of any third-party sites you visit.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Children’s Privacy
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('Children’s Privacy', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'Our App is not intended for individuals under the age of 17. We do not knowingly collect personal information from children under this age. If we become aware that a child under 17 has provided us with personal information, we will delete it immediately. If you believe we have collected information from a child under this age, please contact us at YorMedia22@outlook.com.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Changes to Your Information
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('Changes to Your Information', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'If you wish to change your sign-in method, you must delete your account and sign up again with the new login method. To delete your account, please contact us at YorMedia22@outlook.com.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // User Rights
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('User Rights', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'You have the right to access, modify, or delete your sign-in information. If you wish to exercise any of these rights, please contact us at YorMedia22@outlook.com.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Security Measures
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('Security Measures', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'We are committed to protecting your information. We use industry-standard security measures to protect your sign-in data from unauthorized access, alteration, or disclosure.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Compliance with Data Protection Laws
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2(
                'Compliance with Data Protection Laws',
                AppColors.lightGrey,
                deviceWidth(context) / 24,
                FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'We comply with applicable data protection laws, including the General Data Protection Regulation (GDPR) and the California Consumer Privacy Act (CCPA). If you are located in the California, you may have additional rights regarding your data.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        //  Dispute Resolution
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('Dispute Resolution', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'If you have any complaints regarding our privacy practices, please contact us. We will investigate and attempt to resolve any complaints or disputes regarding the use or disclosure of your information.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Changes to This Privacy Policy
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2(
                'Changes to This Privacy Policy',
                AppColors.lightGrey,
                deviceWidth(context) / 24,
                FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2(
              'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Contact Us
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('Contact Us', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: deviceHeight(context) / 8),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2(
                'If you have any questions about this Privacy Policy, please contact us at YorMedia22@outlook.com.',
                AppColors.lightGrey,
                deviceWidth(context) / 30,
                FontWeight.w400),
          ),
        ),
      ],
    ),
  ));
}

// Terms And Conditions
Expanded termsAndConditions(BuildContext context) {
  return Expanded(
      child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      children: [
        // EFFECTIVE DATE
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 30),
          child: SizedBox(
            width: deviceWidth(context) / 1.15,
            child: appText2(
                'Effective Date: September 1st, 2024',
                AppColors.lightGrey,
                deviceWidth(context) / 30,
                FontWeight.w600),
          ),
        ),
        // INTRO
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 100, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2(
                'Welcome to 222 Levels! These Terms and Conditions ("Terms") govern your use of our trivia app ("App"). By accessing or using the App, you agree to be bound by these Terms. If you do not agree with these Terms, please do not use the App.',
                AppColors.lightGrey,
                deviceWidth(context) / 30,
                FontWeight.w600),
          ),
        ),
        // Eligibility
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('1. Eligibility', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t1.1 Age Requirement:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'You must be at least 17 years old to use the App. By using the App, you represent and warrant that you meet this age requirement.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t1.2 Residency Requirement:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'You must be a legal resident of the United States to use the App. By using the App, you represent and warrant that you meet this residency requirement.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t1.3 Legal Compliance:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'You must comply with all applicable laws and regulations when using the App.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Account Registration and Security
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2(
                '2. Account Registration and Security',
                AppColors.lightGrey,
                deviceWidth(context) / 24,
                FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t2.1 Account Creation:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'To use the App, you must create an account by signing in with Google, X (formerly Twitter), or Apple. You are responsible for maintaining the confidentiality of your login information.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t2.2 Account Security:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'You are responsible for all activities that occur under your account. If you believe your account has been compromised, you must notify us immediately at YorMedia22@outlook.com.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t2.3 Account Deletion:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'If you wish to change your login method, you must delete your current account and create a new one with the desired login method. You can request account deletion by contacting us at YorMedia22@outlook.com.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Use of the App
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('3. Use of the App', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t3.1 Permitted Use:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'You may use the App for personal, non-commercial purposes only. Any other use is prohibited without our prior written consent.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t3.2 Prohibited Activities:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'You agree not to:\n\t\t• Use the App for any illegal or unauthorized purpose.\n\t\t• Interfere with or disrupt the operation of the App.\n\t\t• Attempt to gain unauthorized access to the App or its related systems.\n\t\t• Use the App to distribute spam, malware, or any other harmful content.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Intellectual Property
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('4. Intellectual Property', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t4.1 Ownership:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'All content, features, and functionality on the App, including but not limited to text, graphics, logos, and software, are the exclusive property of 222 Levels or its licensors and are protected by intellectual property laws.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t4.2 License:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'We grant you a limited, non-exclusive, non-transferable, and revocable license to use the App for personal, non-commercial purposes in accordance with these Terms.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t4.3 Restrictions:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'You may not copy, modify, distribute, sell, or lease any part of the App or its content without our prior written consent.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Prizes and Rewards
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('5. Prizes and Rewards', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t5.1 Eligibility for Prizes:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'To be eligible for any prizes or rewards offered through the App, you must comply with these Terms and any additional rules or requirements specified in the App.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t5.2 Cheating and Fraud:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'If we determine, in our sole discretion, that you have engaged in cheating, fraud, or any other unfair practices, you will be ineligible for any prizes or rewards. We reserve the right to cancel any prize or reward if cheating or fraudulent activity is suspected.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t5.3 Prize Distribution:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'Prizes are awarded based on the rules specified within the App. We reserve the right to withhold or revoke prizes if we determine that you have violated these Terms or engaged in fraudulent activity.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t5.4 Taxation:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'You are responsible for reporting and paying any taxes related to your receipt of prizes or rewards, as required by your local jurisdiction.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Limitation of Liability
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('6. Limitation of Liability', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t6.1 No Warranty:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'The App is provided "as is" and "as available," without any warranties of any kind, express or implied. We do not warrant that the App will be uninterrupted, error-free, or free of harmful components.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t6.2 Limitation of Liability:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'To the fullest extent permitted by law, 222 Levels and its affiliates, licensors, and service providers shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or related to your use of the App.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Privacy
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('7. Privacy', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t7.1 Privacy Policy:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'Your use of the App is also governed by our Privacy Policy, which can be found under [Privacy Policy]. Please review the Privacy Policy to understand how we collect, use, and protect your information.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Termination
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('8. Termination', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t8.1 Termination by You:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'You may terminate your account at any time on your own or by contacting us at YorMedia22@outlook.com.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t8.2 Termination by Us:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'We reserve the right to terminate or suspend your account or access to the App at any time, with or without notice, for any reason, including if we believe you have violated these Terms.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Changes to the Terms
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('9. Changes to the Terms', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t9.1 Modifications:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'We may update or modify these Terms from time to time. If we make significant changes, we will notify you through the App or by other means. Your continued use of the App after such changes constitutes your acceptance of the new Terms.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Dispute Resolution
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('10. Dispute Resolution', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t10.1 Informal Resolution:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'You agree to attempt to resolve any disputes informally by contacting our support team before pursuing formal legal action.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t10.2 Arbitration Agreement:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'Any disputes that cannot be resolved informally shall be resolved through binding arbitration rather than in court. This helps avoid costly and time-consuming litigation.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Data Security
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('11. Data Security', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t11.1 Security Measures:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'We implement security measures to protect user data. Users should also take steps to safeguard their accounts.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t11.2 Breach Notification:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'In the event of a data breach that affects your personal information, we will notify you as required by applicable law.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // App Updates and Maintenance
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2(
                '12. App Updates and Maintenance',
                AppColors.lightGrey,
                deviceWidth(context) / 24,
                FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t12.1 Updates:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'We reserve the right to update or modify the App at any time, including adding or removing features.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t12.2 Maintenance:', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.2,
          child: appText2(
              'There may be periods of maintenance during which the App may be unavailable. We will communicate scheduled downtime to users as needed.',
              AppColors.lightGrey,
              deviceWidth(context) / 30,
              FontWeight.w400),
        ),
        // Contact Us
        Padding(
          padding: EdgeInsets.only(top: deviceHeight(context) / 200, bottom: 5),
          child: SizedBox(
            width: deviceWidth(context) / 1.1,
            child: appText2('13. Contact Us', AppColors.lightGrey,
                deviceWidth(context) / 24, FontWeight.w600),
          ),
        ),
        SizedBox(
          width: deviceWidth(context) / 1.1,
          child: appText2('\t13.1 Questions?', AppColors.lightGrey,
              deviceWidth(context) / 28, FontWeight.w400),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: deviceHeight(context) / 8),
          child: SizedBox(
            width: deviceWidth(context) / 1.2,
            child: appText2(
                'If you have any questions or concerns about these Terms, please contact us at YorMedia22@outlook.com.',
                AppColors.lightGrey,
                deviceWidth(context) / 30,
                FontWeight.w400),
          ),
        ),
      ],
    ),
  ));
}
