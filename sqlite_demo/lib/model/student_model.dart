class Student{
  var id;
  var name;
  var grade;
  Student({this.id,this.name,this.grade});

  Student fromJson(json){
    return Student(id: json['id'], name: json['name'],grade: json['grade']);
  }

  Map<String,dynamic> toJson(){
  return {'name':name,'grade':grade};
  }
}