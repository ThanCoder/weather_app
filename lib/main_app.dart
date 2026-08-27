import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:weather/ui/home/home_screen.dart';

class MainApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return TMaterialThemeProvider(
      getTheme: () => .dark,
      onChanged: (type) {},
      child: const HomeScreen(),
    );
  }
}
