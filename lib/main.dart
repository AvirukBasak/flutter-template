import 'dart:developer';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/* Specify app root widget in runApp */
void main() {
  // debugPaintSizeEnabled = kDebugMode;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  /* They say it's a convention to provide a parameterized constructor for all
     widgets such that the constructor takes an optional key */
  const MyApp({super.key});

  /* ColorScheme.fromSeed is a work of art; it generates a full color palette
     from just a single, a SINGLE color!! */
  static final _defaultLightColorScheme = ColorScheme.fromSeed(
    // Light mode fallback theme if (device != ANDROID or device < ANDROID_12)
    seedColor: Colors.blueAccent,
    brightness: Brightness.light, // Trailing commas, OH YEAH!!
  );

  // I love this fn
  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
    // Dark mode fallback theme if (device != ANDROID or device < ANDROID_12)
    seedColor: Colors.blueAccent,
    brightness: Brightness.dark,
  );

  @override
  /* Auto invoked method that returns a newly created Widget */
  Widget build(BuildContext context) =>
      /* DynamicColorBuilder wraps MaterialApp to provide Material3 Colors on
         device >= ANDROID_12 */
      DynamicColorBuilder(
          builder: (lightColorScheme, darkColorScheme) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                // The light mode theme
                theme: ThemeData(
                  // If lightColorScheme is null, fall back
                  colorScheme: lightColorScheme ?? _defaultLightColorScheme,
                  // Use Material3 UI styles irrespective of the platform
                  useMaterial3: true,
                ),
                // The dark mode theme
                darkTheme: ThemeData(
                  colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
                  useMaterial3: true,
                ),
                /* ThemeMode.system -> Auto switch light or dark mode based on
                   system theme */
                themeMode: ThemeMode.system,
                // The starting screen of the app
                home: const HomeScreen(title: 'Flutter App'),
              ));
}

class HomeScreen extends StatefulWidget {
  /* Fields of widget subclass must always be declared final.
     Note that `const` is a compile time thing.
     But `final` is more like the one in Java. */
  final String title;

  /* The `required` keyword probably makes the parameter necessary */
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _MsgUiState();
}

class _MsgUiState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Send a Message'),
        ),
        body: Column(
          children: [
            // Empty Space in the middle
            Expanded(
              child: Container(
                // You can add any content or widgets here
                color: Theme.of(context).colorScheme.background,
                child: Center(
                  child: Text(
                    'Empty space',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            ),
            const Divider(height: 1.0),
            // Text Input Field and Send Button at the bottom
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Theme.of(context).colorScheme.background,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          hintText: 'Enter message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      color: Theme.of(context).colorScheme.onPrimary,
                      onPressed: () => {
                        if (kDebugMode && _textController.text.isNotEmpty) {
                          log('send msg: ${_textController.text}'),
                          _textController.clear(),
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    // Dispose of the text controller to avoid memory leaks
    _textController.dispose();
    super.dispose();
  }
}
