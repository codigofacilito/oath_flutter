import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Tables.dart';

class DB{
  String name = "CakeShop";
  int version =1;

  Future<Database>open()async{
    String path = join(await getDatabasesPath(),name);
    return openDatabase(path,version: this.version,onCreate:onCreate);
  }
  
  onCreate(Database database, int version){
    Tables.TABLES.forEach((scrip) async=>await database.execute(scrip));
  }
}