import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cafe_el_bashawat/client/client.dart';
import 'package:cafe_el_bashawat/dbhive/db.dart';
import 'package:cafe_el_bashawat/prov/menudata.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

class control extends ChangeNotifier {
  Menu menuOpject = new Menu();
  int typen = 0;
  List newMenu = [];
  late Box myUsers = Hive.box<Users>("users");
  late Box myOrders = Hive.box<Orders>("orders");
  late Box myAllOrders = Hive.box<AllOrders>("allorders");
  int screennumber = 1;
  screen1(int i) {
    screennumber = i;
    notifyListeners();
  }

  screen2(int i) {
    screennumber = i;
    notifyListeners();
  }

  screen3(int i) {
    screennumber = i;
    notifyListeners();
  }

  screen4(int i) {
    screennumber = i;
    notifyListeners();
  }

  List type = [
    "كوفي",
    "فريشات",
    "ركن السوري",
    "وافل",
    "ديزرت",
    "شيشه",
    "مشروبات ساخنه",
    "سموزي",
    "تلاجه",
    "مشروبات ايس",
    "فروت",
    "سوبر كريب",
    "كريب فراخ",
    "كريب لحوم",
    "كريب جبن",
    "اضافات"
  ];

  refesh() {
    changetype(typen);
    notifyListeners();
  }

  changetype(int i) {
    typen = i;
    newMenu.clear();
    for (int i = 0; i < menuOpject.menu.length; i++) {
      if (menuOpject.menu[i]['type'] == type[typen]) {
        newMenu.add(menuOpject.menu[i]);
      }
    }
    notifyListeners();
  }

  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController title = new TextEditingController();
  adduser() {
    myUsers.put("user",Users(
        name: name.text,
        phone: phone.text,
        title: title.text,
        send: "0",
        date: Jiffy.now().format(pattern: 'yyyy/MM/dd').toString(),
        time: Jiffy.parse('${DateTime.now()}').Hm.toString()));

    notifyListeners();
  }

  List users = [];
  getUsers() {
    users = [];
    for (int i = 0; i < myUsers.length; i++) {
      users.add(myUsers.getAt(myUsers.length - i - 1));
    }
    notifyListeners();
  }

  //orders///////////////////////////////////////////////
  int numberOrder = 1;
  List orderschose = [];
  int totalPrice = 0;
  increaseorder() {
    numberOrder = numberOrder + 1;
    notifyListeners();
  }

  decreaseorder() {
    if (numberOrder > 1) {
      numberOrder = numberOrder - 1;
    }
    notifyListeners();
  }

  choseorder(int i) {
    totalPrice = totalPrice + (int.parse(newMenu[i]['price']) * numberOrder);
    orderschose.add({
      "drinks": newMenu[i]['drinks'],
      "price": '${(int.parse(newMenu[i]['price']) * numberOrder).toString()}',
      "old_price": newMenu[i]['price'],
      "image": newMenu[i]['image'],
      "numberOrder": numberOrder.toString(),
      "numberTable": "26",
    });
    numberOrder = 1;
    notifyListeners();
  }

  editnumbeorder(int i) {
    numberOrder = int.parse(orderschose[i]['numberOrder']);
    notifyListeners();
  }

  editchoseorder(int i) {
    orderschose[i]['numberOrder'] = numberOrder.toString();
    orderschose[i]['price'] =
        (int.parse(orderschose[i]['old_price']) * numberOrder).toString();
    totalPrice = 0;
    for (int y = 0; y < orderschose.length; y++) {
      totalPrice = totalPrice + int.parse(orderschose[y]['price']);
    }
    numberOrder = 1;
    notifyListeners();
  }

  deletchoseorder(int i) {
    orderschose.removeAt(i);
    totalPrice = 0;

    for (int y = 0; y < orderschose.length; y++) {
      totalPrice = totalPrice + int.parse(orderschose[y]['price']);
    }
    notifyListeners();
  }

  int numberTable = 26;
  choseTable(int i) {
    //i start 0 to  stor i in hive you shoud add 1 to i to start 1 to 25
    numberTable = i;
    for (int y = 0; y < orderschose.length; y++) {
      orderschose[y]['numberTable'] = (numberTable + 1).toString();
    }
    notifyListeners();
  }

  addorderstodb() {
    for (int i = 0; i < orderschose.length; i++) {
      myOrders.add(Orders(
          id: myOrders.length.toString(),
          name: '',
          phone: '',
          title: '',
          table_number: orderschose[i]['numberTable'],
          drinks: orderschose[i]['drinks'],
          price: orderschose[i]['price'],
          image: orderschose[i]['image'],
          old_price: orderschose[i]['old_price'],
          number_order: orderschose[i]['numberOrder'],
          pay: '0',
          send: '',
          date: Jiffy.now().format(pattern: 'yyyy/MM/dd').toString(),
          time: Jiffy.parse('${DateTime.now()}').Hm.toString()));

      myAllOrders.add(AllOrders(
          id: myOrders.length.toString(),
          name: '',
          phone: '',
          title: '',
          table_number: orderschose[i]['numberTable'],
          drinks: orderschose[i]['drinks'],
          price: orderschose[i]['price'],
          image: orderschose[i]['image'],
          old_price: orderschose[i]['old_price'],
          number_order: orderschose[i]['numberOrder'],
          pay: '0',
          send: '',
          date: Jiffy.now().format(pattern: 'yyyy/MM/dd').toString(),
          time: Jiffy.parse('${DateTime.now()}').Hm.toString()));
    }

    orderschose = [];
    totalPrice = 0;
    numberTable = 26;
    notifyListeners();
  }

  ///show orders in screen orders //////////////////////
  int table = 26;
  choseTableOrder(int i) {
    table = i;
    ordersTable();
    notifyListeners();
  }

  List showOrders = [];
  int totalpricetable = 0;
  ordersTable() {
    showOrders = [];
    totalpricetable = 0;
    for (int i = 0; i < myOrders.length; i++) {
      if (myOrders.getAt(i).table_number == (table + 1).toString() &&
          myOrders.getAt(i).pay == '0') {
        showOrders.add(myOrders.getAt(i));
        totalpricetable = totalpricetable + int.parse(myOrders.getAt(i).price);
      }
    }
    notifyListeners();
  }

  endOrderTable() async {
    int i = 0;

    while (i < myOrders.length) {
      if (myOrders.getAt(i).table_number == (table + 1).toString()) {
        await myOrders.deleteAt(i);
        i = i - 1;
      }
      i++;
    }

    ordersTable();

    notifyListeners();
  }

  ///client//////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  ///client////////////////////////////////////////////////
  clie? clientmodel;
  List<String> logs = [];
  int port = 8080;
  Stream<NetworkAddress>? stream;
  NetworkAddress? address;
  int n = 0;
  Map? datasend;

  StreamSubscription? _subscription;
  int test = 0;
  getIpAddress() async {
    test = 0;
    address = null;
    stream = NetworkAnalyzer.discover("192.168.1", port);
    //final ipAddress = InternetAddress('192.168.1.3');
    _subscription = stream!.listen((NetworkAddress networkAddress) {
      test += 1;
      if (networkAddress.exists) {
        address = networkAddress;
        clientmodel = clie(
            hostName: "${address!.ip}",
            onData: onData,
            onError: onError,
            port: port);
        test = 0;
        _subscription!.cancel();
      }
      //_subscription!.cancel();
      test >= 30 ? _subscription!.cancel() : null;
      updatetest(test);
      print(stream);
    });

    notifyListeners();
  }

  updatetest(int test1) {
    test = test1;
    notifyListeners();
  }

  void sendMessage(String message) {
    clientmodel!.write(message);
    notifyListeners();
  }

  onData(Uint8List data) {
    final message = String.fromCharCodes(data);
    logs.add(message);
    print(message);

    notifyListeners();
  }

  onError(dynamic error) {
    debugPrint("Error: $error");
    notifyListeners();
  }

  //send data//////////////////////////////////////////////////////////////////
  sendOrdersToServer() async {
    
    if (!orderschose.isEmpty) {
      await clientmodel!.connect();
      for (int i = 0; i < orderschose.length; i++) {
        if (clientmodel!.isConnected == true) {
          
          datasend = {
            'name': myUsers.getAt(0).name,
            'phone': myUsers.getAt(0).phone,
            'title': myUsers.getAt(0).title,
            'table_number': orderschose[i]['numberTable'],
            'drinks': orderschose[i]["drinks"],
            'price': orderschose[i]["price"],
            'image': orderschose[i]["image"],
            'old_price': orderschose[i]["old_price"],
            'number_order': orderschose[i]['numberOrder']
          };

          print("ok$i");

          final encodedString =
              await base64.encode(utf8.encode(jsonEncode(datasend)));

          await Future.delayed(
              Duration(milliseconds: 500)); // تأخير 1 ثانية هنا

          sendMessage(encodedString);
          print(encodedString);
          //////////////////code clear
        } else {
          address = null;
        }
      }
    }
    
    addorderstodb();
    
    notifyListeners();
  }

  
}
