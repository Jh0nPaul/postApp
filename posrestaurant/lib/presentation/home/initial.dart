import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home/to_pay_home/count_cubit.dart';
class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late ThemeData theme;
  late Size size;
  List<Total> totalList = [];
  List<dynamic> orderList = [];

List<Categoria> categoriaList =[
  Categoria(title: 'Burgers'),
  Categoria(title: 'Alitas'),
  Categoria(title: 'ensaladas'),
  Categoria(title: 'Postres'),
  Categoria(title: 'Bebidas'),
];
  List<MenuItem> burgerList = [
    MenuItem(
      title: 'Hamburguesa',
      price: '12.00',
      item: 'USD',
      image: '',
    ),
    MenuItem(
      title: 'Hamburguesa doble',
      price: '10.00',
      item: 'USD',
      image: '',
    ),
    MenuItem(
      title: 'Hamburguesa triple con queso',
      price: '8.00',
      item: 'USD',
      image: '',
    ),
    MenuItem(
      title: 'Hamburguesa con papas',
      price: '15.00',
      item: 'USD',
      image: '',
    ),
    MenuItem(
      title: 'Hamburguesa con papas y refresco',
      price: '12.00',
      item: 'USD',
      image: '',
    ),
    MenuItem(
      title: 'Hamburguesa y refresco',
      price: '10.00',
      item: 'USD',
      image: '',
    ),
    MenuItem(
      title: 'Hamburguesa picante',
      price: '8.00',
      item: 'USD',
      image: '',
    ),
    MenuItem(
      title: 'Hamburguesa camaron',
      price: '15.00',
      item: 'USD',
      image: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    theme = Theme.of(context);
    return _body();
  }
  Widget _body(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Expanded(
          flex: 14,
            /// vertical space
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topMenu(
                  action: _search(),
                  title: 'Restaurant',
                  sub: 'Fecha',
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  width: size.width,
                  height: size.height*.1,
                  child: _categoryMenu()
                ),
                Expanded(
                  child: BlocProvider(
                    create: (_)=> PayCubit(),
                    child: GridView.builder(
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:size.width~/280,
                          crossAxisSpacing:10,
                          mainAxisSpacing:10,
                          mainAxisExtent: 210,
                          childAspectRatio: size.width/(size.height/.55),
                        ),
                        itemCount: burgerList.length,
                        itemBuilder: (context,index){
                          var item = burgerList[index];
                          return _item( item, index );
                        }),
                  ),
                ),


              ],
            ),
        ),
        /// horizontal space
        const SizedBox(width: 20,),
        _orderMenu(),

      ]
    );
  }

  Widget _topMenu({
    String title= 'Inserte Menu',
    String sub = 'Inserte subtitle',
    required Widget action,
  }){
    return Row(

      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimary,
            )
            ),
            const SizedBox(height: 6,),
            Text( sub,  style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onPrimary,
            )),
          ],),
        Expanded(flex:1,
            child: Container(
              width: double.infinity,)),
        Expanded(flex:5,
            child: action
        )
      ],
    );
  }

  Widget _search(){
    return SizedBox(
      width: size.width,
      child: SearchBar(
        backgroundColor: WidgetStateProperty.all(theme.colorScheme.onSurface),
        hintText: 'Buscar',
        hintStyle: WidgetStatePropertyAll(TextStyle(color: theme.colorScheme.onPrimary)),
        leading: Icon(Icons.search,
          color: theme.colorScheme.onPrimary,),
        onChanged: (value){
          print(value);
        },
      ),
    );
  }

  Widget _orderMenu(){
    return SizedBox(
      width: size.width*.24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const SizedBox(: 20,),
          _topMenu(
            title: 'Order',
            sub: 'Order sub',
            action: const SizedBox(),
          ),
          const SizedBox(height: 20,),
          Divider(color: theme.colorScheme.onPrimary,),
          const SizedBox(height: 20,),
          SizedBox(
            height: size.height*.43,
            child: BlocBuilder<PayCubit, List<Total>>(
                builder: ( context, totalList ){
                  return ListView.builder(
                    itemCount: totalList.length,
                    itemBuilder: (context, index){
                      return _orderContainer(totalList[index], index);
                    },
                  );
                }
            )
          ),
          // const SizedBox(height: 20,),
          _billContainer(),
        ],
      ),
    );
  }

  Widget _billContainer(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: size.width,
      height: size.height*.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.onPrimaryContainer,
      ),
      child: Column(
        children: [
          _count(),
          const Spacer(),
          _optionButton(),
        ],
      ),
    );
  }

  Widget _count(){
    return SizedBox(
      width: size.width,
      height: size.height*.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Total: ', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
              Text('100.00', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Items: ', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
              Text('10', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            ],
          ),
          Divider(  endIndent: 10, indent: 10),
        ],
      ),
    );
  }
  Widget _optionButton(){
    return SizedBox(
      height: size.height*.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: size.width*.2,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.orange),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
              ),
              onPressed: (){
                print('Cobrar');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(),
                  Text("Cobrar Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                  Icon(Icons.payment_outlined
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: size.width*.2,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.orange),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
              ),
              onPressed: (){
                print('Cobrar');
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(),
                  Text("Añadir a mesa",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                  Icon(Icons.payment_outlined
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(MenuItem item, int index) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(0),
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        overlayColor: WidgetStateProperty.all(Colors.orange),
        splashFactory: InkRipple.splashFactory,
        splashColor: Colors.orange,
        enableFeedback: true,
        highlightColor: Colors.orange,
        focusColor: Colors.orange,
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          context.read<PayCubit>().addItem(item);
          print("Item added");
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // Evita desbordamiento vertical
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 130,
                width: double.infinity, // Asegura que la imagen no desborde horizontalmente
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/burguer.jpg',
                    fit: BoxFit.cover, // Ajusta la imagen al contenedor
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Tooltip(
                message: item.title,
                child: SizedBox(
                  width: double.infinity, // Evita desbordamiento horizontal
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuye los elementos en la fila
                children: [
                  Text(
                    item.price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      item.item,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis, // Previene desbordamientos
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget _categoryMenu(){
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      controller: ScrollController(),
      children: categoriaList.map((item) =>
        Material(
          color: Colors.transparent,
          child: InkWell(
              mouseCursor: SystemMouseCursors.click,
              overlayColor: WidgetStateProperty.all(Colors.orange),
              splashFactory: InkRipple.splashFactory,
              splashColor: Colors.orange,
              enableFeedback: true,
              highlightColor: Colors.orange,
              focusColor: Colors.orange,
              borderRadius: BorderRadius.circular(15),
              onTap: (){
              },
              child: _secondaryItem( item )),
        )
      ).toList()
    );
}
Widget _secondaryItem(Categoria item){
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.onSurface,
      ),
          width: size.width*.09,
          margin: const EdgeInsets.all(5),
          child:Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Icon(Icons.import_contacts, size: ( size.width~/1 ) /size.height/.12,),
      Text(item.title, style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),),
      const SizedBox.shrink(),
    ],
          ),
        );
}

Widget _orderContainer (Total item, index){
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.onPrimaryContainer,
      ),
      width: size.width*.15,
      margin: const EdgeInsets.all(5),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.delete_forever_outlined),
            onPressed: () {
           context.read<PayCubit>().removeItem(index);
            },
          ),
          Text(
            item.item.title,
            style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            // overflow: TextOverflow.ellipsis,
            fontSize: 15,
          ),),
          Text(
            '\$ ${item.item.price}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),),
        ],
      ),
    );
}

}

class MenuItem{
  final String title;
  final String price;
  final String item;
  final String? image;
  MenuItem({
    required this.title,
    required this.price,
    required this.item,
    this.image = 'assets/images/burger.jpg',
  });
}

class Categoria{
  final String title;
  // final List<ItemMenu> items;
  Categoria({
    required this.title,
    // required this.items,
  });
}

class Total{
  final MenuItem item;
  final double total;
  final int items;
  Total({
    required this.item,
    required this.total,
    required this.items,
  });
}