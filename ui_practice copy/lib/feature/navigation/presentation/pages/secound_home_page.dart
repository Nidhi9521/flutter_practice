import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_practice/feature/navigation/presentation/cubit/data_cubit.dart';
import 'package:ui_practice/feature/navigation/presentation/cubit/data_state.dart';
import 'package:ui_practice/feature/navigation/presentation/pages/screen_a.dart';
import 'package:ui_practice/feature/navigation/presentation/pages/screen_b.dart';
import 'package:ui_practice/feature/navigation/presentation/pages/screen_c.dart';
import 'package:ui_practice/feature/navigation/presentation/pages/screen_d.dart';

class SecHomePage extends StatelessWidget {
  const SecHomePage({Key? key}) : super(key: key);

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
        body: BlocBuilder<DataCubit, DataState>(
          builder: (context, state) {
            return _routeBuilders( (state is DataChangSuccess ? state.val : 0));
          },
        ),
        bottomNavigationBar: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
              //color: const Color(0xFF66BB6A),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<DataCubit, DataState>(
              builder: (context, state) {
                print(state);
                print(state is DataChangSuccess ? state.val : 'ghvh');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        context.read<DataCubit>().dataChang(0);
                      },
                      child: Icon(Icons.home,
                          color: (state is DataChangSuccess
                                  ? (state.val == 0 ? true : false)
                                  : false)
                              ? Colors.blue
                              : Colors.black
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        context.read<DataCubit>().dataChang(1);
                      },
                      child: Icon(Icons.add,
                          color: (state is DataChangSuccess
                                  ? (state.val == 1 ? true : false)
                                  : false)
                              ? Colors.blue
                              : Colors.black),
                    ),
                    GestureDetector(
                      onTap: (){
                        context.read<DataCubit>().dataChang(2);
                      },
                      child: Icon(Icons.account_balance,
                          color: (state is DataChangSuccess
                                  ? (state.val == 2 ? true : false)
                                  : false)
                              ? Colors.blue
                              : Colors.black),
                    ),
                    GestureDetector(
                      onTap: (){
                        context.read<DataCubit>().dataChang(3);
                      },
                      child: Icon(Icons.person,
                          color: (state is DataChangSuccess
                                  ? (state.val == 3 ? true : false)
                                  : false)
                              ? Colors.blue
                              : Colors.black

                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
