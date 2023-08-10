
import 'package:flutter/material.dart';
import 'package:sqfliteexample/EditEmployee.dart';
import 'package:sqfliteexample/resources/DatabaseHelper.dart';

class ViewEmploy extends StatefulWidget {
  const ViewEmploy({Key? key}) : super(key: key);

  @override
  State<ViewEmploy> createState() => _ViewEmployState();
}

class _ViewEmployState extends State<ViewEmploy> {

   Future<List>? employeedata;


  Future<List> viewemploye() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data = obj.getemploye();
    return data;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      employeedata = viewemploye();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: employeedata,
          builder: (context,snapshots)
          {
            if(snapshots.hasData)
            {
              if(snapshots.data!.length<=0)
              {
                return Center(
                  child: Text("Data Not Available "),
                );
              }
              else
              {
                return ListView.builder(
                  itemCount: snapshots.data!.length,
                  itemBuilder: (context,index)
                  {
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      padding:  EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.black,width: 1.0)
                      ),
                      child: Column(
                        children: [
                          Text("Name : " +snapshots.data![index]["employeename"].toString()),
                          Text("Gender : " +snapshots.data![index]["gender"].toString()),
                          Text("Department : "+snapshots.data![index]["department"].toString()),
                          Text("Rs." + snapshots.data![index]["salary"].toString()),
                          SizedBox(height: 30.0,),
                          Row(
                            children: [
                              Container(
                                child: ElevatedButton(
                                  onPressed: () async{


                                    var id = snapshots.data![index]["employeeid"].toString();
                                    print(id);

                                    DatabaseHelper obj = new DatabaseHelper();
                                    var status = await obj.deleteEmploye(id);
                                    if(status==1)
                                      {
                                        setState(() {
                                          employeedata = viewemploye();
                                        });
                                      }
                                    else
                                      {
                                        var snackbar = SnackBar(
                                          content: Text("Record Not Deleted "),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
                              SizedBox(width: 50.0),
                              Container(
                                child: ElevatedButton(
                                  onPressed: () {

                                    var id = snapshots.data![index]["employeeid"].toString();

                                    Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => EditEmployee(
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
                          )
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
                child: Text("Waiting For Data"),
              );
            }
          },
        ),
      ),
    );
  }
}
