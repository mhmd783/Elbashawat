// import 'package:cafe_el_bashawat/modules/dialoge.dart';
// import 'package:cafe_el_bashawat/prov/Prov.dart';
// import 'package:cafe_el_bashawat/view/printfatora.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class OrdersScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _OrdersScreen();
//   }
// }

// class _OrdersScreen extends State<OrdersScreen> {
//   Dialoge dialoge = new Dialoge();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Consumer<control>(builder: (context, val, child) {
//           return Text("${val.totalpricetable}\$");
//         }),
//         backgroundColor: Colors.white,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 dialoge.dash(context);
//               },
//               icon: Icon(Icons.menu)),
//           //     Consumer<control>(builder: (context, val, child) {
//           //   return Switch(
//           //       activeColor: Colors.green,
//           //       inactiveThumbColor: Colors.black,
//           //       value: val.server.running,
//           //       onChanged: (value) async {
//           //         await val.startOrStopServer();
//           //       });
//           // }),
//         ],
//       ),
//       backgroundColor: Colors.white,
//       body: Consumer<control>(builder: (context, val, child) {
//         return Container(
//           child: Column(children: [
//             Container(
//               color: Colors.white,
//               height: 100,
//               width: double.infinity,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 25,
//                 itemBuilder: (context, i) {
//                   return Container(
//                     height: 40,
//                     margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color:
//                           val.table == i ? Colors.brown : Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(50),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey,
//                           blurRadius: 15.0, // soften the shadow
//                           spreadRadius: 2.0, //extend the shadow
//                           offset: Offset(
//                             2.0, // Move to right 5  horizontally
//                             2.0, // Move to bottom 5 Vertically
//                           ),
//                         )
//                       ],
//                     ),
//                     child: MaterialButton(
//                       onPressed: () {
//                         val.choseTableOrder(i);
//                       },
//                       child: Row(
//                         children: [
//                           Icon(Icons.table_bar),
//                           Text(
//                             "${i + 1}",
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             ////////////////////////////////////////////////\
//             Consumer<control>(builder: (context, val, child) {
//               return Expanded(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width - 30,
//                   //height: 400,
//                   child: ListView.builder(
//                       itemCount: val.showOrders.length,
//                       itemBuilder: (context, i) {
//                         return Card(
//                           elevation: 5,
//                           child: ListTile(
//                             title: Text("${val.showOrders[i].drinks}"),
//                             subtitle: Text(
//                               "${val.showOrders[i].number_order}",
//                               style: TextStyle(fontSize: 10),
//                             ),
//                             leading: CircleAvatar(
//                               //radius: 50,
//                               backgroundColor: Colors.white,
//                               backgroundImage: AssetImage("images/mug.jpg"),
//                             ),
//                             trailing: Text('${val.showOrders[i].price}\$'),
//                           ),
//                         );
//                       }),
//                 ),
//               );
//             }),
//           ]),
//         );
//       }),
//       floatingActionButton: Consumer<control>(builder: (context, val, child) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.brown,
//               child: IconButton(
//                 onPressed: () {
//                   if (val.table < 26 && val.showOrders.length > 0) {
//                     //end_order();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => fatora(
//                             table: val.table + 1,totale: val.totalpricetable, orders: val.showOrders),
//                       ),
//                     );
//                   } else {
//                     errorchosenmberteble();
//                   }
//                 },
//                 icon: Icon(Icons.print, color: Colors.white),
//               ),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Container(
//               height: 60,
//               width: 60,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20), color: Colors.brown),
//               child: TextButton(
//                 onPressed: () {
//                   if (val.table < 26) {
//                     end_order();
//                   } else {
//                     errorchosenmberteble();
//                   }
//                 },
//                 child: Text(
//                   "انهاء",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   Future<void> end_order() async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           scrollable: true,
//           backgroundColor: Colors.white,
//           title: Consumer<control>(builder: (context, val, child) {
//             return CircleAvatar(
//               backgroundColor: Colors.brown,
//               radius: 22,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.table_bar,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "${val.table + 1}",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//           elevation: 10,
//           content: Text(
//             textAlign: TextAlign.center,
//             'تاكيد انهاء الحساب',
//             style: TextStyle(fontSize: 20, color: Colors.red),
//           ),
//           actions: <Widget>[
//             Consumer<control>(builder: (context, val, child) {
//               return Container(
//                 height: 50,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.brown,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 15.0, // soften the shadow
//                       spreadRadius: 5.0, //extend the shadow
//                       offset: Offset(
//                         5.0, // Move to right 5  horizontally
//                         5.0, // Move to bottom 5 Vertically
//                       ),
//                     )
//                   ],
//                 ),
//                 child: MaterialButton(
//                   onPressed: () {
//                     val.endOrderTable();
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                     "انهاء",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ],
//         );
//       },
//     );
//   }

//   errorchosenmberteble() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           elevation: 20,
//           content: Text(
//             "!!! اختار رقم طاوله بها طلبات",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.black, fontSize: 18),
//           ),
//           duration: Duration(seconds: 3),
//         ),
//       );
//     });
//   }
// }
