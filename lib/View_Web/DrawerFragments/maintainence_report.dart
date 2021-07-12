import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MaintainenceReport extends StatefulWidget {
  const MaintainenceReport({ Key key }) : super(key: key);

  @override
  _MaintainenceReportState createState() => _MaintainenceReportState();
}

class _MaintainenceReportState extends State<MaintainenceReport> {

  static ValueKey key = ValueKey('key_0');
  String iframLink;
  @override
    void initState() {
        super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ChangeClient>(
        builder: (context, model, child){ 
        iframLink = '''<html>
                      <body>
                        <iframe height="100%" width="100%" src="${model.clientDetailModel.maintainenceSheetURL}" frameborder="0">
                        </iframe>
                        
                      </body>
                    </html>'''; 
     
        return EasyWebView(
          isHtml: false,
          src: Uri.dataFromString(iframLink, mimeType: 'text/html').toString(),
          isMarkdown: false,
          convertToWidgets: false,
          webAllowFullScreen: false,
          widgetsTextSelectable: false,
          onLoaded: (){
            print("Key loaded");
          },
          key: key,

        );
        } 
      )
    );
  }
}