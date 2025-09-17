import 'package:flutter/material.dart';
import 'package:glass_fish_button/glass_fish_button.dart';

void main() {
  runApp(const _DemoApp());
}

class _DemoApp extends StatefulWidget {
  const _DemoApp();

  @override
  State<_DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<_DemoApp> {
  GlassFishButtonBrightness _brightness = GlassFishButtonBrightness.light;

  @override
  Widget build(BuildContext context) {
    final bool isDark = _brightness == GlassFishButtonBrightness.dark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A84FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF10131A)
            : const Color(0xFFF6F7FB),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GlassFishButton(
                label: 'Download for Mac',
                brightness: _brightness,
                onPressed: () {},
              ),
              const SizedBox(height: 28),
              SegmentedButton<GlassFishButtonBrightness>(
                segments: const <ButtonSegment<GlassFishButtonBrightness>>[
                  ButtonSegment(
                    value: GlassFishButtonBrightness.light,
                    label: Text('Light'),
                  ),
                  ButtonSegment(
                    value: GlassFishButtonBrightness.dark,
                    label: Text('Dark'),
                  ),
                ],
                selected: <GlassFishButtonBrightness>{_brightness},
                onSelectionChanged: (Set<GlassFishButtonBrightness> value) {
                  setState(() => _brightness = value.first);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
