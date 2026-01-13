import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dream_boat_mobile/theme/app_theme.dart';

class NightSkyBackground extends StatefulWidget {
  final Widget child;
  final bool isPro;
  const NightSkyBackground({super.key, required this.child, this.isPro = false});

  @override
  State<NightSkyBackground> createState() => _NightSkyBackgroundState();
}

class _NightSkyBackgroundState extends State<NightSkyBackground> with TickerProviderStateMixin {
  late AnimationController _nebulaController;
  late AnimationController _starController;
  late AnimationController _shootingStarController;
  double _startX = 0;
  double _startY = 0;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    
    // Nebula Drifting Animation (Slow Breathing)
    _nebulaController = AnimationController(
        vsync: this, duration: const Duration(seconds: 20));

    // Star Twinkle
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    
    // Shooting Stars
    _shootingStarController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3)
    );
     
    _shootingStarController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
         _randomizeShootingStar();
      } else if (status == AnimationStatus.completed) {
         _shootingStarController.forward(from: 0.0); 
      }
    });

    // Delay animation start to let the app render first
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _nebulaController.repeat(reverse: true);
        _starController.repeat(reverse: true);
        _randomizeShootingStar();
        _shootingStarController.forward();
      }
    });
  }

  void _randomizeShootingStar() {
      // Random start position - no setState needed, just update values
      _startX = 0.4 + (_random.nextDouble() * 0.5); 
      _startY = 0.05 + (_random.nextDouble() * 0.3); 
  }

  @override
  void dispose() {
    _nebulaController.dispose();
    _starController.dispose();
    _shootingStarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Deep Space Base
        Container(
          color: AppTheme.bgStart, // Deep Void
        ),

        // 2. Drifting Nebulae Layers
        // Cyan Nebula (Top Left)
        AnimatedBuilder(
          animation: _nebulaController,
          builder: (context, child) {
            return Positioned(
              top: -100 + (sin(_nebulaController.value * pi) * 30), // Drift Y
              left: -100 + (cos(_nebulaController.value * pi) * 20), // Drift X
              width: 500,
              height: 500,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.nebulaCyan.withOpacity(0.2), 
                      Colors.transparent
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            );
          }
        ),
        
        // Magenta Nebula (Bottom Right)
        AnimatedBuilder(
          animation: _nebulaController,
          builder: (context, child) {
            return Positioned(
              bottom: -100 - (sin(_nebulaController.value * pi) * 30),
              right: -100 - (cos(_nebulaController.value * pi) * 20),
              width: 600,
              height: 600,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.nebulaMagenta.withOpacity(0.15), 
                      Colors.transparent
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            );
          }
        ),

        // 3. Mystic Gold Dust & Stars
        AnimatedBuilder(
          animation: _starController,
          builder: (context, child) {
            return CustomPaint(
              painter: MysticStarPainter(_starController.value, isPro: widget.isPro),
              size: MediaQuery.of(context).size,
            );
          },
        ),

        // 4. Shooting Stars
        AnimatedBuilder(
          animation: _shootingStarController,
          builder: (context, child) {
            return CustomPaint(
              painter: ShootingStarPainter(_shootingStarController.value, _startX, _startY),
              size: MediaQuery.of(context).size,
            );
          },
        ),

        // 5. Subtle Grain Overlay (Simulated with random noise points if cheap, or skip for performance)
        // Skipping Grain for performance/simplicity, using gradients for atmosphere.

        // 6. Child Content
        widget.child,
      ],
    );
  }
}

class MysticStarPainter extends CustomPainter {
  final double opacity;
  final bool isPro;
  
  // Static cached star data to prevent regeneration on rebuild
  static List<_MysticStarData>? _cachedWhiteStars;
  static List<_MysticStarData>? _cachedGoldStars;
  static List<_MysticStarData>? _cachedGoldStarsPro;
  
  MysticStarPainter(this.opacity, {this.isPro = false});
  
  static List<_MysticStarData> _generateWhiteStars() {
    if (_cachedWhiteStars != null) return _cachedWhiteStars!;
    final random = Random(42);
    _cachedWhiteStars = List.generate(40, (i) {
      double r = random.nextDouble();
      return _MysticStarData(
        xPercent: random.nextDouble(),
        yPercent: random.nextDouble(),
        radius: r < 0.8 ? 1.0 : 2.0,
      );
    });
    return _cachedWhiteStars!;
  }
  
  static List<_MysticStarData> _generateGoldStars(int count, int seed) {
    final random = Random(seed);
    return List.generate(count, (i) {
      return _MysticStarData(
        xPercent: random.nextDouble(),
        yPercent: random.nextDouble(),
        radius: 0.8,
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Base White Stars
    final paintWhite = Paint()
      ..color = Colors.white.withOpacity(0.6 + (0.4 * opacity))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);
    
    // 2. Mystic Gold Dust (Fainter, smaller)
    final paintGold = Paint()
      ..color = AppTheme.goldDust.withOpacity(0.4 + (0.2 * opacity)) // Variable opacity
      ..style = PaintingStyle.fill;

    // Draw White Stars (cached)
    final whiteStars = _generateWhiteStars();
    for (final star in whiteStars) {
      double x = star.xPercent * size.width;
      double y = star.yPercent * size.height;
      canvas.drawCircle(Offset(x, y), star.radius, paintWhite);
    }

    // Draw Gold Dust (cached based on isPro)
    final goldStars = isPro 
      ? (_cachedGoldStarsPro ??= _generateGoldStars(60, 100))
      : (_cachedGoldStars ??= _generateGoldStars(30, 200));
    
    for (final star in goldStars) {
      double x = star.xPercent * size.width;
      double y = star.yPercent * size.height;
      canvas.drawCircle(Offset(x, y), star.radius, paintGold);
    }
  }

  @override
  bool shouldRepaint(MysticStarPainter oldDelegate) => oldDelegate.opacity != opacity || oldDelegate.isPro != isPro;
}

class _MysticStarData {
  final double xPercent;
  final double yPercent;
  final double radius;
  
  const _MysticStarData({
    required this.xPercent,
    required this.yPercent,
    required this.radius,
  });
}

class ShootingStarPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0
  final double normX;
  final double normY;

  ShootingStarPainter(this.progress, this.normX, this.normY);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress > 0.15) return; 

    final double fade = 1.0 - (progress / 0.15); 
    
    final paint = Paint()
      ..color = Colors.white.withOpacity(fade.clamp(0.0, 1.0))
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double startX = size.width * normX;
    double startY = size.height * normY;
    
    // Movement: Down-Left
    double moveX = -300.0 * (progress / 0.15);
    double moveY = 150.0 * (progress / 0.15);

    double currentX = startX + moveX;
    double currentY = startY + moveY;
    
    // Draw tail
    canvas.drawLine(Offset(currentX - (moveX * 0.2), currentY - (moveY * 0.2)), Offset(currentX, currentY), paint);
    
    // Glowing head
    final headPaint = Paint()
      ..color = Colors.white.withOpacity(fade.clamp(0.0, 1.0))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(Offset(currentX, currentY), 3.0, headPaint);
  }

  @override
  bool shouldRepaint(ShootingStarPainter oldDelegate) => oldDelegate.progress != progress || oldDelegate.normX != normX;
}
