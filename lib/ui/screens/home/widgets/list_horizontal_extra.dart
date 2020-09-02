import 'package:flutter/material.dart';
import 'package:retofamosos/data/models/famous.dart';

class ListHorizontalExtra extends StatelessWidget {
  const ListHorizontalExtra({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          FamousWidget(famous: famousListTest[0]),
          FamousWidget(famous: famousListTest[1]),
          FamousWidget(famous: famousListTest[2]),
          FamousWidget(famous: famousListTest[3]),
        ],
      ),
    );
  }
}

class FamousWidget extends StatelessWidget {
  const FamousWidget({Key key, @required this.famous}) : super(key: key);
  final Famous famous;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 180,
        height: 260,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Color(0xff303542).withOpacity(0.2),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
                height: 180,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    famous.image,
                    fit: BoxFit.cover,
                  ),
                )),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(famous.type),
                      Spacer(),
                      Image.network(
                        'https://www.countryflags.io/${famous.countryCode}/flat/16.png',
                        width: 18,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: Text(
                      famous.name,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
