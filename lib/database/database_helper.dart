// import 'dart:developer';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../model/lyric_model.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//
//   DatabaseHelper._internal();
//
//   static Database? _database;
//
//   Future<Database> get database async {
//     _database ??= await _initDatabase();
//     return _database!;
//   }
//
//   // Initialize the database and create the table if it doesn't exist
//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'assets/db/lyrics_database.sql');
//     return await openDatabase(
//       path,
//       version: 2, // Incremented version to trigger migration
//       onCreate: (db, version) async {
//         await db.execute('''CREATE TABLE lyrics(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             title TEXT,
//             fullLyric TEXT
//           )''');
//       },
//       onUpgrade: (db, oldVersion, newVersion) async {
//         if (oldVersion < 2) {
//           // Handle database upgrade logic here
//         }
//       },
//     );
//   }
//
//   // Add a lyric to the database
//   Future<void> insertLyric(Lyric lyric) async {
//     final db = await database;
//     log("Adding Lyric: ${lyric.toMap()}");
//     await db.insert(
//       'lyrics',
//       lyric.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace, // Replaces if the lyric already exists
//     );
//   }
//
//   // Update an existing lyric in the database
//   Future<void> updateLyric(Lyric lyric) async {
//     final db = await database;
//     log("Updating Lyric: ${lyric.toMap()}");
//     await db.update(
//       'lyrics',
//       lyric.toMap(),
//       where: 'id = ?',
//       whereArgs: [lyric.id], // Uses the id to update the correct record
//     );
//   }
//
//   // Delete a lyric by its ID
//   Future<void> deleteLyric(int id) async {
//     final db = await database;
//     log("Deleting Lyric with ID: $id");
//     await db.delete(
//       'lyrics',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   // Delete all lyrics from the database
//   Future<void> deleteAllLyrics() async {
//     final db = await database;
//     log("Deleting all lyrics");
//     await db.delete('lyrics');
//   }
//
//   // Get all lyrics from the database
//   Future<List<Lyric>> getLyrics() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('lyrics');
//     return List.generate(maps.length, (i) {
//       return Lyric.fromMap(maps[i]);
//     });
//   }
// }
