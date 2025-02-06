import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation/home/initial.dart';

class PayCubit extends Cubit<List<Total>> {
  PayCubit() : super([]);

  void addItem( MenuItem item ){
    final newList = List<Total>.from(state);
    newList.add(
        Total(
            item: MenuItem(
                title: item.title,
                price: item.price,
                item: item.item,
            ),
            total: double.parse(item.price),
            items: newList.length +1
        )
    );
    print(newList);
    emit(newList);
  }

  void removeItem(int index){
    final newList = List<Total>.from(state);
    newList.removeAt(index);
    emit(newList);
  }
  void clearOrders(){
    emit([]);
  }

}