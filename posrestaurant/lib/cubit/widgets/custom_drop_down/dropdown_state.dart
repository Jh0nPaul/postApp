part of 'drop_cubit.dart';

abstract class DropDownState extends Equatable  {
  const DropDownState();
  @override
  List<Object> get props => [];
}
class DropownInitial extends DropDownState{}

class DropownSelected extends DropDownState{
  final String selectedItem;
   const DropownSelected(this.selectedItem);
  @override
  List<Object>  get props => [selectedItem];
}