import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeSetting extends Cubit<String> {
  ChangeSetting() : super('General');
  void changePage(String newPage) {
    print('Cambiando a: $newPage'); // Verificar si se está llamando correctamente
    emit(newPage);
  }
}