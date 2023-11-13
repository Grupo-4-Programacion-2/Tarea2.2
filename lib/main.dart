import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tarea2_2/personas.dart';
import 'package:tarea2_2/db.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:tarea2_2/controller.dart';
import 'package:sqflite/sqflite.dart';

void main() {

  return runApp(const SignaturePadApp());
}


///Renders the SignaturePad widget.
class SignaturePadApp extends StatelessWidget {
  const SignaturePadApp({super.key});



  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SfSignaturePad Demo',
      debugShowCheckedModeBanner: false,
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  const _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  Controller controller = Get.put(Controller());
  @override
  void initState() {
    super.initState();
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
    await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);

    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    print(ui.ImageByteFormat.png);


    //Ese es el metodo que hay que utiizar para insertar la imagen a Firebase
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Stack(
                  children: [
                    Image.memory(bytes!.buffer.asUint8List())
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(25),
                  child: Container(
                      decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: SfSignaturePad(
                          key: signatureGlobalKey,
                          backgroundColor: Colors.white,
                          strokeColor: Colors.black,
                          minimumStrokeWidth: 1.0,
                          maximumStrokeWidth: 4.0))),
              SizedBox(height: 0.1),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                TextButton(
                  onPressed: _handleClearButtonPressed,
                  child: Text(
                      'LIMPIAR',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                )
              ]),
              _textFieldName(),
              _textFieldDescription(),
              _buttonRegister(context),
              _buttonList()
            ]
        ));
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: controller.nombresController,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.white
        ),
        decoration: InputDecoration(
            hintText: 'Nombres',
            prefixIcon: Icon(Icons.person)
        ),
      ),
    );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller.descripcionController,
        keyboardType: TextInputType.text,
        style: TextStyle(
            color: Colors.white
        ),
        decoration: InputDecoration(
            hintText: 'Descripcion',
            prefixIcon: Icon(Icons.description)
        ),
      ),
    );
  }

  Widget _buttonRegister(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
          onPressed: () =>  controller.register(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
          ),
          child: Text(
            'REGISTRAR',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _buttonList() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 0.2),
      child: ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'LISTA',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

}