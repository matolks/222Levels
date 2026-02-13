import 'package:levels222_0/pages/home.dart';

class DeathScreen extends StatefulWidget {
  final void Function() adButton;

  const DeathScreen({super.key, required this.adButton});

  @override
  State<DeathScreen> createState() => DeathScreenState();
}

class DeathScreenState extends State<DeathScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  Animation<double>? colorChange;
  bool showButton = false;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        showButton = true;
        setState(() {});
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    colorChange = Tween<double>(begin: 0, end: .5).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void start() {
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      height: deviceHeight(context),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: .9,
          colors: [
            AppColors.backgroundColor,
            mounted && colorChange != null
                ? AppColors.backgroundColor.withOpacity(colorChange!.value / 2)
                : AppColors.backgroundColor.withOpacity(0),
            mounted && colorChange != null
                ? const Color(0xffAE3131).withOpacity(colorChange!.value)
                : AppColors.backgroundColor.withOpacity(0),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: deviceHeight(context) / 3),
            child: appText(
                'YOU DIED',
                mounted && colorChange != null
                    ? const Color(0xffAE3131).withOpacity(colorChange!.value)
                    : AppColors.backgroundColor.withOpacity(0),
                deviceWidth(context) / 10,
                FontWeight.w600),
          ),
          showButton
              ? Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) / 10),
                  child: GestureDetector(
                    onTap: () {
                      widget.adButton();
                    },
                    child: button(
                        context,
                        const Color(0xffAE3131).withOpacity(.8),
                        AppColors.darkerGrey,
                        const Color(0xffAE3131).withOpacity(.8),
                        "Respawn",
                        AppColors.darkerGrey,
                        null),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
