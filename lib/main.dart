import 'package:flutter/material.dart';
import 'package:flutter_db/models/Transactions.dart';
import 'package:flutter_db/providers/transaction_provider.dart';
import 'package:flutter_db/screens/form_screen.dart';
import 'package:flutter_db/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: TabBarView(
          children: [
            HomeScreen(),
            FormScreen(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              text: "รายการธุรกรรม",
            ),
            Tab(
              text: "เพิ่มข้อมูล",
            ),
          ],
        ),
      ),
    );
  }
}
