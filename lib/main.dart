import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

/* Specify app root widget in runApp */
void main() => runApp(const MyApp());

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
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );

  void _incrementCounter() => setState(() => ++_counter);
}
