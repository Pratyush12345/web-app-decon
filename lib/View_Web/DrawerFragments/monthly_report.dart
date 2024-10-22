import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Web/Dialogs/please_wait_dialog.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';

class MonthlyReport extends StatefulWidget {
  const MonthlyReport({ Key key }) : super(key: key);

  @override
  _MonthlyReportState createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> {

  static ValueKey key = ValueKey('key_0');
  String iframLink;
  Future showPleaseWaitDialog(BuildContext context) {
    return showAnimatedDialog(
        barrierDismissible: true,
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        
        context: context,
        builder: (context) {
          return PleaseWait();
        });
  }
  callDialogBox() async{
  await Future.delayed(Duration(milliseconds: 50));
  showPleaseWaitDialog(HomePageVM.instance.scaffoldKey.currentContext);
  }
  @override
    void initState() {
      //callDialogBox();
        super.initState();
    }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ChangeSeries>(
        builder: (context, model, child){
          String url;
        if(HomePageVM.instance.getSeriesCode == "S0"){
          url = (GlobalVar.seriesMap[HomePageVM.instance.getSeriesCode].model as S0DeviceSettingModel)?.sheetURL??"";
        }
        else if(HomePageVM.instance.getSeriesCode == "S1"){
         url = (GlobalVar.seriesMap[HomePageVM.instance.getSeriesCode].model as S1DeviceSettingModel)?.sheetURL??"";
        }
        
          iframLink = '''<html>
                      <body>
                        <iframe height="100%" width="100%" src="$url" frameborder="1">
                        </iframe>
                        
                      </body>
                    </html>'''; 
      
        return Stack(
          children: [
            EasyWebView(
              //isHtml: false,
              src: Uri.dataFromString(iframLink, mimeType: 'text/html').toString(),
              //isMarkdown: false,
              //convertToWidgets: false,
              webAllowFullScreen: false,
              //widgetsTextSelectable: false,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              // onLoaded: (){
              //   // if(Navigator.of(HomePageVM.instance.scaffoldKey.currentContext).canPop()){
              //   //   Navigator.of(HomePageVM.instance.scaffoldKey.currentContext).pop();
              //   // }
              //   print("Key loaded");
              // },
              key: key,

            ),
          ],
        );
        }
      ), 
    );
  }
}