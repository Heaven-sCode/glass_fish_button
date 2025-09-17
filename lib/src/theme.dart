import 'package:flutter/material.dart';

enum GlassFishButtonBrightness { light, dark }

class GlassFishButtonThemeData {
  const GlassFishButtonThemeData({
    required this.surfaceGradient,
    required this.tintGradient,
    required this.textGradient,
    required this.shadows,
    required this.borderColor,
    required this.blurSigma,
    this.highlightGradient,
    this.disabledOverlayColor = const Color(0x26000000),
  });

  final Gradient surfaceGradient;
  final Gradient tintGradient;
  final Gradient textGradient;
  final Gradient? highlightGradient;
  final List<BoxShadow> shadows;
  final Color borderColor;
  final double blurSigma;
  final Color disabledOverlayColor;

  static GlassFishButtonThemeData resolve(
      GlassFishButtonBrightness brightness,
      ) {
    switch (brightness) {
      case GlassFishButtonBrightness.dark:
        return _dark;
      case GlassFishButtonBrightness.light:
      default:
        return _light;
    }
  }

  static final GlassFishButtonThemeData _light = GlassFishButtonThemeData(
    surfaceGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Color(0xF0FFFFFF),
        Color(0xE6F6FBFF),
        Color(0xF0FFFFFF),
      ],
      stops: <double>[0.0, 0.5, 1.0],
    ),
    tintGradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Color(0x66FFCBF0),
        Color(0x6678C3FF),
        Color(0x66FFB5A7),
      ],
      stops: <double>[0.0, 0.45, 1.0],
    ),
    highlightGradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color(0xB3FFFFFF),
        Color(0x00FFFFFF),
      ],
    ),
    textGradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Color(0xFF9487FF),
        Color(0xFF4FA7FF),
      ],
    ),
    shadows: <BoxShadow>[
      BoxShadow(
        color: Color(0x33091C42),
        offset: Offset(0, 18),
        blurRadius: 32,
        spreadRadius: -4,
      ),
      BoxShadow(
        color: Color(0x80FFFFFF),
        offset: Offset(0, 1),
        blurRadius: 0,
        spreadRadius: 0,
      ),
    ],
    borderColor: const Color(0x80FFFFFF),
    blurSigma: 22,
    disabledOverlayColor: const Color(0x19000000),
  );

  static final GlassFishButtonThemeData _dark = GlassFishButtonThemeData(
    surfaceGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Color(0xB3262731),
        Color(0x66424078),
        Color(0xB3162231),
      ],
      stops: <double>[0.0, 0.45, 1.0],
    ),
    tintGradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Color(0x60FF8FA3),
        Color(0x601E88FF),
        Color(0x60FFB677),
      ],
      stops: <double>[0.0, 0.55, 1.0],
    ),
    highlightGradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color(0x40FFFFFF),
        Color(0x00000000),
      ],
    ),
    textGradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Color(0xFFF3EDFF),
        Color(0xFF9AC5FF),
      ],
    ),
    shadows: <BoxShadow>[
      BoxShadow(
        color: Color(0x66000000),
        offset: Offset(0, 24),
        blurRadius: 48,
        spreadRadius: -12,
      ),
      BoxShadow(
        color: Color(0x3DFFFFFF),
        offset: Offset(0, 2),
        blurRadius: 6,
        spreadRadius: -3,
      ),
    ],
    borderColor: const Color(0x59FFFFFF),
    blurSigma: 26,
    disabledOverlayColor: const Color(0x33000000),
  );
}
