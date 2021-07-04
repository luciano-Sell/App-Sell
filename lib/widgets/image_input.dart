import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {

  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

  class _ImageInputState extends State<ImageInput>{
File _storedImage;

_takePicture() async {
  final ImagePicker _picker = ImagePicker();
  PickedFile imageFile = await _picker.getImage(
  source: ImageSource.camera,
  maxWidth: 600,
  );
  
  if(imageFile == null) return;

  setState((){
    _storedImage = File(imageFile.path);
  });
  
  final appDir = await syspaths.getApplicationDocumentsDirectory();
  String fileName = path.basename(_storedImage.path);
  final savedImage = await _storedImage.copy(
    '${appDir.path}/$fileName',
  );
  widget.onSelectImage(savedImage);
}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.black54),
          ),
          alignment: Alignment.center,          
          child: _storedImage != null ?
          Image.file(
            _storedImage,
            width: double.infinity,
            fit: BoxFit.cover,
            )
          : Text('Sem produtos'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(          
          icon: Icon(Icons.camera_alt_outlined),
          label: Text(''),
          style: ElevatedButton.styleFrom( primary: Theme.of(context).primaryColor ),
          //textColor: Theme.of(context).primaryColor,
          onPressed: _takePicture, 
          )
        )
      ],
    );
  }
}