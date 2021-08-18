import 'package:flutter/material.dart';
import 'package:flutter_db/main.dart';
import 'package:flutter_db/models/Transactions.dart';
import 'package:flutter_db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  // const FormScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  // controller
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('แบบฟอร์มบันทึกข้อมูล'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                  controller: titleController,
                  decoration: new InputDecoration(labelText: "ชื่อรายการ"),
                  autofocus: true,
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "กรุณาป้อนชื่อรายการ";
                    }
                    return null;
                  }),
              TextFormField(
                  controller: amountController,
                  decoration: new InputDecoration(labelText: "จำนวนเงิน"),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "กรุณาป้อนจำนวนเงิน";
                    }
                    if (double.parse(value) <= 0) {
                      return "กรุณาป้อนตัวเลขมากกว่า 0";
                    }
                    return null;
                  }),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var title = titleController.text;
                    var amount = amountController.text;

                    Transactions statement = new Transactions(
                        title: title,
                        amount: double.parse(amount),
                        date: DateTime.now());

                    var provider = Provider.of<TransactionProvider>(context,
                        listen: false);

                    provider.addTransaction(statement);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return MyHomePage();
                            }));
                  }
                },
                child: Text('เพิ่มข้อมูล'),
              )
            ]),
          ),
        ));
  }
}
