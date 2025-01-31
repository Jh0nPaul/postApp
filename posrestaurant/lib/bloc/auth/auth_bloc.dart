

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posrestaurant/data/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState> {
  final AuthRepositoy authRepositoy;

  AuthBloc( this.authRepositoy ) : super(AuthInitial()){

    on<LoginEvent>((event, emit) async {
      emit( AuthLoading() );
      final success = await authRepositoy.login(event.userName, event.password);
      if( success ){
        emit(AuthAuthenticated());
      } else {
        emit( AuthError("Credenciales Incorrectas") );
      }
    });

    // on<RegisterEvent>((event, emit)async{
    //   emit( AuthLoading() );
    //   final success = await authRepositoy.register(event.userName,event.password, event.);
    // });
on<LogoutEvent>((event, emit) async {
      emit(AuthInitial());
});

  }






}