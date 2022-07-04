

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_practice/feature/navigation/presentation/cubit/data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());


  void dataChanged(int value){
    emit(DataChangedSuccess(value));
  }

  void dataChang(int value){
    emit(DataChangSuccess(value));
  }
}
