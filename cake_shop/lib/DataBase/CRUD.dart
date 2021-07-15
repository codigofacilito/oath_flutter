import 'package:cake_shop/DataBase/DB.dart';
import 'package:sqflite/sqflite.dart';

abstract class CRUD{
  final String table;
  const CRUD(this.table);

  Future<Database>get database async{
    return await DB().open();
  }

  query(String query,{List<dynamic> arguments = const []})async{
    final db = await database;
    return await db.rawQuery(query,arguments);
  }

  update(Map<String, dynamic>data)async{
    final db = await database;
    return await db.update(table, data,where: "id = ?",whereArgs: [data["id"]]);
  }

  insert(Map<String, dynamic>data)async{
    final db = await database;
    return await db.insert(table, data);
  }

  delete(int id)async{
    final db = await database;
    return await db.delete(table,where: "id = ?",whereArgs: [id])>0;
  }
}