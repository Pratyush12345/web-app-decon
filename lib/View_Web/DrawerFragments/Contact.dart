import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/mailgun.dart';


class ContactUs extends StatefulWidget {
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  bool isEmail = false;
  bool isMessge = false;

  String username, password;
  SmtpServer _server;
  bool _showIndicator = false;
  @override
  void initState() {
    username = "postmaster@sandboxed5e570b949e4df09241aaf88212196e.mailgun.org";
    password = "fa9f20140afb28824a971d71df326540-c4d287b4-942687a1";
    _server = mailgun(username, password);
    print("_server =========${_server.allowInsecure}");
    super.initState();
  }

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
                                  controller: emailController,
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
                                controller: messageController,
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
                                onPressed: () async{
                 String senderEmail = emailController.text.trim();
                 String message = messageController.text.trim();
                 final composedMessage = new Message()
                  .. from = new Address(senderEmail, "Pratyush Gupta")
                  .. recipients.add("pratyushgupta190@gmail.com")
                  .. subject = "Decon Feedback ${new DateTime.now()}"
                  .. text = message;
                  try{
                   _showIndicator = true;
                   setState(() {}); 
                   SendReport _sendReport = await send(composedMessage, _server );
                   _showIndicator = false;
                   setState(() {});
                   AppConstant.showSuccessToast(context, "Message sent successfully");
                  }
                  catch(e){
                    _showIndicator = false;
                    setState(() {});
                    AppConstant.showFailToast(context, "Failed to send message");
                    print(e.toString());
                    for (var p in e.problems) {
                      print('Problem: ${p.code}: ${p.msg}');
                    }
                  }

                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: h * 11, horizontal: b * 60),
                                  alignment: Alignment.center,
                                  child: _showIndicator ?AppConstant.progressIndicator(): Text(
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
