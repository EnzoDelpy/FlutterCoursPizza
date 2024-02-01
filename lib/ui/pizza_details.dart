import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdev/models/cart.dart';
import 'package:flutterdev/models/option_item.dart';
import 'package:flutterdev/models/pizza.dart';
import 'package:flutterdev/ui/share/buy_button_widget.dart';
import 'package:flutterdev/ui/share/pizzeria_style.dart';
import 'package:flutterdev/ui/share/total_widget.dart';

class PizzaDetails extends StatefulWidget {
  final Pizza _pizza;
  final Cart _cart;

  PizzaDetails(this._pizza, this._cart, {Key? key}) : super(key: key);

  @override
  State<PizzaDetails> createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._pizza.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          Text(
            'Pizza ${widget._pizza.title}',
            style: PizzeriaStyle.pageTitleTextStyle
          ),
          Image.network(
            widget._pizza.image,
            height: 180,
          ),
          Text(
              'Recette',
              style: PizzeriaStyle.headerTextStyle
          ),
          Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: Text(
              widget._pizza.garniture
            ),
          ),
          Text(
              'Pate et taille sélectionnées',
              style: PizzeriaStyle.headerTextStyle
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildDropDownPates()),
              Expanded(child: _buildDropDownTailles())
            ],
          ),
          Text(
              'Sauce sélectionnées',
              style: PizzeriaStyle.headerTextStyle
          ),
          Text('Les sauces'),
          _buildDropDownSauces(),
          TotalWidget(widget._pizza.total),
          BuyButtonWidget(widget._pizza, widget._cart),
        ],
      )
    );
  }

  _buildBuyButton(){
    return
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.red.shade800)
              ),
              child: Row(
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 5),
                  Text("Commander"),
                ],
              ),
              onPressed: (){
                print('Commander une pizza');
              },
            )
          ],
        );
    }

    _buildDropDownPates(){
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.pates[widget._pizza.pate],
      items: _buildDropDownItem(Pizza.pates),
      onChanged: (item){
        setState(() {
          widget._pizza.pate = item!.value;
        });
      },
    );
    }

  _buildDropDownTailles(){
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.tailles[widget._pizza.taille],
      items: _buildDropDownItem(Pizza.tailles),
      onChanged: (item){
        setState(() {
          widget._pizza.taille = item!.value;
        });
      },
    );
  }

  _buildDropDownSauces(){
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.sauces[widget._pizza.sauce],
      items: _buildDropDownItem(Pizza.sauces),
      onChanged: (item){
        setState(() {
          widget._pizza.sauce = item!.value;
        });
      },
    );
  }

    _buildDropDownItem(List<OptionItem> list){
    return Iterable.generate(
      list.length,
        (i) => DropdownMenuItem<OptionItem>(
          value: list[i],
          child: Text(list[i].name),

        ),
    ).toList();
    }
}
