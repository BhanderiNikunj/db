import 'package:db/Screen/Home/Model/HomeModel.dart';
import 'package:db/Utiles/DBHelper.dart';
import 'package:db/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    DBHelper.dbHelper.checkDB();

    read();
  }

  Future<void> read() async {
    l1 = await DBHelper.dbHelper.readData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: l1.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text("${l1[index]['name']}"),
                        IconButton(
                          onPressed: () {
                            HomeModel h1 = HomeModel(
                              std: l1[index]['std'],
                              name: l1[index]['name'],
                              mobile: l1[index]['mobile'],
                              id: index + 1,
                              check: 1,
                            );

                            Get.toNamed(
                              '/addData',
                              arguments: h1,
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            HomeModel h1 = HomeModel(
                              id: l1[index]['id'],
                            );
                            DBHelper.dbHelper.deleteData(
                              h1: h1,
                            );
                            l1 = await DBHelper.dbHelper.readData();
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.delete,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            HomeModel h1 = HomeModel(
              check: 0,
            );
            Get.toNamed(
              '/addData',
              arguments: h1,
            );
          },
        ),
      ),
    );
  }
}
