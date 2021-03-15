import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ShowMedia extends StatefulWidget {
  final String url;
  final String type;
  final List<Messages> allMessages;
  ShowMedia({
    @required this.url,
    @required this.type,
    @required this.allMessages,
  });
  @override
  _ShowMediaState createState() => _ShowMediaState();
}

class _ShowMediaState extends State<ShowMedia> {
  PageController scrollController;
  List<Messages> _allMessages=[];
  int currentpage, previouspage;
  double _scale = 1.0 , _previousscale =1.0;

  void dispose() {
    print("in dispose");
    
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    
    widget.allMessages.forEach((element) { 
      _allMessages.add(element);
    });
    _allMessages.removeWhere((element) {
      if (element.type == "Text" || element.type == null)
        return true;
      else
        return false;
    });
    currentpage = _allMessages.indexWhere((element) => element.url==widget.url);
    previouspage = currentpage;
    scrollController = new PageController(initialPage:currentpage);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media"),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0,8.0,24.0,8.0),
              child: Text("${currentpage+1}/${_allMessages.length}"),
            ),
          )
        ],
      ),
      body: PageView.builder(
           
          onPageChanged: (number) {
            
            print("--------------");
            print(number);
            print(_allMessages[number].type);
            print("--------------");

            
            
              setState(() {
              currentpage = number;   
              previouspage= currentpage;
              });
            
            
          },
        
          physics: new BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          itemCount: _allMessages.length,
          itemBuilder: (contex, index) {
            return Center(
                child:GestureDetector(
                          onScaleStart: (ScaleStartDetails details){
                           setState(() {
                             _previousscale = _scale;
                           });
                          },
                          onScaleUpdate: (ScaleUpdateDetails details){
                            setState(() {
                            _scale = _previousscale * details.scale;  
                            });
                          },
                          onScaleEnd: (ScaleEndDetails details){
                            setState(() {
                            _previousscale = 1.0;
                            _scale = 1.0;  
                            });
                          },
                          child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 16.0),
                          child: Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                            child: FadeInImage(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.contain,
                              image: NetworkImage(_allMessages[index].url),
                              placeholder: AssetImage('assets/blankimage.jpg'),
                            ),
                          ),
                        ),
                    )
                    );
          }),
    );
  }
}
