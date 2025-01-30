import 'package:flutter_bloc/flutter_bloc.dart';

class TextVisibiltyCubit extends Cubit<bool> {
  TextVisibiltyCubit() : super(true);

  void changeVisibility() => emit(!state);
}