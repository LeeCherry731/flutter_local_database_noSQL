import 'package:flutter/foundation.dart';
import 'package:flutter_db/database/transaction_db.dart';
import 'package:flutter_db/models/Transactions.dart';

class TransactionProvider with ChangeNotifier {
  // ชื่อรายการ , จำนวนเงิน , วันที่
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void addTransaction(Transactions statement) async {
    // var db = await TransactionDB(dbName: "transactions.db").openDatabase();
    // print(db);
    var db = TransactionDB(dbName: "transactions.db");

    // บันทึกช้อมูล
    await db.InsertData(statement);
    // ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    // transactions.insert(0, statement);
    // แจ้งเตือน Consumer
    notifyListeners();
  }

  void initData() async {
    var db = TransactionDB(dbName: "transactions.db");
    transactions = await db.loadAllData();
    notifyListeners();
  }
}
