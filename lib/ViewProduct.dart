import 'package:flutter/material.dart';
import 'package:sqfliteexample/AddProduct.dart';
import 'package:sqfliteexample/EditProduct.dart';
import 'package:sqfliteexample/resources/DatabaseHelper.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({Key? key}) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {


  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  Future<List>? allproducts;

  Future<List> viewdata() async
  {
    DatabaseHelper obj =new DatabaseHelper();
    var data = obj.getallproducts();
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allproducts = viewdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: allproducts,
          builder: (context,snapshots)
          {
            if(snapshots.hasData)
              {
                if(snapshots.data!.length<=0)
                  {
                    return Center(
                      child: Text("No Data"),
                    );
                  }
                else
                  {
                    return ListView.builder(
                      itemCount: snapshots.data!.length,
                      itemBuilder: (context,index)
                      {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10.0),
                          padding:  EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.red.shade200,width: 2.0)
                          ),
                          child: Column(
                            children: [
                              Text(snapshots.data![index]["productname"].toString()),
                              Text(snapshots.data![index]["qty"].toString()),
                              Text("Rs." + snapshots.data![index]["price"].toString()),
                              Row(
                                children: [
                                  Container(
                                    height: 35.0,
                                    width: 100.0,
                                    child: ElevatedButton(
                                      onPressed: ()  async{

                                        var id = snapshots.data![index]["productid"].toString();


                                        DatabaseHelper obj = new DatabaseHelper();
                                        var status =  await obj.deleteProduct(id);
                                        if(status==1)
                                          {
                                            setState(() {
                                              allproducts = viewdata();
                                            });
                                          }
                                        else
                                          {
                                            print("Record not deleted");
                                          }
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      ),
                                      child: Text("Delete ",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),),
                                    ),
                                  ),
                                  SizedBox(width: 50.0,),
                                  Container(
                                    height: 35.0,
                                    width: 100.0,
                                    child: ElevatedButton(
                                      onPressed: ()
                                      {

                                        var id = snapshots.data![index]["productid"].toString();


                                        Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => EditProduct(
                                          updateid: id,
                                        ))
                                        );
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                      ),
                                      child: Text("Edit ",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
              }
            else
              {
                return Center(
                  child: Text("Loading..."),
                );
              }
          },
        ),
      ),
    );
  }
}
