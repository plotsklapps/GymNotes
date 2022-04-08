import 'package:gymnotes/all_imports.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 3), () async {
      if (currentUser != null) {
        await showCustomSnackBar(context, 'Welcome back!').then(
          (_) => Navigator.of(context).pushReplacementNamed('home_screen'),
        );
      } else {
        await showCustomSnackBar(context, 'Welcome to GymNotes!').then(
          (_) => Navigator.pushReplacementNamed(context, 'login_screen'),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'GymNotes',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24.0),
                const CircularProgressIndicator(
                  strokeWidth: 12.0,
                ),
                const SizedBox(height: 24.0),
                Image.asset(
                  'assets/images/plotsklappsLogo.png',
                  scale: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
