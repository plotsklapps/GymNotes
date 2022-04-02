import 'package:gymnotes/all_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainEntry());
}

class MainEntry extends StatelessWidget {
  const MainEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymNotes',
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
