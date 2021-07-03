// import 'package:Decon/Controller/Utils/sizeConfig.dart';
// import 'package:circular_check_box/circular_check_box.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:stock_market/ViewModels/add_block_data_viwmodel.dart';
// import 'package:stock_market/utils/Colors.dart';
// import 'package:stock_market/utils/sizeConfig.dart';
// class AddBlockData extends StatefulWidget {
//   @override
//   _AddBlockDataState createState() => _AddBlockDataState();
// }

// class _AddBlockDataState extends State<AddBlockData> {

//   Container con(String value) {
//     return Container(
//       alignment: Alignment.center,
//       height: SizeConfig.screenHeight * 23 / 640,
//       width: SizeConfig.screenWidth * 109 / 360,
//       color: Colors.blue,
//       child: Text(
//         value??"",
//         style: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w400,
//           fontSize: SizeConfig.screenWidth * 14 / 360,
//         ),
//       ),
//     );
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: col1,
//         leading: InkWell(
//             child: Icon(
//               MdiIcons.keyboardBackspace,
//               color: Color(0xffc4c4c4),
//             ),
//             onTap: () {
              
//               Navigator.of(context).pop();
//             }),
//         title: Transform(
//           transform:
//               Matrix4.translationValues(-SizeConfig.screenWidth * 0.06, 0, 0),
//           child: Text(
//             "Add Block Data",
//             style: TextStyle(
//               color: Color(0xffc4c4c4),
//               fontWeight: FontWeight.w500,
//               fontSize: SizeConfig.screenWidth * 14 / 360,
//             ),
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize:
//               Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 50 / 640),
//           child: Column(children: [
//             Container(
//               height: SizeConfig.screenHeight * 26 / 640,
//               width: SizeConfig.screenWidth * 316 / 360,
//               decoration: BoxDecoration(
//                 color: Color(0xffF6F6F6),
//                 borderRadius: BorderRadius.circular(
//                   SizeConfig.screenWidth * 17 / 360,
//                 ),
//               ),
//               child: Row(children: [
//                 SizedBox(
//                   width: SizeConfig.screenWidth * 16 / 360,
//                 ),
//                 Container(
//                   width: SizeConfig.screenWidth * 270 / 360,
//                   height: SizeConfig.screenHeight * 26 / 640,
//                   child: TextField(
//                     onChanged: (value){
                     
//                     },
//                     textInputAction: TextInputAction.search,
//                     keyboardType: TextInputType.text,
//                     maxLines: 1,
//                     style: TextStyle(
//                       fontSize: SizeConfig.screenWidth * 12 / 360,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Search',
//                       isDense: true,
//                       hintStyle: TextStyle(
//                         fontSize: SizeConfig.screenWidth * 0.0333,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   Icons.search,
//                   color: Color(0xffc4c4c4),
//                 ),
//               ]),
//             ),
//             SizedBox(
//               height: SizeConfig.screenHeight * 16 / 640,
//             ),
//           ]),
//         ),
//       ),
//       body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           SizedBox(
//             height: SizeConfig.screenHeight * 27 / 640,
//           ),
//           ConstrainedBox(
//             constraints: BoxConstraints(
//       maxHeight: SizeConfig.screenHeight * 420 / 640,
//             ),
//             child: ListView.builder(
//         physics: BouncingScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: AddBlockDataVM.instance.stockParametersList.length,
//         itemBuilder: (BuildContext ctxt, int index) {
//           return Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: SizeConfig.screenWidth * 24 / 360,
//                 ),
//                 height: SizeConfig.screenHeight * 50 / 640,
//                 child: Row(
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${AddBlockDataVM.instance.stockParametersList[index]}",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w400,
//                             fontSize: SizeConfig.screenWidth * 14 / 360,
//                           ),
//                         ),
//                         SizedBox(
//                           height: SizeConfig.screenHeight * 3 / 640,
//                         ),
//                       ],
//                     ),
//                     Spacer(),
//                     Theme(
//                       data: ThemeData(
//                         unselectedWidgetColor: Colors.white,
//                       ),
//                       child: Transform.scale(
//                         scale: 0.8,
//                         child: CircularCheckBox(
//                           //strokewidth changed to 1 in internal file
//                           inactiveColor: Colors.white,
//                           activeColor: Colors.white,
//                           disabledColor: Colors.white,
//                           value: AddBlockDataVM.instance.stockParametersList[index].isselected,
//                           onChanged: (value){
//                             setState(() {
                                
//                             });
                           
//                           },
//                           materialTapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                           checkColor: col1,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 height: SizeConfig.screenHeight * 0.3 / 640,
//               ),
//             ],
//           );
//         }),
//           ),
//           SizedBox(
//             height: SizeConfig.screenHeight * 15 / 640,
//           ),
//           InkWell(
//             onTap: (){
//              Navigator.of(context).pop();
//              },
//             child: Container(
//       alignment: Alignment.center,
//       height: SizeConfig.screenHeight * 35 / 640,
//       width: SizeConfig.screenWidth * 320 / 360,
//       decoration: BoxDecoration(
//         color: col1,
//         borderRadius: BorderRadius.circular(
//           SizeConfig.screenWidth * 5 / 360,
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   con( "${stockmap[0]}"),
//                                   con( "${stockmap[1]}"),
//                                   con( "${stockmap[2]}"),
//                                 ]),
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 con( "${stockmap[3]}"),
//                                 con( "${stockmap[4]}"),
//                                 con( "${stockmap[5]}"),
//                               ]),
//         ],
//       )
//             ),
//           ),
//         ]),
//     );
//   }
// }