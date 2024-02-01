import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdev/models/cart.dart';
import 'package:flutterdev/ui/share/pizzeria_style.dart';

class Panier extends StatefulWidget {
  final Cart _cart;
  const Panier(this._cart, {Key? key}) : super(key: key);

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Panier'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: List.generate(widget._cart.totalItems(), (index) {
                  return _buildItem(widget._cart.getCartItem(index));
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                border: TableBorder.all( color: Colors.red),
                
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(64)
                },
                children: [
                  TableRow(
                      children: [Container(), Text("TOTAL HT"), Text((widget._cart.getTotalPrice() - widget._cart.getTotalPrice()/120*20).toStringAsFixed(2)+ " €" )]),
                  TableRow(children: [Container(), Text("TVA"), Text((widget._cart.getTotalPrice()/120*20).toStringAsFixed(2)+ " €")]),
                  TableRow(
                      children: [Container(), Text("TOTAL TTC"), Text(widget._cart.getTotalPrice().toStringAsFixed(2)+ " €")])
                ],
              ),
            ),
            // Row(
            //   children: [Text('Total'), Text('30 €')],
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      'Valider le panier',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      print('Valider');
                    }),
              ),
            )
          ],
        ));
  }

  Widget _buildItem(CartItem cartItem) {
                          

    return Row(
      children: [
        Image.network(
          cartItem.pizza.image,
          height: 140,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(cartItem.pizza.title, style: PizzeriaStyle.headerTextStyle),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Text(cartItem.pizza.total.toString() + ' €',
                            style: TextStyle(
                                color: Color.fromARGB(255, 131, 130, 130)))),
                    Expanded(
                        child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                widget._cart.RemoveProduct(cartItem.pizza);
                              });
                            },
                            icon: Icon(Icons.remove)),
                        Text(cartItem.quantity.toString()),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                widget._cart.addProduct(cartItem.pizza);
                              });
                            },
                            icon: Icon(Icons.add))
                      ],
                    )),
                  ],
                ),
              ),
              Text(
                  'Sous-total ' +
                      (cartItem.pizza.total * cartItem.quantity)
                          .toStringAsFixed(2) +
                      ' €',
                  style: PizzeriaStyle.priceTotalTextStyle),
            ]),
          ),
        )
      ],
    );
  }
}
