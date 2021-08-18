import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_db/models/Transactions.dart';
import 'package:flutter_db/providers/transaction_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แอพบัญชี"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              SystemNavigator.pop();
            },
          )
        ],
      ),
      body: Consumer(
        builder: (context, TransactionProvider provider, child) {
          var count = provider.transactions.length;
          if (count <= 0) {
            return Center(
              child: Text(
                "ไม่พบข้อมูล",
                style: TextStyle(fontSize: 35, color: Colors.black),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: count,
                itemBuilder: (context, int index) {
                  Transactions data = provider.transactions[index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.delete_outline_rounded),
                          ),
                          GestureDetector(
                            child: Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(data.amount.toString()),
                        ),
                      ),
                      title: Text(data.title),
                      subtitle:
                          Text(DateFormat("dd/MM/yyyy").format(data.date)),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
