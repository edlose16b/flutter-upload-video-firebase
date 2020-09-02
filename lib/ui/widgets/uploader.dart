import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retofamosos/config/notifications.dart';
import 'package:retofamosos/constants.dart';
import 'package:retofamosos/main.dart';
import 'package:retofamosos/data/services/firebase_storage.dart';
import 'package:retofamosos/data/services/notifications.dart';
import 'package:retofamosos/ui/widgets/video_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploaderWidget extends StatefulWidget {
  UploaderWidget({Key key}) : super(key: key);

  @override
  _UploaderWidgetState createState() => _UploaderWidgetState();
}

class _UploaderWidgetState extends State<UploaderWidget> {
  File file;

  StorageUploadTask task;

  bool busyLoader = false;
  bool busyPicker = false;

  int uniqueId;
  StorageMetadata dataVideo;

  void pickVideo() async {
    if (busyPicker) return;
    busyPicker = true;
    File picked = await ImagePicker.pickVideo(source: ImageSource.gallery);
    busyPicker = false;

    if (picked == null) return;
    setState(() {
      file = picked;
    });
  }

  void uploadVideo() async {
    if (busyLoader) return;
    busyLoader = true;

    uniqueId = DateTime.now().millisecondsSinceEpoch;

    FireBaseStorageService fireBaseStorageService = FireBaseStorageService();

    setState(() {
      task = fireBaseStorageService.uploadFile(uniqueId.toString(), file);
    });

    task.events.listen((event) async {
      moveProgressOnNotificationBar(event.snapshot);

      if (task.isComplete && task.isSuccessful) {
        final metaData = await event.snapshot.ref.getMetadata();

        setState(() {
          dataVideo = metaData;
        });
      }
    });

    busyLoader = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _renderHeaderSectionPerStatus(),
        SizedBox(height: 20),
        file != null
            ? VideoPlayerWidget(
                origin: VideoOrigin.file,
                urlFile: file.path,
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget _renderHeaderSectionPerStatus() {
    // Cuando el video aún no se ha seleccionado
    if (file == null && task == null)
      return Container(
        child: InkWell(
          child: FlatButton(
            onPressed: () => this.pickVideo(),
            child: Text('Seleccionar video'),
          ),
        ),
      );

    // Cuando el video se ha seleccionado
    if (file != null && task == null)
      return Container(
        child: InkWell(
          child: FlatButton(
            onPressed: () => this.uploadVideo(),
            child: Text('Subir video'),
          ),
        ),
      );

    // Cuando el video se está subiendo
    if (dataVideo == null) return renderProgress();

    // Cuando el video ha finalizado
    if (dataVideo != null)
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Súbido con éxito',
                style: TextStyle(color: Colors.green),
              ),
            ),
            Center(
              child: Text(
                'a las ${DateTime.fromMillisecondsSinceEpoch(dataVideo.creationTimeMillis).toLocal()}',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );

    return SizedBox.shrink();
  }

  Widget renderProgress() {
    if (task == null) return SizedBox.shrink();

    return StreamBuilder(
      stream: task.events,
      builder: (BuildContext context, snapshot) {
        print('Progres moviendose desde StreamBuilder');
        Widget subtitle;

        if (snapshot.hasData) {
          final StorageTaskEvent event = snapshot.data;

          final StorageTaskSnapshot snap = event.snapshot;

          subtitle = Text('${_bytesTransferred(snap)} KB');
        } else {
          subtitle = const Text('Starting...');
        }

        return Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Subiendo ...',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle,
              ],
            ),
          ),
        );
      },
    );
  }

  moveProgressOnNotificationBar(StorageTaskSnapshot snapshot) async {
    LocalNotificationsService localNotificationsServices =
        LocalNotificationsService();

    if (task.isComplete && task.isSuccessful) {
      localNotificationsServices.createNotification(
        uniqueId,
        'Video $uniqueId.mp4 cargado',
        'El video ha cargado satisfactoriamente',
      );
      return;
    }

    localNotificationsServices.createProgresiveNotification(
      uniqueId,
      'Subiendo video',
      'Cargando ...',
      _percentTransferred(snapshot),
    );
  }

  int _percentTransferred(StorageTaskSnapshot snapshot) {
    return (snapshot.bytesTransferred / snapshot.totalByteCount * 100).toInt();
  }

  String _bytesTransferred(StorageTaskSnapshot snapshot) {
    double res = snapshot.bytesTransferred / 1024.0;
    double res2 = snapshot.totalByteCount / 1024.0;

    return '${res.truncate().toString()}/${res2.truncate().toString()}';
  }
}
