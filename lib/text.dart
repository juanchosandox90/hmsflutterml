import 'package:flutter/material.dart';
import 'package:huawei_ml/helpers/text_helpers.dart';
import 'package:huawei_ml/permissions/permission_client.dart';
import 'package:huawei_ml/text/ml_text_client.dart';
import 'package:huawei_ml/text/ml_text_settings.dart';
import 'package:huawei_ml/text/model/ml_text.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognition extends StatefulWidget {
  _TextRecognition createState() => _TextRecognition();
}

class _TextRecognition extends State<TextRecognition> {
  static const String routeName = "TextRecognition";

  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();

  MlTextSettings _mlTextSettings;
  String _recognitionResult = "El resultado sera mostrado aqui.";

  @override
  void initState() {
    _mlTextSettings = new MlTextSettings();
    _checkPermissions();
    super.initState();
  }

  void _checkPermissions() async {
    if (await MlPermissionClient.checkCameraPermission()) {
      print("Permisos Concedidos");
    } else {
      await MlPermissionClient.requestCameraPermission();
    }
  }

  Future<String> getImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: imageSource);
    return pickedFile.path;
  }

  void _startRecognition() async {
    _mlTextSettings.language = MlTextLanguage.Spanish;
    try {
      final MlText mlText = await MlTextClient.analyzeRemotely(_mlTextSettings);
      setState(() {
        _recognitionResult = mlText.stringValue;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void _showImagePickingOptions() async {
    scafoldKey.currentState.showBottomSheet((context) => Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  child: Text("Usar la Camara",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    final String path = await getImage(ImageSource.camera);
                    _mlTextSettings.path = path;
                    _startRecognition();
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  child: Text("Escoger de la Galeria",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    final String path = await getImage(ImageSource.gallery);
                    _mlTextSettings.path = path;
                    _startRecognition();
                  },
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scafoldKey,
        appBar: AppBar(
          title: Text("Reconocimiento de Texto",
              style: TextStyle(fontWeight: FontWeight.bold)),
          titleSpacing: 0,
          backgroundColor: Colors.red[900],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      width: 0.5,
                      color: Colors.black.withOpacity(0.5),
                      style: BorderStyle.solid),
                ),
                child: Text(_recognitionResult),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: RaisedButton(
                color: Colors.red[900],
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Iniciar Análisis'),
                onPressed: _showImagePickingOptions,
              ),
            )
          ],
        ),
      ),
    );
  }
}
