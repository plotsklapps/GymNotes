/*REGISTER EXCEPTIONS*/
class WeakPasswordException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

class OperationNotAllowedException implements Exception {}

class InvalidEmailException implements Exception {}

/*LOGIN EXCEPTIONS*/
class UserDisabledException implements Exception {}

class WrongPasswordException implements Exception {}

class UserNotFoundException implements Exception {}

/*GENERIC EXCEPTIONS*/

class GenericException implements Exception {}

class UserNotLoggedInException implements Exception {}