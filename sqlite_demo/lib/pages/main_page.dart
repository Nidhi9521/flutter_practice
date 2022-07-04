import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_demo/cubit/db_cubit.dart';
import 'package:sqlite_demo/model/sql_helper.dart';
import 'package:sqlite_demo/model/student_model.dart';
import 'package:sqlite_demo/widget/text_field_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  Widget _dialog(context, Student? s) {
    TextEditingController _name = TextEditingController();
    TextEditingController _grade = TextEditingController();
    var flag = false;
    if (s == null) {
      flag = true;
    } else {
      flag = false;
      _name.text = s.name;
      _grade.text = s.grade;
    }
    return AlertDialog(
      title: Text("Insert Data"),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
          child: Column(
            children: [
              TextField(
                controller: _name,
                decoration: InputDecoration(
                    labelText: 'Enter Name', hintText: 'Enter Name'),
              ),
              TextField(
                controller: _grade,
                decoration: InputDecoration(
                    labelText: 'Enter grade', hintText: 'Enter grade'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Student s = Student(name: _name.text, grade: _grade.text);
                        // sqlHelper.insertData(s);
                        context.read<DbCubit>().insertData(s);
                        Navigator.pop(context);
                        _name.clear();
                        _grade.clear();
                      },
                      child: Text('Insert')),
                  BlocBuilder<DbCubit, DbState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            if (flag == true) {
                              Student s =
                                  Student(name: _name.text, grade: _grade.text);
                              // sqlHelper.insertData(s);
                              context.read<DbCubit>().insertData(s);
                            }
                            if (flag == false) {
                              print('update');
                              Student s =
                                  Student(name: _name.text, grade: _grade.text);
                              // context.read<DbCubit>().update(s);
                              context.read<DbCubit>().update(s, s.id);
                            }
                            Navigator.pop(context);
                            _name.clear();
                            _grade.clear();
                          },
                          child: Text('Insert'));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SQLHelper sqlHelper = SQLHelper();
    TextEditingController _name = TextEditingController();
    TextEditingController _grade = TextEditingController();

    List<Student> modelList;
    return Scaffold(
        appBar: AppBar(
          title: Text('SQLite Demo'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BlocProvider(
                    create: (context) => DbCubit(),
                    child: _dialog(context, null),
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: BlocBuilder<DbCubit, DbState>(
          builder: (context, state) {
            print(state);
            if (state is DBInsertSuccess<String> || state is DbInitial) {


                // FutureBuilder<List<Student>>(
                //   future: context.read<DbCubit>().getModelList(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       modelList = snapshot.data as List<Student>;
                //       print(modelList[0].name);
                //       return
                        if(state is DBGetSuccess) {
                          return ListView.builder(
                              itemCount: state is DBGetSuccess ? state.modelList
                                  .length : 0,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(45),
                                            topRight: Radius.circular(45),
                                            bottomRight: Radius.circular(45),
                                            bottomLeft: Radius.circular(45))),
                                    title: Text(state.modelList[index].name),
                                    subtitle: Text(
                                        state.modelList[index].grade),
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          Container(
                                            child: IconButton(
                                                onPressed: () {
                                                  _name.text =
                                                      state.modelList[index]
                                                          .name;
                                                  _grade.text =
                                                      state.modelList[index]
                                                          .grade;
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (
                                                          BuildContext context) {
                                                        return BlocProvider(
                                                          create: (context) =>
                                                              DbCubit(),
                                                          child: _dialog(
                                                              context,
                                                              state
                                                                  .modelList[index]),
                                                        );
                                                      });

                                                  // showModalBottomSheet(
                                                  //     context: context,
                                                  //     isScrollControlled: true,
                                                  //     builder: (context2) {
                                                  //       return Padding(
                                                  //         padding: EdgeInsets.only(
                                                  //             top: 20,
                                                  //             right: 20,
                                                  //             left: 20,
                                                  //             bottom: MediaQuery.of(
                                                  //                     context2)
                                                  //                 .viewInsets
                                                  //                 .bottom),
                                                  //         child: Column(
                                                  //           mainAxisSize:
                                                  //               MainAxisSize.min,
                                                  //           // mainAxisAlignment:
                                                  //           //     MainAxisAlignment
                                                  //           //         .end,
                                                  //           // crossAxisAlignment:
                                                  //           //     CrossAxisAlignment
                                                  //           //         .end,
                                                  //           children: [
                                                  //             TextFieldWid(_name, 'Enter Name'),
                                                  //             TextFieldWid(_grade, 'Enter Grade'),
                                                  //             BlocProvider.value(
                                                  //               value: BlocProvider
                                                  //                   .of<DbCubit>(
                                                  //                       context),
                                                  //               child: BlocBuilder<
                                                  //                   DbCubit,
                                                  //                   DbState>(
                                                  //                 builder: (context,
                                                  //                     state) {
                                                  //                   return ElevatedButton(
                                                  //                       onPressed:
                                                  //                           () {
                                                  //                         Student s = Student(
                                                  //                             name: _name
                                                  //                                 .text,
                                                  //                             grade:
                                                  //                                 _grade.text);
                                                  //                         // sqlHelper.update(
                                                  //                         //     s, modelList[index].id);
                                                  //                         context
                                                  //                             .read<
                                                  //                                 DbCubit>()
                                                  //                             .update(
                                                  //                                 s,
                                                  //                                 modelList[index].id);
                                                  //                         Navigator.pop(
                                                  //                             context);
                                                  //                         _name
                                                  //                             .clear();
                                                  //                         _grade
                                                  //                             .clear();
                                                  //                       },
                                                  //                       child: Text(
                                                  //                           'click'));
                                                  //                 },
                                                  //               ),
                                                  //             ),
                                                  //             SizedBox(
                                                  //               height:
                                                  //                   MediaQuery.of(
                                                  //                           context)
                                                  //                       .viewInsets
                                                  //                       .bottom,
                                                  //             )
                                                  //           ],
                                                  //         ),
                                                  //       );
                                                  //     });
                                                },
                                                icon: Icon(Icons.edit)),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                context
                                                    .read<DbCubit>()
                                                    .delete(
                                                    state.modelList[index].id);
                                                // sqlHelper.delete(modelList[index].id);
                                              },
                                              icon: Icon(Icons.delete))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }else{
                          return CircularProgressIndicator();
                        }
                    }

                    return Center(child: CircularProgressIndicator());
          //         });
          //   } else if (state is DBInsertFail) {
          //     print('Fail');
          //     var snackBar = SnackBar(content: Text('Fai'));
          //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //     return SizedBox();
          //   } else {
          //     return CircularProgressIndicator();
          //   }
          },
        ));
  }
}
