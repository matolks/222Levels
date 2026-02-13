import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum SplitState { unsplit, half, quarters }

class SplittingWidget extends StatefulWidget {
  final Widget child;
  final bool splitVertically;
  final void Function() onSplitCompleted;

  const SplittingWidget({
    super.key,
    required this.child,
    this.splitVertically = true,
    required this.onSplitCompleted,
  });

  @override
  State<SplittingWidget> createState() => SplittingWidgetState();
}

class SplittingWidgetState extends State<SplittingWidget>
    with TickerProviderStateMixin {
  GlobalKey boundaryKey = GlobalKey();
  ui.Image? image;
  AnimationController? controller;
  SplitState splitState = SplitState.unsplit;
  List<double> splitLocations = [0, 0];

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void split(List<double> whereSplit) async {
    splitLocations = whereSplit;
    setState(() {});
    if (image == null) {
      RenderRepaintBoundary boundary = boundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image capturedImage = await boundary.toImage();
      image = capturedImage;
    }
    if (splitState == SplitState.unsplit) {
      splitState = SplitState.half;
    } else if (splitState == SplitState.half) {
      splitState = SplitState.quarters;
    } else {
      splitState = SplitState.unsplit;
    }
    setState(() {});
    controller?.reset();
    controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return image == null
        ? RepaintBoundary(
            key: boundaryKey,
            child: widget.child,
          )
        : AnimatedBuilder(
            animation: controller!,
            builder: (context, child) => CustomPaint(
              size: Size(image!.width.toDouble(), image!.height.toDouble()),
              painter: SplittingWidgetPainter(
                  image: image!,
                  splitVertically: splitState == SplitState.half,
                  progress: controller!.value,
                  splitX: splitLocations[0],
                  splitY: splitLocations[1]),
            ),
          );
  }
}

class SplittingWidgetPainter extends CustomPainter {
  final ui.Image image;
  final bool splitVertically;
  final double progress;
  final double splitX;
  final double splitY;

  SplittingWidgetPainter(
      {required this.image,
      required this.splitVertically,
      required this.progress,
      required this.splitX,
      required this.splitY});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ImageShader(
        image,
        TileMode.clamp,
        TileMode.clamp,
        Matrix4.identity().storage,
      );

    if (splitVertically) {
      // Half split logic
      Path part1 = Path();
      Path part2 = Path();
      part1
        ..moveTo(0, 0)
        ..lineTo(size.width * splitX, 0)
        ..lineTo(size.width * splitX, size.height)
        ..lineTo(0, size.height)
        ..close();

      part2
        ..moveTo(size.width * splitX, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width * splitX, size.height)
        ..close();
      // Calculate offsets for animation
      double offsetX = size.width * 0.05 * progress;
      canvas.save();
      canvas.translate(-offsetX, 0);
      canvas.drawPath(part1, paint);
      canvas.restore();

      canvas.save();
      canvas.translate(offsetX, 0);
      canvas.drawPath(part2, paint);
      canvas.restore();
    } else {
      // Quarters split logic
      // Divide the image into 4 sections
      Rect quarter1 =
          Rect.fromLTRB(0, 0, size.width * splitX, size.height * splitY);
      Rect quarter2 = Rect.fromLTRB(
          size.width * splitX, 0, size.width, size.height * splitY);
      Rect quarter3 = Rect.fromLTRB(
          0, size.height * splitY, size.width * splitX, size.height);
      Rect quarter4 = Rect.fromLTRB(
          size.width * splitX, size.height * splitY, size.width, size.height);

      // Offset calculations for animation
      double offsetY = size.height * 0.05 * progress;

      // Draw each quarter with respective offsets
      canvas.save();
      canvas.translate(-size.width * 0.05, -offsetY);
      canvas.drawRect(quarter1, paint);
      canvas.restore();

      canvas.save();
      canvas.translate(size.width * 0.05, -offsetY);
      canvas.drawRect(quarter2, paint);
      canvas.restore();

      canvas.save();
      canvas.translate(-size.width * 0.05, offsetY);
      canvas.drawRect(quarter3, paint);
      canvas.restore();

      canvas.save();
      canvas.translate(size.width * 0.05, offsetY);
      canvas.drawRect(quarter4, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant SplittingWidgetPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.splitVertically != splitVertically ||
        oldDelegate.image != image;
  }
}
