import 'package:copy_food/shop/model/json_model.dart';
import 'package:flutter/material.dart';



class ShopCard extends StatelessWidget {
  final ShopModel model;
  final int index;
  final Function(double val) onHeight;
  static const GRID_COLUMN_VALUE = 2;

  const ShopCard({Key key, this.model, this.index, this.onHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onHeight((context.size.height) /
          (model.products.length / GRID_COLUMN_VALUE));
    });
    return Column(
        children: [

          Padding(
              padding: EdgeInsets.fromLTRB(10, 2.5, 0, 2.5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("${model.categoryName}", textAlign: TextAlign.left, style: TextStyle(fontSize: 22),)),
              ),
          Container(

            child: buildGridViewProducts(index, model.products),
          ),
        ],
    );

  }

  GridView buildGridViewProducts(int index, List<Product> products) {
    return GridView.builder(

      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: GRID_COLUMN_VALUE),
      itemBuilder: (context, index) {
        return Container(

          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      image: DecorationImage(

                        image: AssetImage(model.products[index].pic.toString()),
                        fit: BoxFit.cover,

                      )
                  ),

                ),
                ),
              Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left:4, top:2),
                            child: Text(model.products[index].name,
                                textAlign: TextAlign.left),
                          )
                        ),
                        Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(

                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(model.products[index].price.toString()+" ₽",
                                        textAlign: TextAlign.left,),

                                    ),

                                    SizedBox(width: 55),

                                  if (model.products[index].weight != 0)
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(model.products[index].weight.toString(),
                                          textAlign: TextAlign.right,

                                          style: TextStyle(color: Colors.white54),
                                      )

                                    ),

                                ],
                              ),

                            ),
                          )


                      ],
                    ),
                  ),
                )


              // Text(model.products[index].name),
              // Text(model.products[index].weight.toString()),
            ],
          ),
        );
      },
    );
  }

}
