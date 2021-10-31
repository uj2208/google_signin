import 'package:alert/alert.dart';
import 'package:google_signin/models/movie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:google_signin/models/user.dart';

 class DbHandler{

   Future<Database> initializeDB() async {
     String path = await getDatabasesPath();
     return openDatabase(
       join(path, 'movie.db'),
       onCreate: (database, version) async {
         await database.execute(
           "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,age INTEGER NOT NULL, country TEXT NOT NULL, email TEXT)",
         );
         await database.execute(
           "CREATE TABLE movieDet(id INTEGER PRIMARY KEY AUTOINCREMENT, cred_val TEXT NOT NULL ,name TEXT NOT NULL, director TEXT NOT NULL, poster TEXT)",
         );
       },
       version: 1,
     );
   }


   Future<int> insertUser(List<Userx> users) async {
     int result = 0;
     final Database db = await initializeDB();
     for(var user in users){
       result = await db.insert('users', user.toMap());
     }
     return result;
   }

   Future<List<Userx>> retrieveUsers() async {
     final Database db = await initializeDB();
     final List<Map<String, Object?>> queryResult = await db.query('users');
     return queryResult.map((e) => Userx.fromMap(e)).toList();
   }

   Future<void> deleteUser(int id) async {
     final db = await initializeDB();
     await db.delete(
       'users',
       where: "id = ?",
       whereArgs: [id],
     );
   }



   Future<int> inserMovie(List<Movie> movieS) async {
     int result = 0;
     final Database db = await initializeDB();
     for(var movie in movieS){
       result = await db.insert('movieDet', movie.toMap());
     }
     return result;
   }

   Future<List<Movie>> retrieveMovie_det(String cred_val) async {
     final Database db = await initializeDB();
     //print('cred_val'+cred_val);
     final List<Map<String, Object?>> queryresCredVal = await db.rawQuery('SELECT * FROM movieDet WHERE cred_val=?', [cred_val]);
     return queryresCredVal.map((e) => Movie.fromMap(e)).toList();
   }

   Future<void> deleteMovie(int id) async {
     final db = await initializeDB();
     await db.delete(
       'movieDet',
       where: "id = ?",
       whereArgs: [id],
     );
   }

   Future<void>Updaate_movie_det(String name,String director , int? id)async{
     //print(name);
     //print(id);
     final Database db = await initializeDB();
     int count= await db.rawUpdate(
         'UPDATE movieDet SET name = ?,director = ?  WHERE id = ?',
         [name, director,id]);
     print('updated: $count');
     Alert(message: "Records Updated").show();
   }
 }