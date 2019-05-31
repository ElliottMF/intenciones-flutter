import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intenciones',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Intenciones'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('sendSms');
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(widget.title),
        
        
      ),

      body: Center(
        child: Column(

          


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

CircleAvatar(
          backgroundColor: Colors.white,
          child:    Image.asset('assets/logo.png'),
          radius: 90,
        ), 
         //espacio
      SizedBox(height: 10,),
      ButtonTheme(
         minWidth: double.minPositive,  //ancho del boton
       
        height: 50,
        child: MaterialButton(
          onPressed: () => launch("tel:"),
          color: Colors.orange,
          child: Text(
            'Telefono',
            style: TextStyle(color:Colors.white),
          ),
        ),
      ),
        SizedBox(height: 10,),
      ButtonTheme(
         minWidth: double.minPositive,  //ancho del boton
        height: 50,
        child: MaterialButton(
          onPressed: () => sendSms(),
          color: Colors.orange,
          child: Text(
            'Mensaje',
            style: TextStyle(color:Colors.white),
          ),
        ),
      ),
       SizedBox(height: 10,),
      ButtonTheme(
        minWidth: double.minPositive,  //ancho del boton
        height: 50,
        child: MaterialButton(
          onPressed: () => sendEmail("15030005@itcelaya.edu.mx", "Asunto", "Mensaje"),
          color: Colors.orange,
          child: Text(
            'Correo',
            style: TextStyle(color:Colors.white),
          ),
        ),
      ),
      SizedBox(height: 10,),
       ButtonTheme(
        minWidth: double.minPositive,  //ancho del boton
        height: 50,
        child: MaterialButton(
          onPressed: () => sendWhats("+524171237423"),
          color: Colors.orange,
          child: Text(
            'Whatsapp',
            style: TextStyle(color:Colors.white),
          ),
        ),
      ),
      SizedBox(height: 10,),
       ButtonTheme(
         minWidth: double.minPositive,  //ancho del boton
        height: 50,
        child: MaterialButton(
          onPressed: () => openMap(20.5422825, -100.8177758),
          color: Colors.orange,
          child: Text(
            'Google maps',
            style: TextStyle(color:Colors.white),
          ),
        ),
      ),
      SizedBox(height: 10,),
       ButtonTheme(
         minWidth: double.minPositive,  //ancho del boton
        height: 50,
        
        
        
        child: MaterialButton(
          
          onPressed: () => openExplorer(),
          color: Colors.orange,
          child: Text(
            'Navegador',
            style: TextStyle(color:Colors.white),
          ),
        ),
      ),
      SizedBox(height: 10,),
       ButtonTheme(
        minWidth: double.minPositive,  //ancho del boton
        height: 50,
        child: MaterialButton(
          onPressed: () => camara(),
          color: Colors.orange,
          child: Text(
            'Camara',
            style: TextStyle(color:Colors.white),
          ),
        ),
      ),
         SizedBox(height: 10,),
       ButtonTheme(
         minWidth: double.minPositive,  //ancho del boton
        height: 50,
        child: MaterialButton(
          onPressed: () => galeria(),
          color: Colors.orange,
          child: Text(
            'Galeria',
            style: TextStyle(color:Colors.white),
          ),
        ),
      ),
      ],
        ),
      ),
    );
  }

  Future<Null> sendSms() async {
    print("SendSMS");
    try {
      final String result = await platform.invokeMethod(
          'send', <String, dynamic>{
        "phone": "+524171042921",
        "msg": "hola mundo"
      });
      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
 

  sendEmail(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }


  sendWhats(String phone) async {
    String whats =
        'whatsapp://send?phone=$phone&text=hola mundo';
    if (await canLaunch(whats)) {
      await launch(whats);
    } else {
      throw 'No se pudo abrir la app';
    }
  }


  openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'No se pudo abrir Google Maps';
    }
  }

  openExplorer() async {
    String googleUrl =
        'https://www.google.com/search?q=itc&oq=itc';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'No se pudo abrir el navegador';
    }
  }

  camara() async {
    print('Camára');
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }
  galeria() async {
    print('Galeria');
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }


}
