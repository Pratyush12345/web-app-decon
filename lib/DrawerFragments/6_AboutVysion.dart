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

class AboutVysion extends StatefulWidget {
  final BuildContext menuScreenContext;
  AboutVysion({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _AboutVysion createState() => _AboutVysion();
}

const gc = Colors.black;
const tc = Color(0xff263238);

class _AboutVysion extends State<AboutVysion> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        child: Column(children: [
      SizedBox(height: SizeConfig.v * 2.7),
      Text("About Company",
          style: TextStyle(
              fontSize: SizeConfig.b * 5.5, fontWeight: FontWeight.w700)),
      SizedBox(height: SizeConfig.v * 3),
      Container(
        width: SizeConfig.b * 94.14,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.b * 4, vertical: SizeConfig.v * 3),
        decoration: BoxDecoration(
          color: Color(0xff263238),
          borderRadius: BorderRadius.circular(SizeConfig.b * 2),
        ),
        child: Text(
            "Vysion Technology is a Gujarat based technology startup working in trending Domains like IoT, AI and Cloud to Empower Smart cities and industry.Vysion Technology is Incubated by Gujarat government under SSIP initiative. We are team of young, enthusiastic and skilled engineers working to achieve our Vision",
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.b * 4.5,
                fontWeight: FontWeight.w400)),
      ),
      SizedBox(height: SizeConfig.v * 3),
      Text("Vision",
          style: TextStyle(
              fontSize: SizeConfig.b * 5.5, fontWeight: FontWeight.w700)),
      SizedBox(height: SizeConfig.v * 3),
      Container(
        width: SizeConfig.b * 94.14,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.b * 4, vertical: SizeConfig.v * 3),
        decoration: BoxDecoration(
          color: Color(0xff263238),
          borderRadius: BorderRadius.circular(SizeConfig.b * 2),
        ),
        child: Text(
            "Our vision is to empower and develop a country by providing a series of IoT, AI and cloud based smart solutions in different sectors to eradict the bottleneck problems faced by the country.Our products aim to transform and develop smart cities and industry. ",
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.b * 4.5,
                fontWeight: FontWeight.w400)),
      )
    ]));
  }
}
