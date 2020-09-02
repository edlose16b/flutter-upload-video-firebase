import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:retofamosos/ui/screens/home/widgets/list_horizontal_extra.dart';
import 'package:retofamosos/ui/widgets/uploader.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Container(
          child: Image.asset(
            'assets/logo.png',
            width: 120,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Center(
              child: Text(
                'Bienvenido a mi prueba',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            SizedBox(height: 30),
            Center(child: UploaderWidget()),
            SizedBox(height: 50),
            Text(
              'Famosos',
              style: Theme.of(context).textTheme.headline1,
            ),
            ListHorizontalExtra(),
          ],
        ),
      ),
    );
  }
}
