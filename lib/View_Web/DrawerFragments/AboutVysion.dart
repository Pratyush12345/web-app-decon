import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutVysion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Container(
      height: SizeConfig.screenHeight,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'images/group.png',
                  height: h * 550,
                ),
              ],
            ),
          ),
          Positioned(
            top: h * 100,
            left: b * 60,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Company',
                    style: GoogleFonts.montserrat(
                        color: blc,
                        fontSize: h * 40,
                        fontWeight: FontWeight.w600),
                  ),
                  sh(15),
                  SizedBox(
                    width: b * 650,
                    child: Text(
                      'Vysion Technology is a technical startup, currently incubated by the Department of Science and Technology-Supported Technology Business Incubator(ASHINE) under the SSIP Initiative. The team comprises of young and skilled enthusiasts from IITs, NITs, and IIITs innovating tirelessly in different domains like IoT, Artificial Intelligence, Mobile and Web Development, Robotics, Embedded Systems, Cloud, and so on. We tend to deliver smart solutions in the sectors where the Nation is lagging to compete in the world. We help to build better infrastructure for technology-driven industries. ',
                      style: GoogleFonts.montserrat(
                          color: dc,
                          fontSize: h * 20,
                          height: 2,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: h * 90,
            left: b * 60,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vision',
                    style: GoogleFonts.montserrat(
                        color: blc,
                        fontSize: h * 40,
                        fontWeight: FontWeight.w600),
                  ),
                  sh(21),
                  SizedBox(
                    width: b * 650,
                    child: Text(
                      'Our vision is to empower the nation by providing smart solutions for complex problems that defy India in becoming the Global Leader. We envision eradicating the bottlenecks in the Technological sector and help the Nation in accomplishing superior infrastructure for better sustainability of future demands. Our vision is to innovate in the sectors that demand immediate attention and tirelessly strive until we come up with smarter solutions.',
                      style: GoogleFonts.montserrat(
                          color: dc,
                          fontSize: h * 20,
                          height: 2,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
