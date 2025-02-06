import 'package:flutter/material.dart';

import '../../shared/widgets/text_fields/data_text_field.dart';

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
        color: Color(0xffD3D2C7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _firstColumn(),
          _secondcolumn(),
          _thirdColumn(),
        ],
      ),
    );
  }
  Widget _firstColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InfoTextField(
          label: 'Nombre',
          hint: 'Nombre del usuario',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: false,
        ),

        InfoTextField(
          label: 'Email',
          hint: 'Correo del usuario',
          controller: TextEditingController(),
          inputType: TextInputType.emailAddress,
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



      ],
    );
  }
  Widget _secondcolumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
      ],
    );
  }

  Widget _thirdColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfoTextField(
          label: 'Fecha de modificación',
          hint: 'Fecha de modificación del usuario',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: false,
        ),
        InfoTextField(
          label: 'Pin de usuario',
          hint: 'Pin de usuario',
          controller: TextEditingController(),
          inputType: TextInputType.text,
          isPassword: false,
        ),
        const SizedBox(height: 15,),
        const SizedBox(height: 15),
        const SizedBox(height: 15),


      ],
    );
  }

}
