import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DreamImageShareCard extends StatelessWidget {
  final String imageUrl;
  final String watermarkText;

  const DreamImageShareCard({
    super.key,
    required this.imageUrl,
    required this.watermarkText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F0F23), // Dark background matching app theme
      width: 1024, // High res target
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. The Dream Image (Square)
          AspectRatio(
            aspectRatio: 1.0, 
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: const Color(0xFF1a1a2e)),
            ),
          ),
          
          // 2. Watermark Footer
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            decoration: const BoxDecoration(
              color: Color(0xFF0F0F23),
              border: Border(top: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/db_logo_icon.png',
                  height: 40,
                  width: 40,
                ),
                const SizedBox(width: 16),
                // Text
                Text(
                  watermarkText,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontFamily: 'Inter', // Assuming Inter is available or default
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
