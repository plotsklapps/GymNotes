import 'package:gymnotes/all_imports.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final User? currentUser = FirebaseAuth.instance.currentUser;
final currentUserDisplayName = currentUser?.displayName;
final currentUserEmail = currentUser?.email;
final currentUserPhotoURL = currentUser?.photoURL;
final currentUserUid = currentUser?.uid;
