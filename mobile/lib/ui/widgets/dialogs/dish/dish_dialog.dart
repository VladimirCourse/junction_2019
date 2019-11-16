import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/ui/widgets/containers/image/image_container.dart';

import 'dish_dialog_bloc.dart';

import '../../buttons/main_button.dart';
import '../../buttons/second_button.dart';

import '../../../resources/app_colors.dart';

//import '../../../util/formatter.dart';

import '../../../../models/place.dart';
import '../../../../models/dish.dart';

class DishDialog extends StatefulWidget {

  final Place place;
  final Dish dish;

  DishDialog({this.place, this.dish});

  @override
  CartDishDialogState createState() => CartDishDialogState();
}

class CartDishDialogState extends State<DishDialog> {

  DishDialogBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = DishDialogBloc(widget.place, widget.dish);
  }

  void onAdd() {
    bloc.add();
    Navigator.pop(context);
  }

  void onDelete() {
    bloc.delete();
    Navigator.pop(context);
  }

  void onInc() {
    bloc.inc();
  }

  void onDec() {
    bloc.dec();
  }

  Widget buildButton(IconData icon, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.grey.withOpacity(0.3))
        ),
        child: Icon(icon,
          size: 16
        ),
      ),
    );
  } 

  Widget buildText() {
    return StreamBuilder(
      stream: bloc.count,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Text('${snapshot.data ?? 0}',
            style: TextStyle(
              fontSize: 16  ,
              fontWeight: FontWeight.w500
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: width * 0.35,
                  height: width * 0.27,
                  child: ImageContainer(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    id: widget.dish.imageId,
                  )
                ),
                Padding(padding: EdgeInsets.only(left: 15)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.dish.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 3)),
                    Text('Calories: ${widget.dish.calories} kcal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 3)),
                    Text('Proteins: ${widget.dish.proteins}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 3)),
                    Text('Fats: ${widget.dish.fats}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 3)),
                    Text('Carbohydrates: ${widget.dish.carbohydrates}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                    )
                  ],
                )
              ],
            )
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(widget.dish.description,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 3)),
           Text('Components: ${widget.dish.components}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: [
              // Flexible(
              //   child: SecondButton(
              //     height: 40,
              //     fontSize: 14,
              //     title: 'Delete',
              //     onPressed: onDelete
              //   )
              // ),
              Container(
                width: width * 0.35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildButton(FontAwesomeIcons.minus, onDec),
                    buildText(),
                    buildButton(FontAwesomeIcons.plus, onInc)
                  ],
                )
              ),
              Padding(padding: EdgeInsets.only(right: 40)),
              StreamBuilder(
                stream: bloc.count.stream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  //final count = snapshot.data ?? 1;
                  return Flexible(
                    child: MainButton(
                      height: 40,
                      fontSize: 14,
                      title: '${widget.dish.salePrice}€ - OK',
                      onPressed: onAdd,
                    )
                  );
                }
              )
            ]
          )
        ],
      ),
    );
  }
}