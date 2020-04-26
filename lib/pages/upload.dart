import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File file;

  handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 675, maxWidth: 960);

    setState(() {
      this.file = file;
    });
  }

  handleImageFromGallery() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      this.file = file;
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) => SimpleDialog(
              title: Text('Criar um post'),
              children: <Widget>[
                SimpleDialogOption(
                  child: Text('Foto da câmera'),
                  onPressed: handleTakePhoto,
                ),
                SimpleDialogOption(
                  child: Text('Foto da galeria'),
                  onPressed: handleImageFromGallery,
                ),
                SimpleDialogOption(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }

  Container buildSplashScreen() {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            "assets/images/upload.svg",
            height: 260.0,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: () => selectImage(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text('Selecione a imagem', style: TextStyle(color: Colors.white, fontSize: 16.0)),
              color: Colors.deepOrangeAccent,
            ),
          ),
        ],
      ),
    );
  }

  buildUploadForm() {
    return Container(child: Text('FOI'));
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? buildSplashScreen() : buildUploadForm();
  }
}
