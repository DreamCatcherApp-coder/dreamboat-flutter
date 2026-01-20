import 'package:flutter/material.dart';

/// DreamBoat Logo Icon Widget
/// 
/// A custom-painted logo that can be used anywhere like a regular Icon.
/// Fully scalable, supports any color, and has zero file size overhead.
/// 
/// Usage:
/// ```dart
/// DreamBoatLogo(size: 32, color: Colors.amber)
/// DreamBoatLogo(size: 24, color: Colors.white)
/// ```
class DreamBoatLogo extends StatelessWidget {
  final double size;
  final Color color;

  const DreamBoatLogo({
    super.key,
    this.size = 24,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DreamBoatLogoPainter(color: color),
      ),
    );
  }
}

class _DreamBoatLogoPainter extends CustomPainter {
  final Color color;

  _DreamBoatLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.035
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width;
    final scale = s / 100;

    canvas.save();
    canvas.scale(scale, scale);

    // === Genie Lamp Body (Main Shape) ===
    final lamp = Path();
    
    // Left curl/handle
    lamp.moveTo(18, 70);
    lamp.cubicTo(8, 68, 5, 60, 12, 52);
    lamp.cubicTo(16, 48, 22, 50, 25, 55);
    
    // Bottom of lamp
    lamp.cubicTo(35, 72, 65, 72, 75, 55);
    
    // Right spout
    lamp.cubicTo(80, 48, 88, 48, 95, 50);
    lamp.cubicTo(98, 51, 98, 55, 95, 56);
    lamp.cubicTo(90, 58, 82, 60, 78, 62);
    
    // Close bottom
    lamp.cubicTo(70, 78, 30, 78, 18, 70);
    
    canvas.drawPath(lamp, paint);

    // === Mast (vertical line) ===
    final mastPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.round;
    
    canvas.drawLine(
      const Offset(50, 18),
      const Offset(50, 62),
      mastPaint,
    );

    // === Left Sail (D shape) ===
    final leftSail = Path();
    leftSail.moveTo(48, 18);
    leftSail.lineTo(30, 18);
    leftSail.cubicTo(25, 18, 25, 28, 30, 38);
    leftSail.cubicTo(35, 48, 42, 52, 48, 52);
    
    canvas.drawPath(leftSail, paint);
    
    // Inner curve of left sail
    final leftInner = Path();
    leftInner.moveTo(45, 24);
    leftInner.cubicTo(38, 26, 34, 35, 38, 44);
    leftInner.cubicTo(40, 48, 45, 48, 45, 48);
    
    canvas.drawPath(leftInner, paint);

    // === Right Sail (B shape) ===
    final rightSail = Path();
    rightSail.moveTo(52, 18);
    rightSail.lineTo(68, 18);
    rightSail.cubicTo(78, 18, 80, 26, 75, 32);
    rightSail.cubicTo(82, 36, 82, 48, 72, 52);
    rightSail.lineTo(52, 52);
    
    canvas.drawPath(rightSail, paint);
    
    // Inner curves of B (two bumps)
    final bInner = Path();
    bInner.moveTo(56, 24);
    bInner.cubicTo(65, 24, 70, 26, 68, 32);
    bInner.cubicTo(65, 36, 58, 35, 56, 35);
    
    bInner.moveTo(56, 40);
    bInner.cubicTo(68, 40, 74, 44, 70, 50);
    bInner.cubicTo(66, 52, 58, 50, 56, 48);
    
    canvas.drawPath(bInner, paint);

    // === Water Waves ===
    final waves = Path();
    waves.moveTo(8, 82);
    waves.quadraticBezierTo(18, 78, 28, 82);
    waves.quadraticBezierTo(38, 86, 48, 82);
    
    waves.moveTo(52, 82);
    waves.quadraticBezierTo(62, 78, 72, 82);
    waves.quadraticBezierTo(82, 86, 92, 82);
    
    canvas.drawPath(waves, paint);

    // === Decorative curl on left ===
    final curl = Path();
    curl.moveTo(12, 72);
    curl.cubicTo(8, 76, 6, 82, 12, 85);
    curl.cubicTo(18, 86, 20, 82, 18, 78);
    
    canvas.drawPath(curl, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _DreamBoatLogoPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
