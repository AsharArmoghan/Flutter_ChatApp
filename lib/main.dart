import 'package:chat_app/Providers/theme_provider.dart';
import 'package:chat_app/Screen/Chat/chat_screen.dart';
import 'package:chat_app/Theme/theme_ios/apple_dark.dart';
import 'package:chat_app/Theme/theme_ios/apple_light.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appleIOSLightTheme,
      darkTheme: appleIOSDarkTheme,
      themeMode: theme.flutterMode,
      title: 'Flutter Chat UI',
      home: ChatScreen(),
    );
  }
}
