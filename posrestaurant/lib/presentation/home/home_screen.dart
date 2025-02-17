import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posrestaurant/presentation/historial/historial.page.dart';
import 'package:posrestaurant/presentation/home/initial.dart';
import 'package:posrestaurant/presentation/menu/menu_screen.dart';

import '../../cubit/home/home_page/home_page_selector.dart';
import '../../cubit/theme/theme_cubit.dart';
import '../settings/products/products_screen.dart';
import '../settings/users/configuracion_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData theme;
  late Size size;

  bool isDarkmode = false;

  String pageActive = 'Home';

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_)=> ChangePageSelector(),
      child: Scaffold(
        backgroundColor: theme.colorScheme.onSurface,
        body: _body(),
      ),
    );
  }

  Widget _body(){
    return Row(
      children:[
        Container(
          width: size.width*.07,
          padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
          height: size.height,
          color: theme.colorScheme.onSurface,
          child: _sideMenu(),
        ),
        Expanded(child: Container(
          margin: const EdgeInsets.only(top: 24, right: 12),
          padding: const EdgeInsets.only( top:12, right: 12, left: 12 ),
          decoration: BoxDecoration(
            color: theme.colorScheme.onTertiary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),child:  _pageView(),
        ),
        ),
      ]
    );
  }

  Widget _sideMenu(){
    return Column(
      children:[
        _logo(),
        const SizedBox(height: 20,),
        Expanded(
            child: ListView(
              children: [
                _itemMenu(
                  menu: 'Home',
                  icon: Icons.rocket_sharp,
                ),
                _itemMenu(
                  menu: 'Productos',
                  icon: Icons.format_list_bulleted_rounded,
                ),
                _itemMenu(
                  menu: 'History',
                  icon: Icons.history_toggle_off_rounded,
                ),
                _itemMenu(
                  menu: 'Promos',
                  icon: Icons.discount_outlined,
                ),
                _itemMenu(
                  menu: 'Settings',
                  icon: Icons.sports_soccer_outlined,
                ),
              ],
            )
        ),
        _themeWidget(),
        const SizedBox(height: 20,),
      ]
    );
  }

  Widget _logo(){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(30),
          ),
          child:
          Icon( Icons.food_bank, size: 30),
        ),
        const SizedBox(height: 10,),
        Text("POS", style: TextStyle(color: theme.colorScheme.tertiary),)
      ],
    );
  }
  Widget _themeWidget(){
    return  IconButton(
        onPressed:() => context.read<ThemeCubit>().toggleTheme(isDarkmode = !isDarkmode),
        icon: Icon(isDarkmode? Icons.dark_mode_outlined:Icons.light_mode_outlined,
          size: 30,
          color: theme.colorScheme.onPrimary ,)
    );
  }

  Widget _itemMenu({required String menu, required IconData icon}){
    return BlocBuilder< ChangePageSelector, String >(
        builder: (context, state){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: GestureDetector(
          onTap:() => context.read<ChangePageSelector>().changePage(menu),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              padding: const EdgeInsets.symmetric(vertical:12),
              decoration: BoxDecoration(
                color: state == menu
                    ? theme.colorScheme.onSecondary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.slowMiddle,
              child: Column(
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(height: 10,),
                  Text(menu, style: TextStyle(color: Colors.white),)

                ],
              ),
            ),
          ),

        ),
      );
    });
  }

  _pageView(){
    return BlocBuilder<ChangePageSelector,String>(
        builder: ( context, state ){
           switch(state){
              case 'Home':
          return InitialScreen();
              case 'Productos':
          return ProductsScreen();
             case 'History':
          return HistorialPage();
             case 'Promos':
          return Container();
              case 'Settings':
          return ConfiguracionScreen();
              default:
          return Container();
          }
        }
    );
  }
}
