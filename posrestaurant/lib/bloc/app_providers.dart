
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posrestaurant/cubit/home/home_page/home_page_selector.dart';
import '../cubit/home/to_pay_home/count_cubit.dart';
import '../cubit/settings/change_page.dart';
import '../cubit/theme/theme_cubit.dart';

class AppProviders{

  static List<BlocProvider> getBlocProviders(){
    return [];
  }

  static List<BlocProvider> getCubitProviders(){
    return [
      BlocProvider<ThemeCubit>(create: (_)=> ThemeCubit()),
      BlocProvider<ChangePageSelector>(create: (_)=> ChangePageSelector()),
      BlocProvider<PayCubit>(create: (_)=> PayCubit()),
      BlocProvider<ChangeSetting>(create: (_)=> ChangeSetting()),
    ];
  }
  static List<BlocProvider> getBothProviders(){
    return [
      ...getBlocProviders(),
      ...getCubitProviders(),
    ];
  }
}