import 'package:gymnotes/all_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Logger().i('Firebase initialized');
  runApp(
    const ProviderScope(
      child: MainEntry(),
    ),
  );
}

class MainEntry extends StatelessWidget {
  const MainEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GymNotes',
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeMode.system,
      home: const LoadingScreen(),
      routes: {
        'loading_screen': (context) => const LoadingScreen(),
        'register_screen': (context) => const RegisterScreen(),
        'login_screen': (context) => const LoginScreen(),
        'password_screen': (context) => const PasswordScreen(),
        'home_screen': (context) => const HomeScreen(),
        'account_screen': (context) => const AccountScreen(),
        'musclegroup_screen': (context) => const MuscleGroupScreen(),
      },
    );
  }
}
