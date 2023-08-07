import 'package:db/Screen/Home/Model/HomeModel.dart';
import 'package:db/Utiles/DBHelper.dart';
import 'package:db/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtStd = TextEditingController();
  TextEditingController txtMobile = TextEditingController();

  HomeModel h1 = Get.arguments;

  @override
  void initState() {
    super.initState();

    if (h1.check == 1) {
      txtName = TextEditingController(
        text: "${h1.name}",
      );
      txtStd = TextEditingController(
        text: "${h1.std}",
      );
      txtMobile = TextEditingController(
        text: "${h1.mobile}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: txtName,
            ),
            TextField(
              controller: txtStd,
            ),
            TextField(
              controller: txtMobile,
            ),
            ElevatedButton(
              onPressed: () async {
                if (h1.check == 0) {
                  HomeModel homeModel = HomeModel(
                    name: txtName.text,
                    mobile: txtMobile.text,
                    std: int.parse(txtStd.text),
                  );
                  DBHelper.dbHelper.insertData(
                    h1: homeModel,
                  );
                  l1 = await DBHelper.dbHelper.readData();
                  setState(() {});
                } else {
                  HomeModel homeModel = HomeModel(
                    name: txtName.text,
                    mobile: txtMobile.text,
                    std: int.parse(txtStd.text),
                    id: h1.id,
                  );

                  print("${homeModel.name} ${homeModel.id}");

                  DBHelper.dbHelper.updateData(
                    h1: homeModel,
                  );
                  l1 = await DBHelper.dbHelper.readData();
                  setState(() {});
                  Get.back();
                }
              },
              child: Text(
                h1.check == 1 ? "Update" : "Add",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
