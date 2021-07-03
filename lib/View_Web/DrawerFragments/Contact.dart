import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ContactUs extends StatefulWidget {
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController email = TextEditingController();
  final TextEditingController message = TextEditingController();
  bool isEmail = false;
  bool isMessge = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              sh(80),
              Expanded(
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding:
                          EdgeInsets.fromLTRB(b * 40, h * 0, b * 40, h * 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(h * 10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(
                          left: b * 32, right: b * 17, bottom: h * 55),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/contact.png',
                              height: h * 450, width: b * 450),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'images/location.svg',
                                  allowDrawingOutsideViewBox: true,
                                ),
                                sb(15),
                                Text(
                                  "SVNIT Campus, Surat, Gujarat",
                                  style: txtS(dc, 20, FontWeight.w400),
                                ),
                              ]),
                          sh(28),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'images/message.svg',
                                  allowDrawingOutsideViewBox: true,
                                ),
                                sb(15),
                                Text(
                                  "vysiontechnology@gmail.com",
                                  style: txtS(dc, 20, FontWeight.w400),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding:
                          EdgeInsets.fromLTRB(b * 40, h * 40, b * 40, h * 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(h * 10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(
                          left: b * 17, right: b * 32, bottom: h * 55),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get In Touch",
                            style: txtS(dc, 24, FontWeight.w500),
                          ),
                          sh(40),
                          Row(children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: isEmail ? blc : Colors.transparent,
                                      width: 0.5),
                                  color: Color(0xffe0e0e0),
                                  borderRadius: BorderRadius.circular(h * 10),
                                ),
                                child: TextField(
                                  onTap: () {
                                    setState(() {
                                      isEmail = true;
                                      isMessge = false;
                                    });
                                  },
                                  onSubmitted: (value) {
                                    setState(() {
                                      isEmail = false;
                                    });
                                  },
                                  controller: email,
                                  style: TextStyle(
                                    fontSize: b * 14,
                                    color: dc,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Enter Your Email',
                                    hintStyle: TextStyle(
                                      fontSize: b * 12,
                                      color: Color(0xff858585),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: h * 17, horizontal: b * 10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          sh(33),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: isMessge ? blc : Colors.transparent,
                                    width: 0.5),
                                color: Color(0xffe0e0e0),
                                borderRadius: BorderRadius.circular(h * 10),
                              ),
                              child: TextField(
                                onTap: () {
                                  setState(() {
                                    isEmail = false;
                                    isMessge = true;
                                  });
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    isMessge = false;
                                  });
                                },
                                controller: email,
                                style: TextStyle(
                                  fontSize: b * 16,
                                  color: dc,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Type your message here....',
                                  hintStyle: TextStyle(
                                    fontSize: b * 16,
                                    color: Color(0xff858585),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: h * 17, horizontal: b * 10),
                                  border: InputBorder.none,
                                ),
                                maxLines: 20,
                              ),
                            ),
                          ),
                          sh(64),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                color: blc,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(h * 6),
                                ),
                                onPressed: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: h * 11, horizontal: b * 60),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Send',
                                    style: txtS(wc, 18, FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
