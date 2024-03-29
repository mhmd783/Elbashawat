import 'package:cafe_el_bashawat/modules/dialoge.dart';
import 'package:cafe_el_bashawat/prov/Prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Menu1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Menu1();
  }
}

class _Menu1 extends State<Menu1> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).refesh();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).screen1(1);
    });
    super.initState();
  }

  Dialoge dialoge = new Dialoge();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<control>(builder: (context, val, child) {
            return MaterialButton(
              onPressed: () {
                dialoge.all_orders(context);
              },
              child: Container(
                child: Stack(
                  children: [
                    Text(
                      "${val.myOrders.length}",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.business_center,
                          color: Colors.black.withOpacity(0.5),
                        )),
                  ],
                ),
              ),
            );
          }),
          Consumer<control>(builder: (context, val, child) {
            return IconButton(
                onPressed: () {
                  connectToServer();
                },
                icon: val.clientmodel == null || !val.clientmodel!.isConnected
                    ? Icon(
                        Icons.wifi_off,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.wifi,
                        color: Colors.green,
                      ));
          })
        ],
      ),
      body: Container(
        alignment: Alignment.topLeft,
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // margin: EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.brown,
                      radius: 30,
                      backgroundImage: AssetImage("images/logo.jpg"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Elbashawat',
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50, left: 20),
                child: Text(
                  'Hi, Guest',
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 30,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: Consumer<control>(builder: (context, val, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: val.type.length,
                    itemBuilder: (context, i) {
                      return Container(
                        height: 40,
                        margin:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                        decoration: BoxDecoration(
                          color: i == val.typen
                              ? Colors.brown
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15.0, // soften the shadow
                              spreadRadius: 2.0, //extend the shadow
                              offset: Offset(
                                2.0, // Move to right 5  horizontally
                                2.0, // Move to bottom 5 Vertically
                              ),
                            )
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            val.changetype(i);
                            Navigator.of(context).pushReplacementNamed("menu1");
                          },
                          child: Text(
                            "${val.type[i]}",
                            style: TextStyle(
                              color:
                                  i == val.typen ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              //////////////////////////////////////////////////////

              /////////////////////////////////////////////////////////
              Consumer<control>(builder: (context, val, child) {
                return AnimationLimiter(
                  child: GridView.builder(
                    padding: EdgeInsets.all(0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 1200
                          ? 4
                          : MediaQuery.of(context).size.width >= 480
                              ? 3
                              : 2,
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true, // Added
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: val.newMenu.length,
                    itemBuilder: (context, i) {
                      return AnimationConfiguration.staggeredGrid(
                        position: i,
                        columnCount: 2,
                        duration: const Duration(seconds: 1),
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                //first stack
                                children: [
                                  Stack(
                                    //scound stack
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 27),
                                        height: 250,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius:
                                                  15.0, // soften the shadow
                                              spreadRadius:
                                                  5.0, //extend the shadow
                                              offset: Offset(
                                                5.0, // Move to right 5  horizontally
                                                5.0, // Move to bottom 5 Vertically
                                              ),
                                            )
                                          ],
                                        ),
                                        padding: EdgeInsets.only(top: 40),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              textAlign: TextAlign.center,
                                              "${val.newMenu[i]['drinks']}",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              '${val.newMenu[i]['price']}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.brown),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage(
                                            "${val.newMenu[i]["image"]}"),
                                      ),
                                    ],
                                  ),
                                  /////////////////////////////icon add prodect
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 15.0, // soften the shadow
                                          spreadRadius: 1.0, //extend the shadow
                                          offset: Offset(
                                            1.0, // Move to right 5  horizontally
                                            1.0, // Move to bottom 5 Vertically
                                          ),
                                        )
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.brown,
                                      child: IconButton(
                                          onPressed: () {
                                            add_num_order(
                                                i, val.newMenu[i]["image"]);
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
////////
              // Consumer<control>(builder: (context, val, child) {
              //   return GridView.builder(
              //     padding: EdgeInsets.all(0),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount:
              //             MediaQuery.of(context).size.width >= 480 ? 3 : 2),
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true, // Added
              //     physics: NeverScrollableScrollPhysics(),
              //     itemCount: val.newMenu.length,
              //     itemBuilder: (context, i) {
              //       // val.menuOpject.menu[i]['type']==val.type[val.typen];
              //       return Padding(
              //         padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              //         child: Stack(
              //           alignment: Alignment.bottomRight,
              //           //first stack
              //           children: [
              //             Stack(
              //               //scound stack
              //               alignment: Alignment.topCenter,
              //               children: [
              //                 Container(
              //                   margin: EdgeInsets.only(top: 27),
              //                   height: 250,
              //                   width: double.infinity,
              //                   decoration: BoxDecoration(
              //                     color: Colors.grey.shade100,
              //                     borderRadius: BorderRadius.circular(20),
              //                     boxShadow: [
              //                       BoxShadow(
              //                         color: Colors.grey,
              //                         blurRadius: 15.0, // soften the shadow
              //                         spreadRadius: 5.0, //extend the shadow
              //                         offset: Offset(
              //                           5.0, // Move to right 5  horizontally
              //                           5.0, // Move to bottom 5 Vertically
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                   padding: EdgeInsets.only(top: 10),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       Text(
              //                         "${val.newMenu[i]['drinks']}",
              //                         style: TextStyle(fontSize: 20),
              //                       ),
              //                       Text(
              //                         '${val.newMenu[i]['price']}',
              //                         style: TextStyle(
              //                             fontSize: 20, color: Colors.brown),
              //                       ),
              //                       SizedBox(
              //                         height: 5,
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 CircleAvatar(
              //                   radius: 40,
              //                   backgroundColor: Colors.white,
              //                   backgroundImage: AssetImage("images/mug.jpg"),
              //                 ),
              //               ],
              //             ),
              //             /////////////////////////////icon add prodect
              //             Container(
              //               margin: EdgeInsets.all(5),
              //               decoration: BoxDecoration(
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.grey,
              //                     blurRadius: 15.0, // soften the shadow
              //                     spreadRadius: 1.0, //extend the shadow
              //                     offset: Offset(
              //                       1.0, // Move to right 5  horizontally
              //                       1.0, // Move to bottom 5 Vertically
              //                     ),
              //                   )
              //                 ],
              //               ),
              //               child: CircleAvatar(
              //                 backgroundColor: Colors.brown,
              //                 child: IconButton(
              //                     onPressed: () {
              //                       add_num_order(i);
              //                     },
              //                     icon: Icon(
              //                       Icons.add,
              //                       color: Colors.white,
              //                     )),
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   );
              // }),
//////////////////

              //
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer<control>(builder: (context, val, child) {
        return val.clientmodel == null || !val.clientmodel!.isConnected
            ? FloatingActionButton(
                onPressed: () {
                  all_orders();
                },
                backgroundColor: Colors.brown,
                elevation: 10,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Consumer<control>(builder: (context, val, child) {
                        return Text(
                          '${val.orderschose.length}',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        );
                      }),
                    )
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.brown,
                    radius: 30,
                    child: Consumer<control>(builder: (context, val, child) {
                      return IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          all_orders();
                        },
                      );
                    }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      all_orders();
                    },
                    backgroundColor: Colors.brown,
                    elevation: 10,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 22),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child:
                              Consumer<control>(builder: (context, val, child) {
                            return Text(
                              '${val.orderschose.length}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Future<void> add_num_order(int i, String image) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          title: CircleAvatar(
            radius: 50,

            backgroundColor: Colors.white,
            //to show image
            backgroundImage: AssetImage("$image"),
          ),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            2.0, // Move to right 5  horizontally
                            2.0, // Move to bottom 5 Vertically
                          ),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.brown,
                      child: IconButton(
                          onPressed: () {
                            val.increaseorder();
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: Text(
                      '${val.numberOrder}',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            2.0, // Move to right 5  horizontally
                            2.0, // Move to bottom 5 Vertically
                          ),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            val.decreaseorder();
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              );
            }),
          ),
          actions: <Widget>[
            Consumer<control>(builder: (context, val, child) {
              return Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        5.0, // Move to right 5  horizontally
                        5.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                ),
                child: MaterialButton(
                  onPressed: () {
                    val.choseorder(i);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "اضافه",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Future<void> all_orders() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          elevation: 10,
          title: Consumer<control>(builder: (context, val, child) {
            return Text("${val.totalPrice}\$");
          }),
          content: Consumer<control>(builder: (context, val, child) {
            return Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 250,
              child: ListView.builder(
                  itemCount: val.orderschose.length,
                  itemBuilder: (context, i) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text("${val.orderschose[i]['drinks']}"),
                        subtitle: Text(
                          "${val.orderschose[i]['numberOrder']}   ${int.parse(val.orderschose[i]['price'])}\$",
                          style: TextStyle(fontSize: 10),
                        ),
                        leading: CircleAvatar(
                          //radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage("${val.orderschose[i]['image']}"),
                        ),
                        trailing: Container(
                          width: 70,
                          child: Row(children: [
                            Container(
                              width: 35,
                              child: IconButton(
                                  onPressed: () {
                                    val.editnumbeorder(i);
                                    edit_order(i, val.orderschose[i]['image']);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.brown,
                                  )),
                            ),
                            Container(
                              width: 35,
                              child: IconButton(
                                  onPressed: () {
                                    val.deletchoseorder(i);
                                  },
                                  icon: Icon(Icons.delete)),
                            )
                          ]),
                        ),
                      ),
                    );
                  }),
            );
          }),
          actions: <Widget>[
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 5  horizontally
                      5.0, // Move to bottom 5 Vertically
                    ),
                  )
                ],
              ),
              child: Consumer<control>(builder: (context, val, child) {
                return MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (val.orderschose.length > 0) {
                      chose_table();
                    } else {
                      errororder(context);
                    }
                  },
                  child: Text(
                    "تاكيد",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Future<void> edit_order(int i, String image) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          title: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("$image"),
          ),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            2.0, // Move to right 5  horizontally
                            2.0, // Move to bottom 5 Vertically
                          ),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.brown,
                      child: IconButton(
                          onPressed: () {
                            val.increaseorder();
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: Text(
                      '${val.numberOrder}',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            2.0, // Move to right 5  horizontally
                            2.0, // Move to bottom 5 Vertically
                          ),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            val.decreaseorder();
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              );
            }),
          ),
          actions: <Widget>[
            Consumer<control>(builder: (context, val, child) {
              return Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        5.0, // Move to right 5  horizontally
                        5.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                ),
                child: MaterialButton(
                  onPressed: () {
                    val.editchoseorder(i);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "تعديل",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Future<void> chose_table() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          title: Text("اختار رقم الطاوله"),
          elevation: 10,
          content: Consumer<control>(builder: (context, val, child) {
            return Container(
              width: 270,
              height: 250,
              child: GridView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: 25,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: val.numberTable == i
                            ? Colors.brown
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 2.0, //extend the shadow
                            offset: Offset(
                              2.0, // Move to right 5  horizontally
                              2.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          val.choseTable(i);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.table_bar),
                            Text(
                              "${i + 1}",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }),
          actions: <Widget>[
            Consumer<control>(builder: (context, val, child) {
              return val.clientmodel == null || !val.clientmodel!.isConnected
                  ? Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 2.0, //extend the shadow
                            offset: Offset(
                              2.0, // Move to right 5  horizontally
                              2.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          connectToServer();
                        },
                        child: Text(
                          "اتصال",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 2.0, //extend the shadow
                            offset: Offset(
                              2.0, // Move to right 5  horizontally
                              2.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (val.numberTable < 26) {
                            val.sendOrdersToServer();
                            Navigator.of(context).pop();
                            checksendorder();
                          } else {
                            errorchosenmberteble();
                          }
                        },
                        child: Text(
                          "ارسال الاوردر",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
            }),
          ],
        );
      },
    );
  }

  errororder(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.withOpacity(0.7),
          elevation: 20,
          content: Text(
            "!!! اضف من المنيو",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  errorchosenmberteble() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.withOpacity(0.7),
          elevation: 20,
          content: Text(
            "!!! اختار رقم الطاوله",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  Future<void> connectToServer() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          title: Text("اتصال بالكاشير"),
          elevation: 10,
          content: Consumer<control>(builder: (context, val, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                val.clientmodel == null || !val.clientmodel!.isConnected
                    ? val.address == null
                        ? Text(
                            "no device found",
                            style: TextStyle(color: Colors.red),
                          )
                        : Card(
                            color: Colors.white,
                            child: ListTile(
                              onTap: () async {
                                await val.clientmodel!.connect();
                                setState(() {});
                                print('con');

                                Navigator.of(context).pop();
                                
                              },
                              title: Text("Desktop"),
                              subtitle: Text('${val.address!.ip}'),
                              leading: Icon(Icons.ads_click),
                            ),
                          )
                    : Text(
                        'connected to ${val.clientmodel!.hostName}',
                        style: TextStyle(color: Colors.green),
                      ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Container(child: Text('${val.test}'),),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            value: val.test.toDouble() / 30,
                            color: Colors.black,
                            strokeWidth: 4,
                          )),
                    ],
                  ),
                )
              ],
            );
          }),
          actions: <Widget>[
            Consumer<control>(builder: (context, val, child) {
              return Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                      offset: Offset(
                        2.0, // Move to right 5  horizontally
                        2.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                ),
                child: MaterialButton(
                  onPressed: () => val.test == 30 || val.test == 0
                      ? val.getIpAddress()
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  checksendorder() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.withOpacity(0.7),
          elevation: 20,
          content: Text(
            "تم الارسال انتظر 15 دقيقه لتجهيزه ",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          duration: Duration(seconds: 5),
        ),
      );
    });
  }
}
