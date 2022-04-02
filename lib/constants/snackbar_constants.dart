import 'package:gymnotes/all_imports.dart';

final SnackBar snackSignUpSucces = SnackBar(
  content: const Text(
    'Successfully signed up!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackSignUpFail = SnackBar(
  content: const Text(
    'Something went wrong!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackSignInSucces = SnackBar(
  content: const Text(
    'Successfully signed in!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackSignInFail = SnackBar(
  content: const Text(
    'Something went wrong!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackSignOutSucces = SnackBar(
  content: const Text(
    'Successfully signed out!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackSignOutFail = SnackBar(
  content: const Text(
    'Something went wrong!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackWeakPassword = SnackBar(
  content: const Text(
    'Password should be at least 6 characters long!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackEmailAlreadyInUse = SnackBar(
  content: const Text(
    'Email already in use! Please try to log in!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackSignUpNotAllowed = SnackBar(
  content: const Text(
    'Sign up is not allowed! Too many requests or server down!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackInvalidEmail = SnackBar(
  content: const Text(
    'Invalid email! Please check spelling!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackPasswordsDontMatch = SnackBar(
  content: const Text(
    'Passwords do not match!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);

final SnackBar snackEmptyFields = SnackBar(
  content: const Text(
    'Please fill in all fields!',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
  duration: const Duration(seconds: 3),
  action: SnackBarAction(
    label: 'OK',
    onPressed: () {},
  ),
);