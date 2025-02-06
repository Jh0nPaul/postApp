import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posrestaurant/cubit/settings/change_page.dart';
import 'package:posrestaurant/presentation/settings/users_config.dart';
class ConfiguracionScreen extends StatefulWidget {
  const ConfiguracionScreen({super.key});

  @override
  State<ConfiguracionScreen> createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  @override
  late ThemeData theme;
  late Size size;
  String activePage = 'General';

  _switchPage(state){
          switch(state){
            case 'General':
              return Container( color: Colors.orange, width: size.width,height: size.height,);
            case 'Usuarios':
              return UsersConfig();
            case 'Impresora':
              return Container(color: Colors.blue, width: size.width,height: size.height,);
            case 'Caja':
              return Container(color: Colors.grey, width: size.width,height: size.height,);
            case 'Cierre de caja':
              return Container(color: Colors.orange, width: size.width,height: size.height,);
            default:
              return Container(color: Colors.orange, width: size.width,height: size.height,);
     }
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
        appBar: _appBar(),
        body: BlocProvider(
            create: (_)=> ChangeSetting(),
            child: _body()));
  }

  PreferredSizeWidget _appBar(){
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text('Configuración'),
      centerTitle: true,
    );
  }
  Widget _body(){
    return Row(
      children: [
        Container(
          height: size.height-200,
          decoration: BoxDecoration(
          color: theme.colorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.circular(8),

          ),
          width: size.width*.12,
          child: _sideMenu(),
        ),
        Expanded(
          child: Container(
            height: size.height-200,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: BlocBuilder<ChangeSetting,String>(
                    builder: (context, state){
                      return _switchPage(state);
                    }
                  ),
          ),
        ),
      ],
    );
  }

  Widget _sideMenu(){
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              _itemMenu( 'General', Icons.settings),
              _itemMenu( 'Usuarios', Icons.person),
              _itemMenu( 'Impresora', Icons.print),
              _itemMenu( 'Caja', Icons.money),
              _itemMenu( 'Cierre de caja', Icons.close),
            ],
          ),
        )
      ],
    );
  }


  Widget _itemMenu(String title,IconData iconData){
    return BlocBuilder<ChangeSetting,String>(
      builder: (context, state){
        return Padding(
          padding: const EdgeInsets.all(1),
          child: GestureDetector(
            onTap: () => context.read<ChangeSetting>().changePage(title),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: state == title
                ? theme.colorScheme.primary
                    :theme.colorScheme.onPrimaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                curve: Curves.slowMiddle,
                duration: const Duration(milliseconds: 300),
                width: size.width,
                height: size.height * .07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10,),
                    Icon(iconData),
                    const SizedBox(width: 10,),
                    SizedBox(child: Text(title)),
                  ],
                ),

              ),
            ),
          ),
        );
      },
    );
  }
}
