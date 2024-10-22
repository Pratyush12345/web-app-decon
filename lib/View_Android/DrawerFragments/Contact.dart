import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/mailgun.dart';
import 'package:http/http.dart' as http;
class Contact extends StatefulWidget {
  final BuildContext menuScreenContext;
  Contact({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _Contact createState() => _Contact();
}


class _Contact extends State<Contact> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  bool _showIndicator = false;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: b * 28),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/contact.png', height: h * 231),
                ],
              ),
              Row(children: [
                SvgPicture.asset(
                  'images/location.svg',
                  allowDrawingOutsideViewBox: true,
                ),
                SizedBox(width: b * 11),
                Text(
                  "SVNIT Campus, Surat, Gujarat",
                  style: txtS(dc, 14, FontWeight.w400),
                ),
              ]),
              sh(10),
              Row(children: [
                SvgPicture.asset(
                  'images/message.svg',
                  allowDrawingOutsideViewBox: true,
                ),
                SizedBox(width: b * 11),
                Text(
                  "vysiontechnology@gmail.com",
                  style: txtS(dc, 14, FontWeight.w400),
                ),
              ]),
              sh(49),
              Text(
                "Get In Touch",
                style: txtS(dc, 20, FontWeight.w500),
              ),
              sh(30),
              Container(
                alignment: Alignment.center,
                child: TextField(
                  maxLines: 1,
                  controller: emailController,
                  style: TextStyle(fontSize: b * 14),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Enter E-Mail',
                    hintStyle: TextStyle(fontSize: b * 14),
                  ),
                ),
              ),
              sh(20),
              Container(
                padding: EdgeInsets.fromLTRB(b * 10, 0, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xffbebebe), width: b * 1),
                  borderRadius: BorderRadius.circular(b * 3),
                ),
                child: TextField(
                  controller: messageController,
                  maxLines: null,
                  minLines: 7,
                  style: TextStyle(fontSize: b * 14),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Type your message here....',
                    hintStyle:
                        TextStyle(fontSize: b * 14, color: Color(0xff858585)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              sh(27),
              MaterialButton(
                color: blc,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(b * 6),
                ),
                onPressed: () async{
                 String senderEmail = emailController.text.trim();
                 String message = messageController.text.trim();
                  try{
                   _showIndicator = true;
                   setState(() {}); 
                   String query = senderEmail + "%" + message;
                   http.Response res =  await http.get(Uri.parse('https://us-central1-decon-3545e.cloudfunctions.net/onMailSend?value="$query"'));
                   
                   _showIndicator = false;
                   setState(() {});
                   if(res.statusCode == 200)
                   AppConstant.showSuccessToast(context, "Message sent successfully");
                   else
                   AppConstant.showFailToast(context, "Failed to send message");
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
                  padding: EdgeInsets.symmetric(vertical: h * 11),
                  alignment: Alignment.center,
                  child: _showIndicator ?AppConstant.progressIndicator(): Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: b * 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
  }
}
