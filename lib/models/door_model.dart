import 'package:flutter/material.dart';
import 'package:levels222_0/models/app_style.dart';

class DoorModel extends StatefulWidget {
  final Size doorSize;
  const DoorModel({super.key, required this.doorSize});

  @override
  State<DoorModel> createState() => DoorModelState();
}

class DoorModelState extends State<DoorModel> with TickerProviderStateMixin {
  // Animations
  late AnimationController controllerOne;
  Animation<Size>? doorDetail1;
  Animation<double>? doorDetail1Pos;
  Animation<double>? doorDetail1Y;
  Animation<Size>? doorDetail2;
  Animation<double>? doorDetail2Pos;
  Animation<Size>? actualDoor;
  Animation<double>? actualDoorPos;
  Animation<double>? actualDoorHeight;
  Animation<double>? doorSide;
  Animation<double>? doorSideHeight;
  Animation<double>? doorSideWidth;
  Animation<double>? knobPos;
  Animation<double>? knobWidth;

  @override
  void initState() {
    super.initState();
    controllerOne = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    controllerOne.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actualDoor = Tween<Size>(
      begin: Size(
        widget.doorSize.width,
        widget.doorSize.height,
      ),
      end: Size(
        0,
        widget.doorSize.height,
      ),
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    actualDoorPos = Tween<double>(
      begin: 0,
      end: widget.doorSize.width,
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    actualDoorHeight = Tween<double>(
      begin: 0,
      end: .1,
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    doorDetail1 = Tween<Size>(
      begin: Size(
        widget.doorSize.width / (3 * 1.05),
        widget.doorSize.height / (3 * 1.05),
      ),
      end: Size(0, widget.doorSize.height / 2.6),
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    doorDetail1Pos = Tween<double>(
      begin: widget.doorSize.width * .15,
      end: widget.doorSize.width,
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    doorDetail1Y = Tween<double>(
      begin: widget.doorSize.height * .115,
      end: widget.doorSize.height * .075,
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    doorDetail2Pos = Tween<double>(
      begin: widget.doorSize.width * .15,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    doorDetail2 = Tween<Size>(
      begin: Size(
        widget.doorSize.width / (3 * 1.05),
        widget.doorSize.height / (3 * 1.05),
      ),
      end: Size(0, widget.doorSize.height / 3),
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    doorSide = Tween<double>(
      begin: widget.doorSize.width / 13,
      end: widget.doorSize.width - widget.doorSize.width / 13,
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    doorSideHeight = Tween<double>(
      begin: widget.doorSize.height / 1.05,
      end: widget.doorSize.height * 1.1,
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    doorSideWidth = Tween<double>(
      begin: 0,
      end: widget.doorSize.width / 13,
    ).animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
    knobPos = Tween<double>(
            begin: widget.doorSize.width * .025, end: widget.doorSize.width)
        .animate(
      CurvedAnimation(
        parent: controllerOne,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    controllerOne.dispose();
    super.dispose();
  }

  void moveDoor(bool open) {
    if (open) {
      controllerOne.forward();
    } else {
      controllerOne.reverse();
    }
    setState(() {});
  }

  SizedBox detail(Size size) {
    return SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: RotatedBox(
                quarterTurns: 0,
                child: CustomPaint(
                  size: Size(size.width, size.height / 2),
                  painter: DoorDetail(color: const Color(0xff996841)),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: RotatedBox(
                quarterTurns: 2,
                child: CustomPaint(
                  size: Size(size.width, size.height / 2),
                  painter: DoorDetail(color: const Color(0xff522B0C)),
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 1,
              child: CustomPaint(
                size: Size(size.height, size.width),
                painter: DoorDetail(color: const Color(0xff7D4E28)),
              ),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: CustomPaint(
                size: Size(size.height, size.width),
                painter: DoorDetail(color: const Color(0xff7D4E28)),
              ),
            ),
            Positioned(
              bottom: size.height - (size.height * .94),
              child: RotatedBox(
                quarterTurns: 0,
                child: CustomPaint(
                  size: Size(size.width * .8, size.width * .4),
                  painter: DoorDetail(color: const Color(0xff522B0C)),
                ),
              ),
            ),
            Positioned(
              top: size.height - (size.height * .94),
              child: RotatedBox(
                quarterTurns: 2,
                child: CustomPaint(
                  size: Size(size.width * .8, size.width * .4),
                  painter: DoorDetail(color: const Color(0xff996841)),
                ),
              ),
            ),
            Container(
              width: size.width * .8,
              height: size.height * .9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff401e04),
                  width: 1.0,
                ),
              ),
            ),
            Container(
                width: size.width * .65,
                height: size.height * .8,
                color: const Color(0xff65350F)),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.doorSize.width + (widget.doorSize.width / 8.5),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          //Frame
          CustomPaint(
            size: Size(
              widget.doorSize.width,
              widget.doorSize.height,
            ),
            painter: DoorFrame(
                color: const Color(0xff65350F),
                borderColor: const Color(0xff4F290C),
                borderWidth: 2),
          ),
          //Inside
          Positioned(
            left: actualDoorPos != null ? actualDoorPos!.value : 0,
            child: CustomPaint(
              size: actualDoor != null
                  ? actualDoor!.value
                  : Size(
                      widget.doorSize.width,
                      widget.doorSize.height,
                    ),
              painter: DoorMoving(
                  color: const Color(0xff65350F),
                  changeHeight:
                      actualDoorHeight != null ? actualDoorHeight!.value : 0),
            ),
          ),
          //detail
          SizedBox(
            width: widget.doorSize.width,
            height: widget.doorSize.height,
            child: Stack(
              children: [
                Positioned(
                  left: doorDetail1Pos != null
                      ? doorDetail1Pos!.value
                      : widget.doorSize.width * .15,
                  top: doorDetail1Y != null
                      ? doorDetail1Y!.value
                      : widget.doorSize.height * .115,
                  child: detail(
                    doorDetail1 != null
                        ? doorDetail1!.value
                        : Size(
                            widget.doorSize.width / (3 * 1.05),
                            widget.doorSize.height / (3 * 1.05),
                          ),
                  ),
                ),
                Positioned(
                  left: doorDetail1Pos != null
                      ? doorDetail1Pos!.value
                      : widget.doorSize.width * .15,
                  bottom: doorDetail1Y != null
                      ? doorDetail1Y!.value
                      : widget.doorSize.height * .115,
                  child: detail(
                    doorDetail1 != null
                        ? doorDetail1!.value
                        : Size(
                            widget.doorSize.width / (3 * 1.05),
                            widget.doorSize.height / (3 * 1.05),
                          ),
                  ),
                ),
                Positioned(
                  right: doorDetail2Pos != null ? doorDetail2Pos!.value : 0,
                  top: widget.doorSize.height * .115,
                  child: detail(
                    doorDetail2 != null
                        ? doorDetail2!.value
                        : Size(
                            widget.doorSize.width / 3 * 1.05,
                            widget.doorSize.height / 3 * 1.05,
                          ),
                  ),
                ),
                Positioned(
                  right: doorDetail2Pos != null ? doorDetail2Pos!.value : 0,
                  bottom: widget.doorSize.height * .115,
                  child: detail(
                    doorDetail2 != null
                        ? doorDetail2!.value
                        : Size(
                            widget.doorSize.width / 3 * 1.05,
                            widget.doorSize.height / 3 * 1.05,
                          ),
                  ),
                ),
              ],
            ),
          ),
          //side
          Positioned(
            bottom: 0,
            left: doorSide != null ? doorSide!.value : 0,
            child: Container(
              color: const Color(0xff522B0C),
              width: doorSideWidth != null ? doorSideWidth!.value : 0,
              height: doorSideHeight != null ? doorSideHeight!.value : 0,
            ),
          ),
          // knob
          Positioned(
            left:
                knobPos != null ? knobPos!.value : widget.doorSize.width * .025,
            child: Container(
              width: widget.doorSize.width / 8.5,
              height: widget.doorSize.width / 8.5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.lightGrey,
                    Color(0xffFFD700),
                    AppColors.darkGrey
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoorDetail extends CustomPainter {
  final Color color;

  DoorDetail({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final fillStroke = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, 0);
    path.close();

    canvas.drawPath(path, fillStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DoorMoving extends CustomPainter {
  final Color color;
  final double changeHeight;

  DoorMoving({required this.color, required this.changeHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width - (size.width / 1.08), size.height);
    path.lineTo(size.width - (size.width / 1.08),
        (size.height - (size.height / 1.05)) - (size.height * changeHeight));
    path.lineTo(size.width / 1.08, size.height - (size.height / 1.05));
    path.lineTo(size.width / 1.08, size.height);
    path.close();

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DoorFrame extends CustomPainter {
  final Color color;
  final Color borderColor;
  final double borderWidth;

  DoorFrame(
      {required this.color, required this.borderColor, this.borderWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 1.08, size.height);
    path.lineTo(size.width / 1.08, size.height - (size.height / 1.05));
    path.lineTo(
        size.width - (size.width / 1.08), size.height - (size.height / 1.05));
    path.lineTo(size.width - (size.width / 1.08), size.height);
    path.close();

    canvas.drawPath(path, fillPaint);

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
