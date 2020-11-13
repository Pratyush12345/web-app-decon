import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
class SplashCarousel extends StatefulWidget {
  @override
  _SplashCarouselState createState() => _SplashCarouselState();
}

class _SplashCarouselState extends State<SplashCarousel> {
  List<String> _listf = [ 'assets/gurucool.flr','assets/gurucool.flr','assets/detect.flr', 'assets/inform.flr',
  'assets/process.flr',];

    
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: ScrollPhysics(),
        itemCount: _listf.length,
        itemBuilder: (context, index){
          return FlareLoading(  
          name: _listf[index],
          onSuccess: (_) {
          },
          onError: (_, __) {},
          startAnimation: 'animation',
          //until: () => Future.delayed(Duration(seconds: 4)),
                );
          
        },
      ),
    );
  }
}