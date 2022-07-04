
abstract class DataState {}

class DataInitial extends DataState {}

class DataChangedSuccess extends DataState{
  var value;
  DataChangedSuccess(this.value);
}
class DataChangSuccess extends DataState{
  var val;
  DataChangSuccess(this.val);
}