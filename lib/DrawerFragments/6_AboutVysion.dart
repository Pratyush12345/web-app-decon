import 'package:Decon/Authentication/EnterOtp.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.v * 2.7),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 20 / 360),
            child: Text(
              "About Company",
              style: TextStyle(
                fontSize: SizeConfig.b * 5.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 10 / 640),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 20 / 360),
            child: Text(
              "Vysion Technology is a Gujarat based technology startup working in trending Domains like IoT, AI and Cloud to Empower Smart cities and industry.\n\nVysion Technology is Incubated by Gujarat government under SSIP initiative. We are team of young, enthusiastic and skilled engineers working to achieve our Vision",
              style: TextStyle(
                color: Color(0xff5C6266),
                fontSize: SizeConfig.b * 4.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.v * 3),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 20 / 360),
            child: Text(
              "Vision",
              style: TextStyle(
                fontSize: SizeConfig.b * 5.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 10 / 640),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 20 / 360),
            child: Text(
              "Our vision is to empower and develop a country by providing a series of IoT, AI and cloud based smart solutions in different sectors to eradict the bottleneck problems faced by the country. Our products aim to transform and develop smart cities and industry.",
              style: TextStyle(
                color: Color(0xff5C6266),
                fontSize: SizeConfig.b * 4.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 60 / 640),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(0xff263238),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 10 / 640),
                  Text(
                    "SVNIT Campus, Surat, Gujarat",
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 10 / 360,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Container(
                height: SizeConfig.screenHeight * 50 / 640,
                width: 0.5,
                color: Color(0xff263238),
              ),
              Column(
                children: [
                  Icon(
                    Icons.email,
                    color: Color(0xff263238),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 10 / 640),
                  Text(
                    "vysiontechnology@gmail.com",
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 10 / 360,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
