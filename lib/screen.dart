import 'package:copy_food/shop/bloc/shop_bloc.dart';
import 'package:copy_food/shop/widget/shop_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TabBarChange extends ChangeNotifier {
  int index = 0;

  void changeIndex(int val) {
    index = val;
    notifyListeners();
  }
}

TabBarChange tabBarNotifier = TabBarChange();


class Screen extends StatelessWidget{


  ScrollController scrollController = ScrollController();
  int currentCategoryIndex = 0;
  ScrollController headerScrollController = ScrollController();




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        actions: [
          Align(child: Icon(Icons.info_outline),
            alignment: Alignment.centerRight,),

        ],
        title: Center(child: Text("Бургер кинг")),
      ),
      // ignore: missing_return
      body: BlocBuilder<ShopBloc, ShopState>(builder: (BuildContext context, state) {
        if (state is ShopInitial) {
          return CircularProgressIndicator();
          }
        if (state is ShopLoaded){
          scrollController.addListener(() {
            final index = state.shopList.indexWhere((element) => element.position >= scrollController.offset);
            tabBarNotifier.changeIndex(index);
            headerScrollController.animateTo(index * (MediaQuery.of(context).size.width * 0.2), duration: Duration(seconds: 1), curve: Curves.decelerate);
          });
          return buildChangeBody(context, state);
        }
        return Center(
          child: Text("text"),
        );
        }
      ),
    );
  }

  ChangeNotifierProvider<TabBarChange> buildChangeBody(context, state) {
    return ChangeNotifierProvider.value(
        value: tabBarNotifier,

        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 1,
                  child: Consumer<TabBarChange>(
                  builder: (context, value, child) => ListView.builder(
                    itemCount: state.shopList.length,
                    controller: headerScrollController,
                    padding: EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildPaddingHeaderCard(index, state),
                    ),
                )
              ),
              Divider(),
              Expanded(flex: 9, child: ListView.builder(
                controller: scrollController,
                itemCount: state.shopList.length + 1,
                itemBuilder: (context, index) {


                  if (index == state.shopList.length)
                    return Container();


                  else
                    return ShopCard(
                      model: state.shopList[index],
                      index: index,
                      onHeight: (val) {state.fillListPositionValues(val);},

                    );

                },
              )
              ),
            ],
          ),
          color: Colors.black54,
        )
    );
  }

  Padding buildPaddingHeaderCard(int index, state) {
    return Padding(

      padding: EdgeInsets.symmetric(horizontal: 5),

      child: RaisedButton(
        color: tabBarNotifier.index == index ? Colors.amberAccent : Colors.transparent,
        elevation: 0,
        onPressed: () => headerListChangePosition(index, state),
        child: Text("${state.shopList[index].categoryName}",
          style: TextStyle(
            color: tabBarNotifier.index == index ? Colors.black87 : Colors.white54,
          ),
        ),
        shape: StadiumBorder(),
      ),
    );
  }





void headerListChangePosition(int index, state) {
  scrollController.animateTo(state.shopList[index].position,
      duration: Duration(seconds: 1), curve: Curves.ease);
}










}



