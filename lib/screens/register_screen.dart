import 'package:gymnotes/all_imports.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _emailCtrl;
  late final TextEditingController _password1Ctrl;
  late final TextEditingController _password2Ctrl;

  @override
  void initState() {
    _emailCtrl = TextEditingController();
    _password1Ctrl = TextEditingController();
    _password2Ctrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _password1Ctrl.dispose();
    _password2Ctrl.dispose();
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
                'Register',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('login_screen');
                    },
                    child: const Text(
                      'Login here!',
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
                controller: _password1Ctrl,
                enableSuggestions: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _password2Ctrl,
                enableSuggestions: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('REGISTER'),
                onPressed: () async {
                  if (_password1Ctrl.text != _password2Ctrl.text) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackPasswordsDontMatch);
                    return;
                  } else if (_emailCtrl.text.isEmpty ||
                      _password1Ctrl.text.isEmpty ||
                      _password2Ctrl.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackEmptyFields);
                    return;
                  } else if (!_emailCtrl.text.contains('@') ||
                      _emailCtrl.text.contains(' ')) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackInvalidEmail);
                    return;
                  } else {
                    await FirebaseService().signUp(
                      context,
                      _emailCtrl.text.trim(),
                      _password1Ctrl.text,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
