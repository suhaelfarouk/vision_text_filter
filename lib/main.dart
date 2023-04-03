import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:vision_text_filter/widgets/vision_filter_widget.dart';

import 'providers/profanity_filter_provider.dart';
import 'providers/vision_filter_provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => VisionFilterProvider()),
    ChangeNotifierProvider(create: (_) => ProfanityFilterProvider()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: VisionFilterWidget(),
        // ProfanityFilterWidget(),
      ),
    );
  }
}
