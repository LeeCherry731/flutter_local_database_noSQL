import 'dart:ffi';
import 'dart:io';

import 'package:flutter_db/models/Transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  // บริการเกี่ยวกับฐานข้อมูล
  String dbName; //เก็บชื่อฐานข้อมูล

  // ถ้ายังไม่ถูกสร้าง => สร้าง
  // ถ้าสร้างไว้แล้ว => เปิด
  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    // หาตำแหน่งที่จะเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    // create database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  // บันทึกข้อมูล
  Future<int> InsertData(Transactions statement) async {
    // ฐานข้อมูล => Store
    var db = await this.openDatabase();
    var store = await intMapStoreFactory.store("expense");

    // json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String(),
    });
    await db.close();
    return keyID;
  }

  double? convertObjectToDouble(dynamic ob) {
    var result = double.tryParse(ob);
    return result;
  }

  // ดึงข้อมูล
  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = await intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List<Transactions> transactionList = [];

    for (var record in snapshot) {
      transactionList.add(Transactions(
          title: record["title"].toString(),
          amount: double.parse(record["amount"].toString()),
          date: DateTime.parse(record["date"].toString())));
    }

    return transactionList;
  }
}
