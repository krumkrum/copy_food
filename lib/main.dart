import 'package:copy_food/screen.dart';
import 'package:copy_food/shop/bloc/shop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopBloc()..add(InitialShop()),
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black38
        ),
        title: 'Material App',
        color: Colors.black,
        home: Screen(),

      ),
    );

  }

}