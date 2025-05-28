import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MadlibsRoot(), // Use new root widget
    );
  }
}

// New root widget to handle navigation between start and main screens
class MadlibsRoot extends StatefulWidget {
  const MadlibsRoot({super.key});

  @override
  State<MadlibsRoot> createState() => _MadlibsRootState();
}

class _MadlibsRootState extends State<MadlibsRoot> {
  bool _showStartScreen = true;
  bool _showWordEntry = false;
  List<String>? _userWords;

  void _continueToGame() {
    setState(() {
      _showStartScreen = false;
      _showWordEntry = true;
    });
  }

  void _onWordsSubmitted(List<String> words) {
    setState(() {
      _showWordEntry = false;
      _userWords = words;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showStartScreen) {
      return StartScreen(onContinue: _continueToGame);
    } else if (_showWordEntry) {
      return WordEntryPage(onSubmit: _onWordsSubmitted);
    } else if (_userWords != null) {
      return StoryPage(words: _userWords!);
    } else {
      return MyHomePage(title: 'Flutter Demo Home Page');
    }
  }
}

// Add a start screen that describes how Madlibs work
class StartScreen extends StatelessWidget {
  final VoidCallback onContinue;
  const StartScreen({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF176), // bright yellow
              Color(0xFFFF8A65), // orange
              Color(0xFF81D4FA), // light blue
              Color(0xFFA5D6A7), // light green
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Comical title with emoji
              const Text(
                '😂 MADLIBS 😂',
                style: TextStyle(
                  fontFamily: 'Comic Sans MS',
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(blurRadius: 8, color: Colors.white, offset: Offset(2, 2)),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'The Silliest Word Game!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                  letterSpacing: 1,
                  fontFamily: 'Comic Sans MS',
                  shadows: [
                    Shadow(blurRadius: 8, color: Colors.yellow, offset: Offset(2, 2)),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Comical intro text
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      '''Welcome to Madlibs, the game where your wildest words create the wackiest stories! 🦄

You'll be asked for silly nouns, verbs, and adjectives. The more ridiculous, the better!

Ready to laugh? Let's get goofy!''',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Comic Sans MS',
                        height: 1.5,
                        shadows: [
                          Shadow(blurRadius: 8, color: Colors.white, offset: Offset(2, 2)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Fun emoji row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('🤪', style: TextStyle(fontSize: 36)),
                  SizedBox(width: 12),
                  Text('🦄', style: TextStyle(fontSize: 36)),
                  SizedBox(width: 12),
                  Text('😂', style: TextStyle(fontSize: 36)),
                  SizedBox(width: 12),
                  Text('🎉', style: TextStyle(fontSize: 36)),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
                  textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Comic Sans MS'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                onPressed: onContinue,
                child: const Text('Let the Laughter Begin!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }
}

// Page for entering 10 words
class WordEntryPage extends StatefulWidget {
  final void Function(List<String> words) onSubmit;
  const WordEntryPage({super.key, required this.onSubmit});

  @override
  State<WordEntryPage> createState() => _WordEntryPageState();
}

class _WordEntryPageState extends State<WordEntryPage> {
  // Prompts for each word, matching the story template
  final List<String> _prompts = [
    'Enter a noun',
    'Enter a verb',
    'Enter an adjective',
    'Enter another noun',
    'Enter a place',
    'Enter another verb',
    'Enter an adjective',
    'Enter another noun',
    'Enter an adjective',
    'Enter a verb ending in -ing',
  ];

  final List<TextEditingController> _controllers =
      List.generate(10, (_) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final words = _controllers.map((c) => c.text.trim()).toList();
      widget.onSubmit(words);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Your Words')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Please enter the requested words:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ...List.generate(10, (i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: _controllers[i],
                      decoration: InputDecoration(
                        labelText: _prompts[i],
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a word';
                        }
                        return null;
                      },
                    ),
                  )),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Page to display the Madlib story using the entered words
class StoryPage extends StatelessWidget {
  final List<String> words;
  const StoryPage({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    // Example Madlib story using the 10 words
    final story = '''
Once upon a time, there was a ${words[0]} who loved to ${words[1]} every day. One day, the ${words[0]} met a ${words[2]} ${words[3]} in the ${words[4]}. Together, they decided to ${words[5]} a ${words[6]} ${words[7]}. It was the most ${words[8]} day ever, and they finished by ${words[9]} into the sunset.''';

    return Scaffold(
      appBar: AppBar(title: const Text('Your Madlib Story')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Here is your story:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                story,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Reset the flow by using a callback to the root state
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MadlibsRoot()),
                    (route) => false,
                  );
                },
                child: const Text('Play Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
