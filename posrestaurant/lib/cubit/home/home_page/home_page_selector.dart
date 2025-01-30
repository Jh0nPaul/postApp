import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePageSelector extends Cubit<String>{
  ChangePageSelector(): super('Home');
  @override
  void changePage( String page ) => emit(page);

}