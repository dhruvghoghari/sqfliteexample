import 'package:flutter/material.dart';
import 'package:sqfliteexample/AddEmploy.dart';
import 'package:sqfliteexample/AddProduct.dart';
import 'package:sqfliteexample/ViewEmploy.dart';
import 'package:sqfliteexample/ViewProduct.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var index = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SqfliteExample"),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text("Add Product"),
                onTap: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                  );
                },
                trailing: const Icon(Icons.add),
              ),
              ListTile(
                title: const Text("View Product"),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewProduct()),
                  );
                },
                trailing: const Icon(Icons.add),
              ),
              ListTile(
                title: const Text("Add Employ"),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEmploy()),
                  );
                },
                trailing: const Icon(Icons.add),
              ),
              ListTile(
                title: const Text("View Employ"),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewEmploy()),
                  );
                },
                trailing: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
