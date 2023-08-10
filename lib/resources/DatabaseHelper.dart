import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper
{

  Database? db;

  //Database Create

  Future<Database> create_db() async
  {
      if(db!=null)
        {
          //Database Already Craeted
          return db!;
        }
      else
        {
          //we have to create DB
          var dir = await getApplicationDocumentsDirectory();
          var path = join(dir.path,"school_db");
          var db = await openDatabase(path,version: 1,onCreate: create_table);
          return db!;
        }
  }

  create_table(Database db,int version) async
  {
    //table create
    db.execute("create table product (productid integer primary key autoincrement,productname text,qty integer,price double)");
    db.execute("create table employee (employeeid integer primary key autoincrement,employeename text,salary integer,gender text,department text)");
    print("Table Created");
  }

  Future<int> insertProduct(nm,qty,price) async
  {
    //Database Create
    var db = await create_db();
    var id = await db.rawInsert("insert into product (productname,qty,price) values (?,?,?)",[nm,qty,price]);
    return id;
  }

  Future<int> insertEmployee(nm,sal,gender,department) async
  {
    var db = await create_db();
    var id = await db.rawInsert("insert into employee (employeename,salary,gender,department) values (?,?,?,?)",[nm,sal,gender,department]);
    return id;
  }

  Future<List> getallproducts() async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from product");
    return data.toList();
  }

  Future<List> getemploye() async
  {
    var db = await create_db();
    var alldata = await db.rawQuery("select * from employee");
    return alldata.toList();
  }

  Future<int> deleteProduct(id) async
  {
    var db = await create_db();
    var status = await db.rawDelete("delete from product where productid=?",[id]);
    return status;
  }

  Future<int> deleteEmploye(id) async
  {
    var db = await create_db();
    var status = await db.rawDelete("delete from employee where employeeid=?",[id]);
    return status;
  }
  
  Future<List> getsingleproduct(id) async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from product where productid=?",[id]);
    return data.toList();
  }


  Future<int> updateproduct(nm,qty,price,id) async
  {
    var db = await create_db();
    var status = await db.rawUpdate("update product set productname=?,qty=?,price=? where productid=?",[nm,qty,price,id]);
    return status;
  }

  Future<List> getsingleemployee(id) async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from employee where employeeid=?",[id]);
    return data.toList();

  }

  Future<int> updateemployee(nm,sal,gender,department,id) async
  {
    var db = await create_db();
    var status = await db.rawUpdate("update employee set employeename=?,salary=?,gender=?,department=? where employeeid=?",[nm,sal,gender,department,id]);
    return status;
  }

}