import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posrestaurant/cubit/theme/theme_cubit.dart';

import '../../cubit/home/obscure_text/obscure_text.dart';
import '../../shared/widgets/text_fields/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Size size;
  late ThemeData theme;

  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isDarkmode = false;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    theme = Theme.of(context);
    return Scaffold(
      appBar: null,
      body: _body(),
    );
  }

  Widget _body(){
    return Row(
      children: [
        leftSide(),
        rightSide(),
      ],
    );
  }

  Widget leftSide() {
    return Container(
      width: size.width *.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [

              Colors.blueGrey,
              Colors.blueGrey,
              Colors.black..withValues(
                alpha: 15
              ),

            ]
        )
      ) ,
      child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: size.height*2,
            width: size.width*.2,
          )),
    );
  }
    Widget rightSide(){
      return Container(
        width:size.width*.5,
        color: theme.colorScheme.onPrimary,
        child: textFields(),
      );
    }

    Widget textFields(){
    return Form(
        key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text('Iniciar Sesion', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          const SizedBox(height: 50,),
          SizedBox(
            width: size.width*.3,
            child: CustomLoginTextField(
              controller: _emailController,
              hintText: 'Correo o Usuario',
              obscureText: false,
              validator: (value){
                value = 'desarrollo';
                if(value!='desarrollo'||value.isEmpty){
                  return 'Ingrese un usuario valido';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            width: size.width*.3,
            child: BlocProvider(
                create: (_)=>TextVisibiltyCubit(),
              child: BlocBuilder<TextVisibiltyCubit, bool>(
                  builder:(context, obscureText){
                    return CustomLoginTextField(
                      suffixIcon:IconButton(
                          onPressed: ()=> context.read<TextVisibiltyCubit>().changeVisibility(),
                          icon: Icon(obscureText? Icons.visibility_off:Icons.visibility)),
                      controller: _passWordController,
                      hintText: 'Contraseña',
                      obscureText: obscureText,
                      validator: (value){
                        value = 'desarrollo';
                        if(value!='desarrollo'||value.isEmpty){
                          return 'Ingrese una contraseña valida';
                        }
                        return null;
                      },
                    );
                  }
              ),
            )
            ,
          ),
          const SizedBox(height: 2,),
          Text("Forgot Password?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),),
          const SizedBox(height: 10,),
          _login(),
        const Spacer(),
        IconButton(
            onPressed:() => context.read<ThemeCubit>().toggleTheme(isDarkmode = !isDarkmode),
            icon: Icon(isDarkmode? Icons.dark_mode_outlined:Icons.light_mode_outlined, size: 30,)
        ),
      ]),
    );
    }

 Widget _login(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: (){
        if (_formKey.currentState!.validate()) {
          if (_emailController.text == 'desarrollo' &&
              _passWordController.text == 'desarrollo') {
            print('aveis loggeao');
            context.go('/HomeScreen');
          } else {
            print('no aveis loggeao');
          }
        }
      },
      child: Text('Iniciar Sesion',
        style: TextStyle(

            fontWeight: FontWeight.bold, color: theme.colorScheme.onPrimary
        ),),
    );
 }
  }

