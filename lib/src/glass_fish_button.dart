import 'dart:ui';

import 'package:flutter/material.dart';

import 'theme.dart';

class GlassFishButton extends StatefulWidget {
  const GlassFishButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.brightness = GlassFishButtonBrightness.light,
    this.width,
    this.height = 42,
    this.padding,
    this.textStyle,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final GlassFishButtonBrightness brightness;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final String? semanticLabel;

  @override
  State<GlassFishButton> createState() => _GlassFishButtonState();
}

class _GlassFishButtonState extends State<GlassFishButton> {
  bool _hovered = false;
  bool _pressed = false;
  static const Duration _gradientShiftDuration = Duration(milliseconds: 820);

  bool get _isEnabled => widget.onPressed != null;

  double get _backgroundScale {
    if (!_isEnabled) {
      return 1.0;
    }
    if (_pressed) {
      return 1.09;
    }
    if (_hovered) {
      return 1.05;
    }
    return 1.0;
  }

  void _handleHover(bool hovered) {
    if (!_isEnabled || _hovered == hovered) {
      return;
    }
    setState(() => _hovered = hovered);
  }

  void _handleHighlightChanged(bool pressed) {
    if (_pressed == pressed) {
      return;
    }
    setState(() => _pressed = pressed);
  }

  Gradient _orientGradient(Gradient gradient, double t) {
    if (gradient is LinearGradient) {
      final AlignmentGeometry begin =
          AlignmentGeometry.lerp(gradient.begin, gradient.end, t) ??
              gradient.begin;
      final AlignmentGeometry end =
          AlignmentGeometry.lerp(gradient.end, gradient.begin, t) ??
              gradient.end;
      return LinearGradient(
        begin: begin,
        end: end,
        colors: gradient.colors,
        stops: gradient.stops,
        tileMode: gradient.tileMode,
        transform: gradient.transform,
      );
    }
    return gradient;
  }

  @override
  void didUpdateWidget(GlassFishButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEnabled && (_hovered || _pressed)) {
      setState(() {
        _hovered = false;
        _pressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlassFishButtonThemeData visuals =
    GlassFishButtonThemeData.resolve(widget.brightness);
    final double height = widget.height;
    final BorderRadius borderRadius = BorderRadius.circular(height / 2);
    final EdgeInsetsGeometry resolvedPadding = widget.padding ??
        const EdgeInsets.symmetric(horizontal: 1, vertical: 1);

    final TextStyle resolvedStyle = (widget.textStyle ??
        Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.25,
        ) ??
        const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.25,
        ))
        .copyWith(color: Colors.white);

    final bool enabled = _isEnabled;
    final bool flipGradients = enabled && (_hovered || _pressed);

    final Widget gradientLayers = TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: flipGradients ? 1.0 : 0.0),
      duration: _gradientShiftDuration,
      curve: Curves.easeInOutCubic,
      builder: (BuildContext context, double value, Widget? child) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: visuals.blurSigma,
                sigmaY: visuals.blurSigma,
              ),
              child: ColoredBox(
                color: widget.brightness == GlassFishButtonBrightness.light
                    ? const Color(0x21FFFFFF)
                    : const Color(0x1AF0F0F0),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: _orientGradient(visuals.surfaceGradient, value),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: _orientGradient(visuals.tintGradient, value),
              ),
            ),
            if (visuals.highlightGradient != null)
              Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.55,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: visuals.highlightGradient!,
                      borderRadius: BorderRadius.circular(height),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );

    final Widget buttonSurface = Container(
      width: widget.width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: visuals.shadows,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: enabled ? widget.onPressed : null,
            onHighlightChanged: enabled ? _handleHighlightChanged : null,
            borderRadius: borderRadius,
            splashColor: Colors.white.withOpacity(
              widget.brightness == GlassFishButtonBrightness.light ? 0.08 : 0.06,
            ),
            highlightColor: Colors.white.withOpacity(
              widget.brightness == GlassFishButtonBrightness.light ? 0.06 : 0.04,
            ),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: visuals.borderColor, width: 1.4),
              ),
              child: Container(
                padding: resolvedPadding,
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: borderRadius,
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      // Zoom glass layers on hover/press without touching the label.
                      AnimatedScale(
                        scale: _backgroundScale,
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        child: gradientLayers,
                      ),
                      Align(
                        child: TweenAnimationBuilder<double>(
                          tween:
                          Tween<double>(begin: 0.0, end: flipGradients ? 1.0 : 0.0),
                          duration: _gradientShiftDuration,
                          curve: Curves.ease,
                          builder:
                              (BuildContext context, double value, Widget? _) {
                            return _GradientText(
                              text: widget.label,
                              gradient:
                              _orientGradient(visuals.textGradient, value),
                              style: resolvedStyle,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Widget paint = AnimatedOpacity(
      opacity: enabled ? 1 : 0.7,
      duration: const Duration(milliseconds: 160),
      child: buttonSurface,
    );

    if (!enabled) {
      paint = Stack(
        children: <Widget>[
          paint,
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: visuals.disabledOverlayColor,
              ),
            ),
          ),
        ],
      );
    }

    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.semanticLabel ?? widget.label,
      child: MouseRegion(
        cursor:
        enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: enabled ? (_) => _handleHover(true) : null,
        onExit: enabled ? (_) => _handleHover(false) : null,
        child: paint,
      ),
    );
  }
}

class _GradientText extends StatelessWidget {
  const _GradientText({
    required this.text,
    required this.gradient,
    required this.style,
  });

  final String text;
  final Gradient gradient;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => gradient.createShader(bounds),
      child: Text(text, textAlign: TextAlign.center, style: style),
    );
  }
}
