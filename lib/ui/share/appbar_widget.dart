import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdev/models/cart.dart';
import 'package:flutterdev/ui/panier.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Cart _cart;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const AppBarWidget(this.title, this._cart, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Panier(_cart)));
            },
            icon: Icon(Icons.shopping_cart))
      ],
    );
  }
}
