import 'package:flutter/material.dart';
import 'package:sqfliteexample/resources/DatabaseHelper.dart';

class AddEmploy extends StatefulWidget {
  const AddEmploy({Key? key}) : super(key: key);

  @override
  State<AddEmploy> createState() => _AddEmployState();
}

class _AddEmployState extends State<AddEmploy> {

  TextEditingController _name = TextEditingController();
  TextEditingController _salary = TextEditingController();

  var gender="f";
  var department="sale";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.shade100,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("Add Employ",style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),),
                      Row(
                        children: [
                          Text("Name"),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0, 2),
                              blurRadius: 5,
                              spreadRadius: 0,
                            ),
                          ],
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: _name,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        children: [
                          Text("Salary"),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0, 2),
                              blurRadius: 5,
                              spreadRadius: 0,
                            ),
                          ],
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: _salary,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),

                      //  Gender
                      Row(
                        children: [
                          Text("Gender"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            groupValue: gender,
                            value: "M",
                            onChanged:(val){
                              setState(() {
                                gender=val!;
                              });
                            },
                          ),
                          Text("Male"),
                          Radio(
                            groupValue: gender,
                            value: "F",
                            onChanged: (val){
                              setState(() {
                                gender=val!;
                              });
                            },
                          ),
                          Text("Female")
                        ],
                      ),

                      // Department
                      Row(
                        children: [
                          Text("Department")
                        ],
                      ),
                      Row(
                        children: [
                          DropdownButton(
                            value: department,
                            onChanged: (val)
                            {
                              setState(() {
                                department=val!;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text("Sale"),
                                value: "sale",
                              ),
                              DropdownMenuItem(
                                child: Text("Purchase"),
                                value: "pr",
                              ),
                              DropdownMenuItem(
                                child: Text("Profit"),
                                value: "pt",
                              ),
                              DropdownMenuItem(
                                child: Text("pf"),
                                value: "pf",
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),

                      Container(
                        height: 50.0,
                        width: 150.0,
                        child: ElevatedButton(
                          onPressed: () async{

                            var nm = _name.text.toString();
                            var sal = _salary.text.toString();

                            DatabaseHelper obj = new DatabaseHelper();
                            var id = await obj.insertEmployee(nm,sal,gender,department);
                            
                            var snackbar = SnackBar(
                              content: Text("Employe Datastore :"+id.toString()),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: Text("ADD ➕",style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
