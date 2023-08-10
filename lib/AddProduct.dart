import 'package:flutter/material.dart';
import 'package:sqfliteexample/resources/DatabaseHelper.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();


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
                      Text("Add Product",style: TextStyle(
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
                          Text("Price"),
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
                          controller: _price,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        children: [
                          Text("quantity"),
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
                          controller: _quantity,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50.0,
                            width: 150.0,
                            child: ElevatedButton(
                              onPressed: ()  async{

                                var nm = _name.text.toString();
                                var qty = _quantity.text.toString();
                                var price = _price.text.toString();

                                DatabaseHelper obj = new DatabaseHelper();
                                var id = await obj.insertProduct(nm,qty,price);

                                //print();
                                var snackbar = SnackBar(
                                  content: Text("Record Inserted At : "+id.toString()),
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
