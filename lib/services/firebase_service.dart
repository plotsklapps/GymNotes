import 'package:gymnotes/all_imports.dart';

class FirebaseService {
  /*SIGN UP METHOD*/
  Future<void> signUp(context, String email, String password) async {
    try {
      final UserCredential? userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      Logger().i('User signed up');
      await showCustomSnackBar(context, 'Sign up successful!');
      /*SEND EMAIL VERIFICATION AND GO TO LOGINSCREEN*/
      await userCredential?.user?.sendEmailVerification();
      Logger().i('Verification email sent');
      await showCustomSnackBar(context, 'Verification email sent!');
      Navigator.of(context).pushReplacementNamed('login_screen');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          {
            Logger().i('Password is too weak');
            await showCustomSnackBar(
              context,
              'Password should be at least 6 characters!',
            );
            throw WeakPasswordException();
          }
        case 'email-already-in-use':
          {
            Logger().i('Email already in use');
            await showCustomSnackBar(context, 'Email is already in use!');
            throw EmailAlreadyInUseException();
          }
        case 'operation-not-allowed':
          {
            Logger()
                .i('Sign up not allowed, too many requests or server error');
            await showCustomSnackBar(
              context,
              'Sign up not allowed! Too many requests or server error!',
            );
            throw OperationNotAllowedException();
          }
        case 'invalid-email':
          {
            Logger().i('Invalid email, check spelling');
            await showCustomSnackBar(context, 'Invalid email, check spelling!');
            throw InvalidEmailException();
          }
      }
    } catch (e) {
      Logger().i('Error signing up: $e');
      await showCustomSnackBar(
        context,
        'Something went wrong, please try again later!',
      );
      throw GenericException();
    }
  }

  /*SIGN IN METHOD*/
  Future<void> signIn(context, String email, String password) async {
    try {
      /*CHECK IF TEXTFIELDS ARE EMPTY*/
      if (email.isEmpty || password.isEmpty) {
        Logger().i('Email or password is empty');
        await showCustomSnackBar(context, 'Please fill in all fields!');
        return;
        /*CHECK IF EMAIL SPELLING IS CORRECT*/
      } else if (!email.contains('@') || email.contains(' ')) {
        Logger().i('Email is invalid');
        await showCustomSnackBar(
          context,
          'Invalid email! Please check spelling!',
        );
        return;
      } else {
        /*FIREBASE SIGN IN METHOD*/
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        /*IF USER CLICKED VERIFICATION EMAIL GO TO HOMESCREEN*/
        if (firebaseAuth.currentUser!.emailVerified) {
          Logger().i('User is verified');
          await showCustomSnackBar(
            context,
            'Verified user, welcome to GymNotes!',
          );
          Navigator.pushReplacementNamed(
            context,
            'home_screen',
          );
        }
        /*IF USER DID NOT CLICK VERIFICATION EMAIL SHOW SNACK AND STAY*/
        else if (!firebaseAuth.currentUser!.emailVerified) {
          Logger().i('User is NOT verified');
          await showCustomSnackBar(
            context,
            'Please verify your email address first!',
          );
        }
      }
      /*ALL OTHER FIREBASE ERROR SITUATIONS*/
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          {
            Logger().i('Invalid email, check spelling');
            await showCustomSnackBar(
              context,
              'Invalid email! Please check spelling!',
            );
            break;
          }
        case 'user-disabled':
          {
            Logger().i('User is disabled');
            await showCustomSnackBar(context, 'User disabled from siging up!');
            break;
          }
        case 'user-not-found':
          {
            Logger().i('No user found with this email');
            await showCustomSnackBar(context, 'No user found with this email!');
            break;
          }
        case 'wrong-password':
          {
            Logger().i('Wrong password! Check spelling!');
            await showCustomSnackBar(
              context,
              'Wrong password! Please check spelling!',
            );
            break;
          }
      }
    } catch (e) {
      Logger().i('Error signing in: $e');
      await showCustomSnackBar(
        context,
        'Sign in failed! Please try again later!',
      );
    }
  }

  /*SIGN OUT METHOD*/
  Future<void> signOut(context) async {
    try {
      await firebaseAuth.signOut();
      Logger().i('User signed out');
      await showCustomSnackBar(context, 'Successfully signed out!');
      Navigator.of(context).pushReplacementNamed('login_screen');
    } catch (e) {
      Logger().i('Error signing out: $e');
      await showCustomSnackBar(
        context,
        'Sign out failed! Please try again later!',
      );
    }
  }

  /*RESET PASSWORD METHOD*/
  Future<void> resetPassword(context, String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Logger().i('Password reset email sent');
      await showCustomSnackBar(context, 'Password reset email has been sent!');
      Navigator.of(context).pushReplacementNamed('login_screen');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          {
            Logger().i('Invalid email, check spelling');
            await showCustomSnackBar(
              context,
              'Invalid email! Please check spelling!',
            );
            break;
          }
        case 'user-not-found':
          {
            Logger().i('No user found with this email');
            await showCustomSnackBar(
              context,
              'No user found with this email!',
            );
            break;
          }
      }
    } catch (e) {
      Logger().i('Error resetting password: $e');
      await showCustomSnackBar(
        context,
        'An error occurred! Please try again later!',
      );
    }
  }
}

class FirebaseUser {
  final String? email;
  final bool isEmailVerified;
  const FirebaseUser({required this.email, required this.isEmailVerified,});

  factory FirebaseUser.fromFirebase(User user) => FirebaseUser(email: user.email,isEmailVerified: user.emailVerified);
}
