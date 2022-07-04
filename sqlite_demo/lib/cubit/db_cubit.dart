import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sqlite_demo/model/student_model.dart';
import 'package:sqflite/sqflite.dart';
part 'db_state.dart';

class DbCubit extends Cubit<DbState> {
  DbCubit() : super(DbInitial());

  Future openDb() async{
    Database _database;
    _database=await openDatabase("studentdemo.db",
        version: 1,onCreate: (Database db,int version) async{
          await db.execute("CREATE TABLE student(id INTEGER PRIMARY KEY autoincrement,name TEXT,grade TEXT)");
        }
    );
    return _database;
  }

  void insertData(Student s)async{
    try {
      Database _database;
      _database = await openDb();
      await _database.insert('student', s.toJson());
      emit(DBInsertSuccess(DbDemo(name:'hello')));
    }catch(e){
      emit(DBInsertFail());
    }
  }

  void getModelList() async{
    Database _database;
    _database=await openDb();
    final List<Map<String,dynamic>> maps=await _database.query('student');
    emit(DBGetSuccess( List.generate(maps.length, (index){
      return Student(
          id: maps[index]['id'],
          name: maps[index]['name'],
          grade: maps[index]['grade']);
    })));
    // return List.generate(maps.length, (index){
    //   return Student(
    //       id: maps[index]['id'],
    //       name: maps[index]['name'],
    //       grade: maps[index]['grade']);
    // });

  }

  void update(Student s,id)async{
    try {
      Database _database;
      _database = await openDb();
      await _database.update(
          'student', s.toJson(), where: "id=?", whereArgs: [id]);
      emit(DBInsertSuccess<String>('Hello'));
    }catch (e){
      emit(DBInsertFail());
    }
  }

  void delete(int id) async{
    try {
      print(id.toString());
      Database _database;
      _database = await openDb();
      await _database.delete('student', where: "id=?", whereArgs: [id]);
      DbDemo d=new DbDemo(name:'hello');
      emit(DBInsertSuccess<String>(d.name.toString()));
    }catch(e){
      emit(DBInsertFail());
    }
  }

}

class DbDemo{

  String? name;
  int? num;
  bool? flag;
  DbDemo({this.name,this.num,this.flag});

}