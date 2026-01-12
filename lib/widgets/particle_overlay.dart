import 'dart:math';
import 'package:flutter/material.dart';

class ParticleOverlay extends StatefulWidget {
  final int particleCount;
  final Color color;

  const ParticleOverlay({
    super.key,
    this.particleCount = 30,
    this.color = Colors.white,
  });

  @override
  State<ParticleOverlay> createState() => _ParticleOverlayState();
}

class _ParticleOverlayState extends State<ParticleOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Very long duration to minimize visible reset
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
    
    _particles = List.generate(widget.particleCount, (index) => _createParticle());
  }

  Particle _createParticle() {
    return Particle(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      speed: 0.3 + _random.nextDouble() * 0.7, // Normalized speed (0.3-1.0 range for 60s cycle)
      opacity: 0.1 + _random.nextDouble() * 0.4,
      size: 1.0 + _random.nextDouble() * 2.0,
      offset: _random.nextDouble(), // Random phase offset for each particle
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            particles: _particles,
            progress: _controller.value,
            color: widget.color,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  double speed;
  double opacity;
  double size;
  double offset; // Phase offset for staggered animation

  Particle({
    required this.x, 
    required this.y, 
    required this.speed, 
    required this.opacity, 
    required this.size,
    required this.offset,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;
  final Color color;

  ParticlePainter({required this.particles, required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var particle in particles) {
      // Add particle's individual offset to create staggered movement
      // This desynchronizes particles so they don't all reset at once
      double particleProgress = (progress + particle.offset) % 1.0;
      
      // Move particle upwards - each particle has its own rhythm
      double currentY = (particle.y - (particleProgress * particle.speed)) % 1.0;
      if (currentY < 0) currentY += 1.0;

      // Slight horizontal wobble
      double currentX = (particle.x + sin(particleProgress * 2 * pi + particle.y * 10) * 0.03) % 1.0;
      if (currentX < 0) currentX += 1.0;

      // Fade-in at bottom and fade-out at top for seamless visual loop
      double fadeOpacity = 1.0;
      if (currentY > 0.90) {
        fadeOpacity = (1.0 - currentY) / 0.10; // Fade in from bottom
      } else if (currentY < 0.10) {
        fadeOpacity = currentY / 0.10; // Fade out at top
      }
      
      paint.color = color.withOpacity(particle.opacity * fadeOpacity.clamp(0.0, 1.0));
      canvas.drawCircle(
        Offset(currentX * size.width, currentY * size.height), 
        particle.size, 
        paint
      );
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}
