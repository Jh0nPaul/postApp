import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posrestaurant/cubit/widgets/custom_drop_down/drop_cubit.dart';

class CustomDropdownB extends StatelessWidget {
  final List<String> items;
  final double? width;
  final Function(String)? onSelected;

  const CustomDropdownB({
    required this.items,
    this.width,
    super.key,
    this.onSelected
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<DropDownCubit, DropDownState>(
        builder: (context, state){
          String selectedItem = state is DropownSelected ? state.selectedItem : items[0];
          return SizedBox(
            width: size.width*width!,
            child: DropdownButtonFormField(
              onTap: (){
                if (selectedItem != null) {
                  context.read<DropDownCubit>().selectItem(selectedItem);
                  onSelected!(selectedItem);
                }
              },
                value: selectedItem ,
                onChanged: (String? selectedItem){
                  if(selectedItem != null){
                    context.read<DropDownCubit>().selectItem(selectedItem);
                  }
                },
                items: items.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
             enableFeedback: true,
              borderRadius: BorderRadius.circular(8),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
            ),
          )
          );
        }
    );
  }
}
