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
    timer = Timer(const Duration(seconds: 3), () {
      if (currentUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Welcome back!',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        );
        Navigator.pushReplacementNamed(context, 'home_screen');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackWelcomeToGymNotes,
        );
        Navigator.pushReplacementNamed(context, 'login_screen');
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
              children: const [
                Text(
                  'GymNotes',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.0),
                CircularProgressIndicator(
                  strokeWidth: 12.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
