import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdev/models/cart.dart';
import 'package:flutterdev/models/pizza.dart';
import 'package:flutterdev/services/pizzeria_service.dart';
import 'package:flutterdev/ui/pizza_details.dart';
import 'package:flutterdev/ui/share/appbar_widget.dart';
import 'package:flutterdev/ui/share/buy_button_widget.dart';
import 'package:flutterdev/ui/share/pizzeria_style.dart';

class PizzaList extends StatefulWidget {
  final Cart _cart;
  const PizzaList(this._cart, {Key? key}): super(key: key);

  @override
  State<PizzaList> createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {

  late Future<List<Pizza>> _pizzas;
  PizzeriaService _service = PizzeriaService();

  @override
  void initState(){
    super.initState(); 
    _pizzas = _service.fetchPizzas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget('Nos Pizzas', widget._cart),
      body: FutureBuilder<List<Pizza>>(
        future: _pizzas,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return _buildListView(snapshot.data!);
          } else if (snapshot.hasError){
            return Center(child: Text('Impossible de récupérer les données : ${snapshot.error}',
            style: PizzeriaStyle.errorTextStyle,
            ),);
          }
          return Center(child:CircularProgressIndicator());
        }
      )
    );
  }

  _buildRow(Pizza pizza){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10.0), top: Radius.circular(2.0)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PizzaDetails(pizza, widget._cart))
              );
            },
            child: _buildPizzaDetails(pizza),
          ),
          BuyButtonWidget(pizza, widget._cart),
        ],
      )
    );
  }

  _buildPizzaDetails(Pizza pizza){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title:Text(pizza.title),
          subtitle: Text(pizza.garniture),
          leading: Icon(Icons.local_pizza)
        ),
        Image.network(
          pizza.image,
          height: 120,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Text(pizza.garniture),
        )
      ],
    );
  }

  _buildListView(List<Pizza> pizzas){
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: pizzas.length,
      itemBuilder: (context, index){
        return _buildRow(pizzas[index]);
      },
    );
  }

}

