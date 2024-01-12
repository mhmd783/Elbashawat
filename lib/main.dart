import 'package:cafe_el_bashawat/dbhive/db.dart';
import 'package:cafe_el_bashawat/prov/Prov.dart';
import 'package:cafe_el_bashawat/view/menu1.dart';
import 'package:cafe_el_bashawat/view/orders.dart';
import 'package:cafe_el_bashawat/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(UsersAdapter());
  Hive.registerAdapter(OrdersAdapter());
  Hive.registerAdapter(AllOrdersAdapter());

  await Hive.openBox<Users>('users');
  await Hive.openBox<Orders>('orders');
  await Hive.openBox<AllOrders>('allorders');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late Box myUsers = Hive.box<Users>("users");
    return ChangeNotifierProvider(
      create: (context) {
        return control();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "signup": (context) => Signup(),
          "menu1": (context) => Menu1(),
          
        },
        home:myUsers.length==0? Signup():Menu1(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: null,
    );
  }
}


