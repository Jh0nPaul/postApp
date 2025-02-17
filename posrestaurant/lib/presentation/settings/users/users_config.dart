import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posrestaurant/core/handlers/sqlite_handler.dart';
import 'package:posrestaurant/cubit/settings/users/users_cubit.dart';
import 'package:posrestaurant/presentation/settings/users/user_registration.dart';

import '../../../shared/widgets/text_fields/data_text_field.dart';

class UsersConfig extends StatefulWidget {
  const UsersConfig({super.key});

  @override
  State<UsersConfig> createState() => _UsersConfigState();
}

class _UsersConfigState extends State<UsersConfig> {
  late ThemeData theme;
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    theme = Theme.of(context);
    return _body();
  }

  Widget _body(){
    return Container(
      padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _toolBar(),
          const SizedBox(height: 10),
          _userTable(),
        ],
      ),
    );
  }

  Widget _toolBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
                width: size.width*.3,
                height: size.height*.06,
                child: SearchBar(
                  leading: Icon(Icons.search,color: theme.colorScheme.onPrimary,),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(theme.colorScheme.onPrimaryContainer),
                  hintText: 'Buscar usuario',
                  hintStyle: WidgetStateProperty.all(TextStyle(color: theme.colorScheme.onPrimary)),
                  controller: TextEditingController(),
                  shadowColor: WidgetStateProperty.all(Colors.transparent),
                )),
            const SizedBox(width: 10),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              height: size.height*.07,
              highlightColor: Colors.transparent,
              mouseCursor: WidgetStateMouseCursor.clickable,
              color: theme.colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 3),
                  Text('Añadir usuario'),
                  const SizedBox(width: 10),
                  Icon(Icons.supervised_user_circle, size: 30,),
                ],
              ),
              onPressed: ()async {
                await showDialog(
                    context: context,
                    builder: (context){
                      return  UserRegistration();
                    }
                );
              },
                )
          ],
        ),
      ],
    );
  }

  Widget _userTable(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _tableHeader(),
        Container(
          height: size.height-330,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(8)
            ),
            border: Border.all(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          child: BlocProvider(
            create: (_)=> UserCubit(DBHelper())..fetchUsers(),
            child: BlocBuilder<UserCubit, List<Map<String,dynamic>>>(
              builder: (context, users){
                if( users.isEmpty ){
                  return Center(
                    child: Text('No hay usuarios registrados'),
                  );
                }
                return FadingEdgeScrollView.fromScrollView(
                    child: ListView.builder(
                        controller: ScrollController(),
                        itemCount:users.length,
                        itemBuilder: (context, index){
                          final user = users[index];
                          return  Container(
                            decoration: BoxDecoration(
                              color: index.isEven
                                  ? theme.colorScheme.onSurface
                                  : theme.colorScheme.onPrimaryContainer,
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.colorScheme.onPrimary,
                                  width: .25,
                                ),
                              ),
                            ),
                            height: size.height*.036,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _headerItem(title:user['name'],fontSize: 13),
                                _headerItem(title:user['email'],fontSize: 13),
                                _headerItem(title:user['username'],fontSize: 13),
                                _headerItem(title:user['role'],fontSize: 13),
                                _headerItem(title:user['status'],fontSize: 13),
                              ],
                            ),
                          );
                        }
                    )
                );
              }

            ),
          ),
        ),
      ],
    );
  }

Widget _tableHeader() {
  return Container(
    height: size.height * .06,
    decoration: BoxDecoration(
      color: theme.colorScheme.onPrimaryContainer,
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _headerItem(title:'Nombre',),
        _headerItem(title:'Email'),
        _headerItem(title:'Usuario'),
        _headerItem(title:'Rol'),
        _headerItem(title:'Estado'),
      ],
    ),
  );
}

Widget _headerItem({String title = 'Enter Text', double fontSize = 16 }) {
  return SizedBox(
    width: size.width*.1,
    child: Center(
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    ),
  );
}

  Widget _dialogButton(){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      height: size.height*.07,
      highlightColor: Colors.transparent,
      mouseCursor: WidgetStateMouseCursor.clickable,
      color: theme.colorScheme.onPrimaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 3),
          Text('Añadir usuario'),
          const SizedBox(width: 10),
          Icon(Icons.supervised_user_circle, size: 30,),
        ],
      ),
      onPressed: ()async {
        await showDialog(
            context: context,
            builder: (context){
              return  UserRegistration();
            }
        );
      },
    );
}

  Widget _dialog(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _firstColumn(),
        _secondcolumn(),
        _thirdColumn(),
      ],
    );
  }

  Widget _firstColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [const SizedBox(height: 15,),
        InfoTextField(
          label: 'Nombre',
          hint: 'Nombre del usuario',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: false,
        ),
        InfoTextField(
          label: 'Usuario',
          hint: 'Nombre de usuario',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: false,
        ),
        InfoTextField(
          label: 'Contraseña',
          hint: 'Contraseña del usuario',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: true,
        ),
        InfoTextField(
          label: 'Confirmar contraseña',
          hint: 'Confirmar contraseña',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: true,
        ),
      ],
    );
  }


  Widget _secondcolumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 15),
        InfoTextField(
          label: 'Confirmar contraseña',
          hint: 'Confirmar contraseña',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: true,
        ),
        InfoTextField(
          label: 'Rol',
          hint: 'Rol del usuario',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: false,
        ),
        InfoTextField(
          label: 'Estado',
          hint: 'Estado del usuario',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: false,
        ),
        InfoTextField(
          label: 'Fecha de creación',
          hint: 'Fecha de creación del usuario',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: false,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _thirdColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 15,),
        InfoTextField(
          label: 'Pin de usuario',
          hint: 'Pin de usuario',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: false,
        ),
        const SizedBox(height: 15),
        const SizedBox(height: 15),
        const SizedBox(height: 80),
      ],
    );
  }

}
