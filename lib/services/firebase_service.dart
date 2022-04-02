import 'package:gymnotes/all_imports.dart';

class FirebaseService {
  /*SIGN UP METHOD*/
  Future<void> signUp(context, String email, String password) async {
    try {
      final UserCredential? userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print('User signed up');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignUpSucces,
      );
      await userCredential?.user?.sendEmailVerification();
      if (kDebugMode) {
        print('Email verification email sent');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        snackEmailVerificationSent,
      );
      Navigator.of(context).pushReplacementNamed('login_screen');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          {
            if (kDebugMode) {
              print('Password is too weak');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              snackWeakPassword,
            );
            break;
          }
        case 'email-already-in-use':
          {
            if (kDebugMode) {
              print('Email already in use');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              snackEmailAlreadyInUse,
            );
            break;
          }
        case 'operation-not-allowed':
          {
            if (kDebugMode) {
              print('Sign up not allowed, too many requests or server error');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              snackSignUpNotAllowed,
            );
            break;
          }
        case 'invalid-email':
          {
            if (kDebugMode) {
              print('Invalid email, check spelling');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              snackInvalidEmail,
            );
            break;
          }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing up: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignUpFail,
      );
    }
  }

  /*SIGN IN METHOD*/
  Future<void> signIn(context, String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (kDebugMode) {
        print('User signed in');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignInSucces,
      );
      Navigator.of(context).pushReplacementNamed('home_screen');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          {
            if (kDebugMode) {
              print('Invalid email, check spelling');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              snackInvalidEmail,
            );
            break;
          }
        case 'user-disabled':
          {
            if (kDebugMode) {
              print('User is disabled');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              snackSignUpNotAllowed,
            );
            break;
          }
        case 'user-not-found':
          {
            if (kDebugMode) {
              print('No user found with this email');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              snackUserNotFound,
            );
            break;
          }
        case 'wrong-password':
          {
            if (kDebugMode) {
              print('Wrong password! Check spelling!');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              snackWrongPassword,
            );
            break;
          }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing up: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignInFail,
      );
    }
  }

  /*SIGN OUT METHOD*/
  Future<void> signOut(context) async {
    try {
      await firebaseAuth.signOut();
      if (kDebugMode) {
        print('User signed out');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignOutSucces,
      );
      Navigator.of(context).pushReplacementNamed('login_screen');
    } catch (e) {
      if (kDebugMode) {
        print('Error signing out: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignOutFail,
      );
    }
  }

  /*RECOVER PASSWORD METHOD*/
  Future<void> resetPassword(context, String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      if (kDebugMode) {
        print('Password reset email sent');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        snackResetPasswordSucces,
      );
      Navigator.of(context).pushReplacementNamed('login_screen');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'auth/invalid-email':
          {
            if (kDebugMode) {
              print('Invalid email, check spelling');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              snackInvalidEmail,
            );
            break;
          }
        case 'user-not-found':
          {
            if (kDebugMode) {
              print('No user found with this email');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              snackUserNotFound,
            );
            break;
          }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing up: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        snackResetPasswordFail,
      );
    }
  }
}