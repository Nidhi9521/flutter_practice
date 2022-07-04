import 'package:sqflite/sqflite.dart';
import 'package:sqlite_demo/model/student_model.dart';
class SQLHelper{

  Future openDb() async{
    Database _database;
    _database=await openDatabase("studentdemo.db",
      version: 1,onCreate: (Database db,int version) async{
        await db.execute("CREATE TABLE student(id INTEGER PRIMARY KEY autoincrement,name TEXT,grade TEXT)");
        }
    );
    return _database;
  }

  Future insertData(Student s)async{
    Database _database;
    _database=await openDb();
    return await _database.insert('student', s.toJson());
  }

  Future<List<Student>> getModelList() async{
    Database _database;
    _database=await openDb();
    final List<Map<String,dynamic>> maps=await _database.query('student');
    return List.generate(maps.length, (index){
      return Student(
          id: maps[index]['id'],
        name: maps[index]['name'],
        grade: maps[index]['grade']);
    });
  }

  Future<int> update(Student s,id)async{
    Database _database;
    _database=await openDb();
    return await _database.update('student', s.toJson(),where: "id=?",whereArgs: [id]);
  }

  Future<void> delete(int id) async{
    print(id.toString());
    Database _database;
    _database=await openDb();
    await _database.delete('student',where: "id=?",whereArgs: [id]);
  }

}