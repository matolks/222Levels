import 'dart:math';
import 'package:levels222_0/pages/home.dart';

class CheckFail extends StatefulWidget {
  const CheckFail({super.key});

  @override
  State<CheckFail> createState() => CheckFailState();
}

class CheckFailState extends State<CheckFail> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  Animation<double>? check1;
  Animation<double>? check2;
  Animation<double>? fail1;
  Animation<double>? fail2;
  bool? isGood = false;

  @override
  void initState() {
    controller1 = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    controller1.addListener(() {
      setState(() {});
      if (controller1.isCompleted) {
        controller2.forward();
      }
    });
    controller2 = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    controller2.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    check1 = Tween<double>(
      begin: 0,
      end: deviceWidth(context) / 3,
    ).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.fastOutSlowIn,
      ),
    );
    check2 = Tween<double>(
      begin: 0,
      end: deviceWidth(context) / 1.5,
    ).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.fastOutSlowIn,
      ),
    );
    fail1 = Tween<double>(
      begin: 0,
      end: deviceWidth(context) / 1.5,
    ).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );
    fail2 = Tween<double>(
      begin: 0,
      end: deviceWidth(context) / 1.5,
    ).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );
    super.didChangeDependencies();
  }

  void animate(bool good) async {
    isGood = good;
    setState(() {});
    controller1.forward();
  }

  void reset() async {
    isGood = null;
    controller1.reset();
    controller2.reset();
    setState(() {});
  }

  Stack check() {
    return Stack(children: [
      Positioned(
        left: deviceWidth(context) / 8,
        top: deviceHeight(context) / 2,
        child: Transform.rotate(
          angle: pi / 4,
          child: Container(
            width: check1?.value ?? 0,
            height: deviceHeight(context) / 30,
            decoration: BoxDecoration(
                color: const Color(0xff30A431),
                borderRadius: BorderRadius.circular(deviceWidth(context) / 30)),
          ),
        ),
      ),
      Positioned(
        left: deviceWidth(context) / 3.75,
        top: deviceHeight(context) / 2.25,
        child: Transform.rotate(
          angle: -pi / 4,
          child: Container(
            width: check2?.value ?? 0,
            height: deviceHeight(context) / 30,
            decoration: BoxDecoration(
                color: const Color(0xff30A431),
                borderRadius: BorderRadius.circular(deviceWidth(context) / 30)),
          ),
        ),
      ),
    ]);
  }

  Stack fail() {
    return Stack(
      children: [
        Positioned(
          left: deviceWidth(context) / 6,
          top: deviceHeight(context) / 2.25,
          child: Transform.rotate(
            angle: -pi / 4,
            child: Container(
              width: fail1?.value ?? 0,
              height: deviceHeight(context) / 30,
              decoration: BoxDecoration(
                  color: const Color(0xffE33333),
                  borderRadius:
                      BorderRadius.circular(deviceWidth(context) / 30)),
            ),
          ),
        ),
        Positioned(
          left: deviceWidth(context) / 6,
          top: deviceHeight(context) / 2.25,
          child: Transform.rotate(
            angle: pi / 4,
            child: Container(
              width: fail2?.value ?? 0,
              height: deviceHeight(context) / 30,
              decoration: BoxDecoration(
                  color: const Color(0xffE33333),
                  borderRadius:
                      BorderRadius.circular(deviceWidth(context) / 30)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isGood == null
        ? const SizedBox()
        : isGood!
            ? check()
            : fail();
  }
}
