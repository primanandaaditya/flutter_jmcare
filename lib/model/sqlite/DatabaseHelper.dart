import 'package:jmcare/model/sqlite/entity/Epolis.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String nama_db = 'database.db';
  String create_table_epolis = 'CREATE TABLE epolis(id INTEGER PRIMARY KEY, agreement_no TEXT, filepath TEXT, create_date TEXT)';
  String tabel_epolis = 'epolis';

  DatabaseHelper._createInstance();

  void _createDb(Database db, int newVersion) async {
    await db.execute(create_table_epolis);
  }

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + nama_db;
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  Future<List<Map<String, dynamic>>> getEpolis() async {
    Database db = await this.database;
    var result = await db.query(tabel_epolis, orderBy: 'create_date ASC');
    return result;
  }

  Future<List<Epolis>> allEpolis() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tabel_epolis);
    return List.generate(maps.length, (i) {
      return Epolis(
          id: maps[i]['id'],
          agreement_no: maps[i]['agreement_no'],
          filepath: maps[i]['filepath'],
          create_date: maps[i]['create_date']
      );
    });
  }

  Future<int> insertEpolis(Epolis epolis) async {
    Database db = await this.database;
    var result = await db.insert(tabel_epolis, epolis.toMap());
    debugPrint('epolis tersimpan');
    return result;
  }

  Future<int?> selectEpolis(String agreement_no) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tabel_epolis WHERE agreement_no = $agreement_no');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<String> getFilepath(String agreement_no) async {
    //get semua data epolis yang tersimpan di sqlite
    var x = await allEpolis();
    //filter row sesuai agreement no
    var y = x.where((e) => e.agreement_no == agreement_no);
    //jika ada row yang match
    //return field filepath
    if (y.isNotEmpty){
      var z = y.first;
      return z.filepath!;
    }else{
      return "";
    }
  }

}
