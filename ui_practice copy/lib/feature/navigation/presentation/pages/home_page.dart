import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_practice/feature/navigation/presentation/cubit/data_cubit.dart';
import 'package:ui_practice/feature/navigation/presentation/cubit/data_state.dart';
import 'package:ui_practice/feature/navigation/presentation/pages/screen_a.dart';
import 'package:ui_practice/feature/navigation/presentation/pages/screen_b.dart';
import 'package:ui_practice/feature/navigation/presentation/pages/screen_c.dart';
import 'package:ui_practice/feature/navigation/presentation/pages/screen_d.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Widget _routeBuilders(int index) {

          List A= [
            ScreenA(),
            ScreenB(),
            ScreenC(),
            ScreenD()];
          return A[index];

    }
    return Scaffold(
      appBar: AppBar(
        title: Text('UI'),
      ),
      body: BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          return _routeBuilders( (state is DataChangedSuccess ? state.value : 0));
        },
      ),

      bottomNavigationBar: BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
                backgroundColor: Colors.purple,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: Colors.pink,
              ),
            ],
            currentIndex: state is DataChangedSuccess ? state.value : 0,
            selectedItemColor: Colors.black26,
            onTap: (a) {
              context.read<DataCubit>().dataChanged(a);
              print(a);
            },
          );
        },
      ),
    );
  }
}



