import 'package:flutter/material.dart';
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}
enum ProductView { product, combos }
class _ProductsScreenState extends State<ProductsScreen> {
  late ThemeData theme;
  late Size size;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Productos',
          style: TextStyle(
              color: theme.colorScheme.onPrimary),
        ),
      ),
        backgroundColor: Colors.transparent,
        body: _body());
  }

  Widget _body(){
  return Column(
    children: [
      _miniBar(),
      const SizedBox(height: 12,),
      productsContainer(),
    ],
  );
  }

  Widget _miniBar(){
    return Container(
      decoration: BoxDecoration(
      color: theme.colorScheme.onSurface,
      borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(left: 12, right: 12),
      height: size.height*.1,
      child: Row(
        children: [
          SizedBox(
            width: size.width*.4,
            child: SearchBar(
              hintText: 'Buscar producto',
              hintStyle: WidgetStatePropertyAll(TextStyle(color: theme.colorScheme.onPrimary)),
              backgroundColor: WidgetStatePropertyAll(theme.colorScheme.onPrimaryContainer),
              controller: TextEditingController(),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
              leading: Icon(Icons.search, color: theme.colorScheme.onPrimary,),
            ),
          ),
          SegmentedButton(
              segments: List.empty(),
              selected: <ProductView>{ProductView.product},
            
          )
        ],
      ),
    );
  }

  Widget productsContainer(){
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return Placeholder();
        },
      ),
    );
  }

}
