import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tarea2_2/db.dart';
import 'package:tarea2_2/personas.dart';
import 'package:sqflite/sqflite.dart';


class Controller extends GetxController {
  TextEditingController nombresController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();


  void register(BuildContext context) async {
    String name = nombresController.text;
    String des = descripcionController.text;
    print(name);
    print(des);

    Personas personas = Personas(
      nombres: name,
      descripcion: des,
      foto: "foto.png"
    );

  }


}
