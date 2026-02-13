import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShatteringWidget extends StatefulWidget {
  final Widget Function(void Function() shatter) builder;
  final void Function() onShatterCompleted;

  const ShatteringWidget(
      {super.key, required this.builder, required this.onShatterCompleted});

  @override
  State<ShatteringWidget> createState() => ShatteringWidgetState();
}

class Tri {
  final Offset p1;
  final Offset p2;
  final Offset p3;

  Tri(this.p1, this.p2, this.p3);

  List<Tri> split() {
    double s1 = (p2 - p1).distanceSquared;
    double s2 = (p3 - p2).distanceSquared;
    double s3 = (p1 - p3).distanceSquared;

    if (s1 > s2 && s1 > s3) {
      Offset dir = p2 - p1;
      Offset mp = p1 + dir / 2;
      return [Tri(mp, p1, p3), Tri(mp, p3, p2)];
    } else if (s2 > s1 && s2 > s3) {
      Offset dir = p3 - p2;
      Offset mp = p2 + dir / 2;
      return [
        Tri(mp, p1, p3),
        Tri(mp, p2, p1),
      ];
    } else {
      Offset dir = p1 - p3;
      Offset mp = p3 + dir / 2;
      return [
        Tri(mp, p2, p1),
        Tri(mp, p3, p2),
      ];
    }
  }

  Offset get center =>
      Offset((p1.dx + p2.dx + p3.dx) / 3.0, (p1.dy + p2.dy + p3.dy) / 3.0);
}

class Shard {
  final Tri triangle;
  final double rotation;
  final Offset velocity;

  Shard(this.triangle, this.rotation, this.velocity);

  Offset getCenter(Size size) {
    return Offset(
        (triangle.p1.dx * size.width +
                triangle.p2.dx * size.width +
                triangle.p3.dx * size.width) /
            3.0,
        (triangle.p1.dy * size.height +
                triangle.p2.dy * size.height +
                triangle.p3.dy * size.height) /
            3.0);
  }

  Path toPath(Size size) => Path()
    ..moveTo(triangle.p1.dx * size.width, triangle.p1.dy * size.height)
    ..lineTo(triangle.p2.dx * size.width, triangle.p2.dy * size.height)
    ..lineTo(triangle.p3.dx * size.width, triangle.p3.dy * size.height)
    ..lineTo(triangle.p1.dx * size.width, triangle.p1.dy * size.height);
}

class ShatteringWidgetState extends State<ShatteringWidget>
    with TickerProviderStateMixin {
  Random r = Random();
  GlobalKey key = GlobalKey();
  ui.Image? image;
  AnimationController? controller;
  List<Shard>? shards;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2150));
    controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          widget.onShatterCompleted();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void shatter() {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    boundary.toImage().then((onValue) {
      image = onValue;
      List<Tri> triangles = image!.width > image!.height
          ? [
              Tri(const Offset(0, 0), const Offset(.3, 0),
                  const Offset(0, 1.0)),
              Tri(const Offset(.3, 0), const Offset(1.0, 0),
                  const Offset(1.0, 1.0)),
              Tri(const Offset(0, 1.0), const Offset(.3, 0),
                  const Offset(1.0, 1.0)),
            ]
          : [
              Tri(const Offset(0, 0), const Offset(1.0, 0),
                  const Offset(1.0, .3)),
              Tri(const Offset(0, 0), const Offset(1.0, .3),
                  const Offset(0, 1.0)),
              Tri(const Offset(0, 1.0), const Offset(1.0, .3),
                  const Offset(1.0, 1.0)),
            ];
      shards = triangles
          .map((e) => r.nextBool() ? e.split() : [e])
          .expand((e) => e)
          .map((e) => r.nextBool() ? e.split() : [e])
          .expand((e) => e)
          .map((e) => r.nextBool() ? e.split() : [e])
          .expand((e) => e)
          .map((e) => r.nextBool() ? e.split() : [e])
          .expand((e) => e)
          .map((e) => r.nextBool() ? e.split() : [e])
          .expand((e) => e)
          .map((e) => r.nextBool() ? e.split() : [e])
          .expand((e) => e)
          .map((e) => r.nextBool() ? e.split() : [e])
          .expand((e) => e)
          .map((e) => r.nextBool() ? e.split() : [e])
          .expand((e) => e)
          .map((e) => r.nextBool() ? e.split() : [e])
          .expand((e) => e)
          .map((e) => Shard(e, -.3 + r.nextDouble() * .6,
              ((e.center - const Offset(.5, .5)) * 7000)))
          .toList();
      setState(() {});
      controller!.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return controller != null && image != null
        ? AnimatedBuilder(
            animation: controller!,
            builder: (context, child) => OverflowBox(
                  // Make the canvas larger than the screen to allow shards to go beyond
                  maxWidth: MediaQuery.of(context).size.width * 2.5,
                  maxHeight: MediaQuery.of(context).size.height * 2.5,
                  child: CustomPaint(
                    size:
                        Size(image!.width.toDouble(), image!.height.toDouble()),
                    painter: ShatteringWidgetPainter(
                        image: image!,
                        shards: shards!,
                        shatterProgress: controller!.value),
                  ),
                ))
        : RepaintBoundary(
            key: key,
            child: widget.builder(shatter),
          );
  }
}

class ShatteringWidgetPainter extends CustomPainter {
  final ui.Image image;
  final List<Shard> shards;
  final double shatterProgress;

  ShatteringWidgetPainter(
      {super.repaint,
      required this.image,
      required this.shards,
      required this.shatterProgress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint imagePainter = Paint()
      ..shader = ImageShader(
          image, TileMode.clamp, TileMode.clamp, Matrix4.identity().storage);

    for (Shard shard in shards) {
      Offset center = shard.getCenter(size);
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(shard.rotation * shatterProgress);
      canvas.translate(-center.dx + shard.velocity.dx * shatterProgress,
          -center.dy + shard.velocity.dy * shatterProgress);

      canvas.drawPath(shard.toPath(size), imagePainter);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ShatteringWidgetPainter oldDelegate) {
    return true;
  }
}
