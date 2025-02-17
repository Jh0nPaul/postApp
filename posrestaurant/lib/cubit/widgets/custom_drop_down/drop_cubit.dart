
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part   'dropdown_state.dart';

class DropDownCubit extends Cubit<DropDownState>{
  DropDownCubit(): super(DropownInitial());

  void selectItem(String selectedItem){
    emit(DropownSelected(selectedItem));
  }
}