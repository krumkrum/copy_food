import 'dart:async';

import 'package:copy_food/shop/model/json_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';


part 'shop_event.dart';
part 'shop_state.dart';



class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial());


  List<ShopModel> shopList = [];

  @override
  Stream<ShopState> mapEventToState(ShopEvent event,) async* {
    if (event is InitialShop){

      // Инициализируем
      yield ShopInitial();

      // Загружаем данные / В нашем случае с локального JSON
      await loadJsonData();
      yield ShopLoaded(shopList);
    }


  }

  // ignore: missing_return
  Future <String> loadJsonData() async{

    var JsonText = await rootBundle.loadString("assets/data.json");

    final dataPost = dataPostFromJson(JsonText);

    // Выглядит не очень, но решил использовать локальный JSON, для хранения всех данных

    //Добавляем все данные в лист из которого позже будем отрисоывать все данные о товарах
    shopList.add(ShopModel(categoryName:"Популярные блюда", products: dataPost.pops));
    shopList.add(ShopModel(categoryName:"Гриль", products: dataPost.grill));
    shopList.add(ShopModel(categoryName:"Креветки", products: dataPost.shrimp));
    shopList.add(ShopModel(categoryName:"Комбо", products: dataPost.combo));

  }
}


