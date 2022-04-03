import 'package:gymnotes/all_imports.dart';

class FirebaseService {
  /*SIGN UP METHOD*/
  Future<void> signUp(context, String email, String password) async {
    try {
      final UserCredential? userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      Logger().i('User signed up');
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignUpSucces,
      );
      /*SEND EMAIL VERIFICATION AND GO TO LOGINSCREEN*/
      await userCredential?.user?.sendEmailVerification();
      Logger().i('Verification email sent');
      ScaffoldMessenger.of(context).showSnackBar(
        snackEmailVerificationSent,
      );
      Navigator.of(context).pushReplacementNamed('login_screen');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          {
            Logger().i('Password is too weak');
            ScaffoldMessenger.of(context).showSnackBar(
              snackWeakPassword,
            );
            throw WeakPasswordException();
          }
        case 'email-already-in-use':
          {
            Logger().i('Email already in use');
            ScaffoldMessenger.of(context).showSnackBar(
              snackEmailAlreadyInUse,
            );
            throw EmailAlreadyInUseException();
          }
        case 'operation-not-allowed':
          {
            Logger()
                .i('Sign up not allowed, too many requests or server error');
            ScaffoldMessenger.of(context).showSnackBar(
              snackSignUpNotAllowed,
            );
            throw OperationNotAllowedException();
          }
        case 'invalid-email':
          {
            Logger().i('Invalid email, check spelling');
            ScaffoldMessenger.of(context).showSnackBar(
              snackInvalidEmail,
            );
            throw InvalidEmailException();
          }
      }
    } catch (e) {
      Logger().i('Error signing up: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignUpFail,
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
        ScaffoldMessenger.of(context).showSnackBar(
          snackEmptyFields,
        );
        return;
        /*CHECK IF EMAIL SPELLING IS CORRECT*/
      } else if (!email.contains('@') || email.contains(' ')) {
        Logger().i('Email is invalid');
        ScaffoldMessenger.of(context).showSnackBar(
          snackInvalidEmail,
        );
        return;
      } else {
        /*FIREBASE SIGN IN METHOD*/
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        /*IF USER CLICKED VERIFICATION EMAIL GO TO HOMESCREEN*/
        if (firebaseAuth.currentUser!.emailVerified) {
          Logger().i('User is verified');
          ScaffoldMessenger.of(context).showSnackBar(
            snackEmailVerified,
          );
          Navigator.pushReplacementNamed(
            context,
            'home_screen',
          );
        }
        /*IF USER DID NOT CLICK VERIFICATION EMAIL SHOW SNACK AND STAY*/
        else if (!firebaseAuth.currentUser!.emailVerified) {
          Logger().i('User is NOT verified');
          ScaffoldMessenger.of(context).showSnackBar(
            snackVerifyEmailFirst,
          );
        }
      }
      /*ALL OTHER FIREBASE ERROR SITUATIONS*/
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          {
            Logger().i('Invalid email, check spelling');
            ScaffoldMessenger.of(context).showSnackBar(
              snackInvalidEmail,
            );
            break;
          }
        case 'user-disabled':
          {
            Logger().i('User is disabled');
            ScaffoldMessenger.of(context).showSnackBar(
              snackSignUpNotAllowed,
            );
            break;
          }
        case 'user-not-found':
          {
            Logger().i('No user found with this email');
            ScaffoldMessenger.of(context).showSnackBar(
              snackUserNotFound,
            );
            break;
          }
        case 'wrong-password':
          {
            Logger().i('Wrong password! Check spelling!');
            ScaffoldMessenger.of(context).showSnackBar(
              snackWrongPassword,
            );
            break;
          }
      }
    } catch (e) {
      Logger().i('Error signing in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignInFail,
      );
    }
  }

  /*SIGN OUT METHOD*/
  Future<void> signOut(context) async {
    try {
      await firebaseAuth.signOut();
      Logger().i('User signed out');
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignOutSucces,
      );
      Navigator.of(context).pushReplacementNamed('login_screen');
    } catch (e) {
      Logger().i('Error signing out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        snackSignOutFail,
      );
    }
  }

  /*RESET PASSWORD METHOD*/
  Future<void> resetPassword(context, String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Logger().i('Password reset email sent');
      ScaffoldMessenger.of(context).showSnackBar(
        snackResetPasswordSucces,
      );
      Navigator.of(context).pushReplacementNamed('login_screen');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          {
            Logger().i('Invalid email, check spelling');
            ScaffoldMessenger.of(context).showSnackBar(
              snackInvalidEmail,
            );
            break;
          }
        case 'user-not-found':
          {
            Logger().i('No user found with this email');
            ScaffoldMessenger.of(context).showSnackBar(
              snackUserNotFound,
            );
            break;
          }
      }
    } catch (e) {
      Logger().i('Error resetting password: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        snackResetPasswordFail,
      );
    }
  }
}