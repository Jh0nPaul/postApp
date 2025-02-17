import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posrestaurant/cubit/settings/users/users_cubit.dart';
import 'package:posrestaurant/shared/widgets/dropdown/bloc_dropdown.dart';
import '../../../core/handlers/sqlite_handler.dart';
import '../../../cubit/home/obscure_text/obscure_text.dart';
import '../../../cubit/widgets/custom_drop_down/drop_cubit.dart';
import '../../../shared/widgets/text_fields/data_text_field.dart';


class UserRegistration extends StatefulWidget {

   const UserRegistration({
     super.key,
   });

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  late ThemeData theme;
  late Size size;

  String _selectedRole = '';
  String _selectedStatus = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DBHelper sqliteHandler = DBHelper();

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return Dialog(
      child: _body(),
    );
  }

  Widget _body(){
    return Container(
      height: size.height-220,
      width: size.width-500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onPrimaryContainer,
      ),
      child:Column(
        children:
        [
          _header (),
          _form(),

        ],
      ),
    );
  }

  Widget _header (){
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _saveButton(),
          SizedBox(
            width: size.width*.15,
            child: Text('Registrar usuario',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          IconButton(
            onPressed: (){
              context.pop();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
Widget _form(){
    return SizedBox(
      height: size.height-280,
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _firstColumn(),
            _secondColumn(),
          ],
        ),
      ),
    );
  }
  Widget _firstColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 15,),
        InfoTextField(
          label: 'Nombre',
          hint: 'Nombre Completo',
          controller: _nameController,
          inputType: TextInputType.text,
          isPassword: false,
          validator: (validator){
            if(validator!.isEmpty||validator.length<3){
              return 'Ingrese un nombre valido';
            }
            return null;
          },
        ),
        InfoTextField(
          label: 'Usuario',
          hint: 'Username',
          controller: _usernameController,
          inputType: TextInputType.text,
          isPassword: false,
          validator: (validator){
            if(validator!.isEmpty||validator.length<3){
              return 'Ingrese un nombre valido';
            }
            return null;
          },
        ),
        InfoTextField(
          label: 'Email',
          hint: 'Correo del usuario',
          controller: _emailController,
          inputType: TextInputType.emailAddress,
          isPassword: false,
          validator: (value){
            if(value!.isEmpty || !value.contains('@')){
              return 'Ingrese un correo valido';
            }
            return null;
          },
        ),
        InfoTextField(
          label: 'Telefono',
          hint: 'Telefono del usuario',
          controller: _phoneController,
          inputType: TextInputType.text,
          isPassword: false,
          validator: (value){
            if(value!.isEmpty || value.length<10||value.contains(RegExp(r'[a-zA-Z]'))){
              return 'Ingrese un telefono valido';
            }
            return null;
          },
        ),

        const SizedBox(height: 15),
      ],
    );
  }
  Widget _secondColumn() {
  List<String> items = ['Estatus de usuario','Activo', 'Inactivo'];
  List<String> roll = ['Rol de usuario','Admin', 'User'];
  bool _showPass = false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 15),
    BlocProvider(
    create: (_)=>TextVisibiltyCubit(),
    child: BlocBuilder<TextVisibiltyCubit, bool>(
          builder: (context, visible)=> InfoTextField(
            label:'PIN',
            hint: 'PIN de usuario',
            controller: _pinController,
            inputType: TextInputType.text,
            isPassword: visible,
            validator: (value){
              if(value!.contains(RegExp(r'[a-zA-Z]'))
                  && value.length < 4
                  && value.isEmpty
                  &&value.length>4
              ){
                return 'Ingrese un PIN valido';
              }
              return null;
            },
            icon: IconButton(
                onPressed:(){
                  context.read<TextVisibiltyCubit>().changeVisibility();
                },
                icon: Icon(visible ?Icons.visibility_off_outlined: Icons.visibility_outlined  ,color: Colors.black,)),
          ),
        ),),
        BlocProvider(
          create: (_)=>TextVisibiltyCubit(),
          child: BlocBuilder<TextVisibiltyCubit, bool>(
            builder: (context, visible)=> InfoTextField(
              label:'PIN',
              hint: 'Confiramar PIN',
              controller: _confirmPinController,
              inputType: TextInputType.text,
              isPassword: visible,
              validator: (value){
                if(value!.contains(RegExp(r'[a-zA-Z]'))
                    && value != _pinController.text
                ){
                  return 'PIN no coincide';
                }
                return null;
              },
              icon: IconButton(
                  onPressed:(){
                    context.read<TextVisibiltyCubit>().changeVisibility();

                  },
                  icon: Icon(visible ?Icons.visibility_off_outlined: Icons.visibility_outlined  ,color: Colors.black,)),
            ),
          ),),
        BlocProvider(
          create: (context) => DropDownCubit(),
          child: CustomDropdownB(
            width: .2,
              items: roll,
            onSelected: (String value){
              setState(() {
              _selectedRole = value;
              });
            },
          ),
        ),
        BlocProvider(
          create: (context) => DropDownCubit(),
          child: CustomDropdownB(
            width: .2,
              items: items,
            onSelected: (String value) {
              setState(() {
              _selectedStatus = value;
              });
            },

          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _saveButton(){
    return SizedBox(
      width: size.width*.07,
      child: BlocProvider(
        create: (_)=> UserCubit(DBHelper()),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          height: size.height*.06,
          highlightColor: Colors.transparent,
          mouseCursor: WidgetStateMouseCursor.clickable,
          color: theme.colorScheme.onPrimaryContainer,
          child:    Text('Guardar'),
          onPressed: () async {
            _saveUser();
          },
        ),
      ),
    );
  }

  void _saveUser() async {
    if( _formKey.currentState!.validate() ){

        var db = await sqliteHandler.openDB();
        await db.insert('users', {
          'name': _nameController.text,
          'username': _usernameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'pin': _pinController.text,
          'role': _selectedRole,
          'status': _selectedStatus,
        });
        if(context.mounted){
          context.read<UserCubit>().fetchUsers();
          context.pop();
        }
      }

    }
  }
