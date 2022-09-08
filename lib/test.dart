import 'dart:html';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';


class Time extends StatefulWidget {
  @override
  State<Time> createState() => TimeState();
}

class TimeState extends State<Time> {
  String? uploadedPhotoUrl;


PickedFile? pickedFile;
chooseImage() async {
pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

  setState(() {
    
  });
}

uploadImageToStorage() async {

Reference _reference = FirebaseStorage.instance.ref()
        .child('images/${Path.basename(pickedFile!.path)}');
    await _reference
        .putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/*'),
    )
        .whenComplete(() async {
      await _reference.getDownloadURL().then((value) {
        uploadedPhotoUrl = value;
      });
    });

}

Uint8List webImage= Uint8List(8);

Future<void> IMGP()async{

  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if(picker !=null){

    var f = await image!.readAsBytes();
    setState(() {
      webImage= f;
    });
  }
}


Future<void> IMGU()async{


var uploadTask = FirebaseStorage.instance.ref().child('AAAA');

await uploadTask.putData(webImage).whenComplete(() async {
      await uploadTask.getDownloadURL().then((value) {
        uploadedPhotoUrl = value;
      });
    });

}





  @override
  Widget build(BuildContext context) => Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
    
                       Container(
                        
                        width: 100,
                        height:     150,
                        child: Center(child: Image.memory(webImage, fit: BoxFit.cover,),),
                      ),
                      Text('$uploadedPhotoUrl'),
            Row(
              children: [
                //UNOS NORMALNA SLIKA
                Column(
                  children: [
                    SizedBox(height: 30,),
                    ElevatedButton(onPressed: (){IMGP();}, child: const Text('SELECT')),
                    SizedBox(height: 32,),
                    ElevatedButton(onPressed: (){IMGU();}, child: const Text('UPLOAD')),
                  ],
                ),
                SizedBox(width: 20,),

                //UNOS 8 BIT
                Column(
                  children: [
                    SizedBox(height: 30,),
                    ElevatedButton(onPressed: (){IMGP();}, child: const Text('SELECT')),
                    SizedBox(height: 32,),
                    ElevatedButton(onPressed: (){IMGU();}, child: const Text('UPLOAD')),
                                      ],
                                    ),
              ],
            ),
          ]),
      ));
}
