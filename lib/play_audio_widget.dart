library play_widget;

import 'dart:math';

import 'package:flutter/material.dart';

class PlayWidget extends StatefulWidget {
  Widget child;

  PlayWidget(this.child);

  @override
  PlayWidgetState createState() => new PlayWidgetState();
}

class PlayWidgetState extends State<PlayWidget> with TickerProviderStateMixin {
  List<Animation<double>> animationList;
  AnimationController _animationController;

  @override
  void initState() {
    animationList = List();
    _animationController = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);
    animationList.add(CurvedAnimation(parent: _animationController, curve: Interval(0.0, 0.6, curve: Curves.easeInOutCubic)));
    animationList.add(CurvedAnimation(parent: _animationController, curve: Interval(0.2, 0.8, curve: Curves.easeInOutCubic)));
    animationList.add(CurvedAnimation(parent: _animationController, curve: Interval(0.4, 1.0, curve: Curves.easeInOutCubic)));

    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(50, 50),
      painter: PlayPainter(animationList),
      child: widget.child,
    );
  }
}

class PlayPainter extends CustomPainter {
  List<Animation<double>> animationList;
  final Paint paint1 = Paint()
    ..color = Colors.white
    ..strokeWidth = 10
    ..style = PaintingStyle.stroke;
  final Paint paint2 = Paint()
    ..color = Color(0xFF103447)
    ..style = PaintingStyle.fill;
  final Paint paint3 = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round;

  PlayPainter(this.animationList);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;

    double radius = size.width / 2.0;

    canvas.drawCircle(Offset(centerX, centerY), radius, paint1);
    canvas.drawCircle(Offset(centerX, centerY), radius, paint2);

    animationList.forEach((Animation<double> animation) {
      paint3.color = Color.fromARGB((255 - 85 * animation.value).toInt(), Colors.white.red, Colors.white.green, Colors.white.blue);
      canvas.drawArc(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: (radius + 2) * animation.value), -65 * (pi / 180), 65 * (pi / 180), false, paint3);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
