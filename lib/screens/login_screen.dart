import 'package:gymnotes/all_imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailCtrl;
  late final TextEditingController _passwordCtrl;

  @override
  void initState() {
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              const SizedBox(height: 16.0),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No account yet?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('register_screen');
                    },
                    child: const Text(
                      'Create one!',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailCtrl,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordCtrl,
                enableSuggestions: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('LOGIN'),
                onPressed: () async {
                  //TODO: Fix this! It's not working! Always returns false!
                  if (currentUser?.emailVerified ?? false) {
                    await FirebaseService().signIn(
                      context,
                      _emailCtrl.text,
                      _passwordCtrl.text,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackVerifyEmailFirst,
                    );
                  }
                  return;
                },
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Forgot password?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('password_screen');
                    },
                    child: const Text(
                      'Reset it!',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}