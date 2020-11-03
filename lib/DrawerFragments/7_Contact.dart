import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double b;
  static double v;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    b = screenWidth / 100;
    v = screenHeight / 100;
  }
}

class Contact extends StatefulWidget {
  final BuildContext menuScreenContext;
  Contact({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _Contact createState() => _Contact();
}

const gc = Colors.black;
const tc = Color(0xff263238);

class _Contact extends State<Contact> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
          child: Container(
          child: Column(children: [
        SizedBox(height: SizeConfig.v * 6),
        Row(children: [
          SizedBox(width: SizeConfig.b * 7),
          Icon(Icons.mail),
          SizedBox(width: SizeConfig.b * 2),
          Text("vysiontechnology@gmail.com",
              style: TextStyle(fontSize: SizeConfig.b * 4.3))
        ]),
        SizedBox(height: SizeConfig.v * 4),
        Row(children: [
          SizedBox(width: SizeConfig.b * 7),
          Icon(Icons.map),
          SizedBox(width: SizeConfig.b * 2),
          Expanded(
              child: Text(
                  "Estate building, SVNIT Campus, Ichhanath circle, Athwa Lines, Surat, Gujarat",
                  style: TextStyle(fontSize: SizeConfig.b * 4.3)))
        ]),
        SizedBox(height: SizeConfig.v * 6),
        Container(
            padding: EdgeInsets.fromLTRB(SizeConfig.b * 5.09,
                SizeConfig.v * 2.142, SizeConfig.b * 5.09, SizeConfig.v * 2.86),
            decoration: BoxDecoration(
              color: Color(0xff263238),
              borderRadius: BorderRadius.circular(SizeConfig.b * 2.55),
            ),
            height: SizeConfig.v * 38,
            width: SizeConfig.b * 94,
            child: Column(
              children: [
                Row(
                  children: [
                    Text("E-Mail",
                        style: TextStyle(
                            fontSize: SizeConfig.b * 4.2, color: Colors.white)),
                    Spacer(),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(SizeConfig.b * 5.09, 0, 0, 0),
                      width: SizeConfig.b * 67.43,
                      decoration: BoxDecoration(
                          color: Color(0xffDEE0E0),
                          borderRadius: BorderRadius.circular(SizeConfig.b * 1)),
                      child: TextField(
                        maxLines: 1,
                        style: TextStyle(fontSize: SizeConfig.b * 4.3),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Enter E-Mail',
                          hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.v * 4),
                Expanded(
                    child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.fromLTRB(SizeConfig.b * 5.09, 0, 0, 0),
                  decoration: BoxDecoration(
                      color: Color(0xffDEE0E0),
                      borderRadius: BorderRadius.circular(SizeConfig.b * 1)),
                  child: TextField(
                    maxLines: null,
                    style: TextStyle(fontSize: SizeConfig.b * 4.3),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Query',
                      hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                      border: InputBorder.none,
                    ),
                  ),
                )),
              ],
            )),
        SizedBox(height: SizeConfig.v * 7),
        SizedBox(
            child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: null,
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.b * 15.3,
                        vertical: SizeConfig.v * 1.8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeConfig.b * 6.7),
                      color: Color(0xff00A3FF),
                    ),
                    child: Text('SEND',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.b * 4.2,
                            fontWeight: FontWeight.w400)))))
      ])),
    );
  }
}
