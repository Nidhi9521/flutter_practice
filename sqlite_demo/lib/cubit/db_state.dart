part of 'db_cubit.dart';

abstract class DbState {
  const DbState();
}

class DbInitial extends DbState {}

class DBInsertSuccess<T> extends DbState{
  T response;
  DBInsertSuccess(this.response);
}

class DBInsertFail extends DbState{}

class DBUpdateSuccess extends DbState{}

class DBUpdateFail extends DbState{}

class DBDeleteSuccess extends DbState{}

class DBDeleteFail extends DbState{}

class DBModelSuccess extends DbState{
  List<Student> modelList;
  DBModelSuccess(this.modelList);
}
class DBGetSuccess extends DbState{
  List<Student> modelList;
  DBGetSuccess(this.modelList);
}
