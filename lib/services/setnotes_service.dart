import 'dart:async';
import 'package:gymnotes/all_imports.dart';
import 'package:path_provider/path_provider.dart';

const dbName = 'setnotes.db';
const setNotesTable = 'setnote';
const userTable = 'user';
const idColumn = 'id';
const emailColumn = 'email';
const userIdColumn = 'user_id';
const musclegroupColumn = 'musclegroup';
const exerciseColumn = 'exercise';
const positionColumn = 'position';
const weaponColumn = 'weapon';
const weightColumn = 'weight';
const repsColumn = 'reps';
const isSyncedColumn = 'is_synced';
const createUserTable = '''
        CREATE TABLE IF NOT EXISTS "user" (
	        "id"	INTEGER NOT NULL,
	        "email"	TEXT NOT NULL UNIQUE,
	       PRIMARY KEY("id" AUTOINCREMENT));''';
const createSetNoteTable = '''
        CREATE TABLE IF NOT EXISTS "setnote" (
          "id"	INTEGER NOT NULL,
          "user_id"	INTEGER NOT NULL,
          "musclegroup"	BLOB,
          "exercise"	REAL,
          "position"	TEXT,
          "weapon"	TEXT,
          "weight"	INTEGER,
          "reps"	INTEGER,
          "is_synced"	INTEGER NOT NULL DEFAULT 0,
         FOREIGN KEY("user_id") REFERENCES "user"("id"),
         PRIMARY KEY("id" AUTOINCREMENT));''';

class SetNotesService {
  Database? _db;

  List<DatabaseSetNote> _setNotes = [];

  static final SetNotesService _shared = SetNotesService._sharedInstance();
  SetNotesService._sharedInstance();
  factory SetNotesService() => _shared;

  final _setNotesStreamController =
      StreamController<List<DatabaseSetNote>>.broadcast();

  Stream<List<DatabaseSetNote>> get allSetNotes =>
      _setNotesStreamController.stream;

  Future<void> _cacheSetNotes() async {
    final allSetNotes = await getAllSetNotes();
    _setNotes = allSetNotes.toList();
    _setNotesStreamController.add(_setNotes);
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      return db;
    }
  }

  Future<void> openDatabaseSetNotes() async {
    /*CHECK IF DATABASE IS ALREADY OPEN*/
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      /*GET DIRECTORY ON DEVICE*/
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;

      /*CREATE USERTABLE IF NOT EXISTS*/
      await db.execute(createUserTable);

      /*CREATE SETNOTETABLE IF NOT EXISTS*/
      await db.execute(createSetNoteTable);

      /*CALL FUNCTION _CACHESETNOTES() TO FILL LIST + STREAMCONTROLLER*/
      await _cacheSetNotes();
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectoryException();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> ensureDatabaseIsOpen() async {
    try {
      await openDatabaseSetNotes();
    } on DatabaseAlreadyOpenException {
      if (kDebugMode) {
        print('Database is already open');
      }
    }
  }

  Future<void> closeDatabaseSetNotes() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      await db.close();
      _db = null;
    }
  }

  Future<DatabaseUser> getOrCreateDatabaseUser({required String email}) async {
    try {
      final user = await getDatabaseUser(email: email);
      return user;
    } on UserNotFoundException {
      final createdUser = await createDatabaseUser(email: email);
      return createdUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<DatabaseUser> getDatabaseUser({required String email}) async {
    await ensureDatabaseIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isEmpty) {
      throw DatabaseUserDoesNotExistException();
    } else {
      return DatabaseUser.fromRow(results.first);
    }
  }

  Future<DatabaseUser> createDatabaseUser({required String email}) async {
    await ensureDatabaseIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isNotEmpty) {
      throw DatabaseUserAlreadyExistsException();
    }
    final userId = await db.insert(
      userTable,
      {emailColumn: email.toLowerCase()},
    );
    return DatabaseUser(
      id: userId,
      email: email,
    );
  }

  Future<void> deleteDatabaseUser({required String email}) async {
    await ensureDatabaseIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (deletedCount != 1) {
      throw CouldNotDeleteUserException();
    }
  }

  Future<DatabaseSetNote> createSetNote({required DatabaseUser owner}) async {
    await ensureDatabaseIsOpen();
    final db = _getDatabaseOrThrow();
    final dbUser = await getDatabaseUser(email: owner.email);
    if (dbUser != owner) {
      throw DatabaseUserDoesNotExistException();
    }
    const muscleGroupText = '';
    const exerciseText = '';
    const positionText = '';
    const weaponText = '';
    const weightAmount = 0;
    const repsAmount = 0;

    /*CREATE SETNOTEID TO USE AFTER*/
    final setNoteId = await db.insert(setNotesTable, {
      userIdColumn: owner.id,
      musclegroupColumn: muscleGroupText,
      exerciseColumn: exerciseText,
      positionColumn: positionText,
      weaponColumn: weaponText,
      weightColumn: weightAmount,
      repsColumn: repsAmount,
      isSyncedColumn: 1,
    });
    /*CREATE SETNOTE WITH SETNOTEID*/
    final setNote = DatabaseSetNote(
      id: setNoteId,
      userId: owner.id,
      musclegroup: muscleGroupText,
      exercise: exerciseText,
      position: positionText,
      weapon: weaponText,
      weight: weightAmount,
      reps: repsAmount,
      isSynced: true,
    );

    _setNotes.add(setNote);
    _setNotesStreamController.add(_setNotes);

    return setNote;
  }

  Future<Iterable<DatabaseSetNote>> getAllSetNotes() async {
    await ensureDatabaseIsOpen();
    final db = _getDatabaseOrThrow();
    final notes = await db.query(setNotesTable);

    return notes.map((noteRow) => DatabaseSetNote.fromRow(noteRow));
  }

  Future<DatabaseSetNote> getSetNote({required int id}) async {
    await ensureDatabaseIsOpen();
    final db = _getDatabaseOrThrow();
    final notes = await db.query(
      setNotesTable,
      limit: 1,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (notes.isEmpty) {
      throw DatabaseSetNoteDoesNotExistException();
    } else {
      final setNote = DatabaseSetNote.fromRow(notes.first);
      _setNotes.removeWhere((setNote) => setNote.id == id);
      _setNotes.add(setNote);
      _setNotesStreamController.add(_setNotes);
      return setNote;
    }
  }

  Future<DatabaseSetNote> updateSetNote({
    required DatabaseSetNote setNote,
    required String text,
  }) async {
    await ensureDatabaseIsOpen();
    final db = _getDatabaseOrThrow();
    /*MAKE SURE SETNOTE ACTUALLY EXISTS*/
    await getSetNote(id: setNote.id);
    /*UPDATE DATABASE (DB)*/
    final updatesCount = await db.update(
      setNotesTable,
      {
        musclegroupColumn: text,
        exerciseColumn: text,
        positionColumn: text,
        weaponColumn: text,
        weightColumn: text,
        repsColumn: text,
        isSyncedColumn: 1,
      },
      where: 'id = ?',
      whereArgs: [setNote.id],
    );
    if (updatesCount == 0) {
      throw CouldNotUpdateSetNoteException();
    } else {
      final updatedSetNote = await getSetNote(id: setNote.id);
      _setNotes.removeWhere((setNote) => setNote.id == updatedSetNote.id);
      _setNotes.add(updatedSetNote);
      _setNotesStreamController.add(_setNotes);
      return updatedSetNote;
    }
  }

  Future<void> deleteSetNote({required int id}) async {
    await ensureDatabaseIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      setNotesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (deletedCount == 0) {
      throw CouldNotDeleteSetNoteException();
    } else {
      _setNotes.removeWhere((setNote) => setNote.id == id);
      _setNotesStreamController.add(_setNotes);
    }
  }

  Future<int> deleteAllSetNotes() async {
    await ensureDatabaseIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      setNotesTable,
    );
    _setNotes = [];
    _setNotesStreamController.add(_setNotes);
    return deletedCount;
  }
}

@immutable
class DatabaseUser {
  final int id;
  final String email;
  const DatabaseUser({
    required this.id,
    required this.email,
  });

  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        email = map[emailColumn] as String;

  @override
  String toString() {
    return 'Person, ID = $id, email = $email';
  }

  /*CHECK IF USER IS ACTUAL OWNER OF DATABASE*/
  @override
  bool operator ==(covariant DatabaseUser other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

@immutable
class DatabaseSetNote {
  final int id;
  final int userId;
  final String musclegroup;
  final String exercise;
  final String position;
  final String weapon;
  final int weight;
  final int reps;
  final bool isSynced;

  /*CONSTRUCTOR FOR AN ACTUAL SETNOTE INSTANCE */
  const DatabaseSetNote({
    required this.id,
    required this.userId,
    required this.musclegroup,
    required this.exercise,
    required this.position,
    required this.weapon,
    required this.weight,
    required this.reps,
    required this.isSynced,
  });

  DatabaseSetNote.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        userId = map[userIdColumn] as int,
        musclegroup = map[musclegroupColumn] as String,
        exercise = map[exerciseColumn] as String,
        position = map[positionColumn] as String,
        weapon = map[weaponColumn] as String,
        weight = map[weightColumn] as int,
        reps = map[repsColumn] as int,
        isSynced = (map[isSyncedColumn] as int) == 1 ? true : false;

  @override
  String toString() {
    return 'SetNotes, ID = $id, userId = $userId, musclegroup = $musclegroup, exercise = $exercise, position = $position, weapon = $weapon, weight = $weight, reps = $reps, isSynced = $isSynced,';
  }

  @override
  bool operator ==(covariant DatabaseSetNote other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}