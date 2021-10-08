
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasdriver/DataHandler/appData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../configMap.dart';
import 'homeTabPage.dart';

class EarningTabPage extends StatelessWidget {
  static const String idScreen = "earning";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: primary,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, HomeTabPage.idScreen);
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            color: textcolor,
            size: 50,
          ),
        ),
      ),
      body: Container(
        color: bordercolor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 32.0,
              ),
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 6.0,
                          spreadRadius: 6.0,
                          color: Colors.grey[400].withOpacity(.25))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                       AppLocalizations.of(context).earnigs,
                      style: TextStyle(
                          color: org,
                          fontSize: 32,
                          fontFamily: "segoe",
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      " ${Provider.of<AppData>(context, listen: false).earnings}\SDG",
                       style: TextStyle(
                          color: textcolor,
                          fontSize: 32,
                          fontFamily: "segoe",
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.44,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                       color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 6.0,
                              spreadRadius: 6.0,
                              color: Colors.grey[400].withOpacity(.25))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                           AppLocalizations.of(context).saascoin,
                          style: TextStyle(
                              color: green,
                              fontSize: 24,
                              fontFamily: "segoe",
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${Provider.of<AppData>(context, listen: false).balc}"+" coins"
                          //  "\$${Provider.of<AppData>(context, listen: false).earnings}"
                          ,
                          style: TextStyle(
                              color: textcolor,
                              fontSize: 24,
                              fontFamily: "segoe",
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 6.0,
                              spreadRadius: 6.0,
                              color: Colors.grey[400].withOpacity(.25))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                        AppLocalizations.of(context).kilomitars,
                          style: TextStyle(
                              color: red,
                              fontSize: 24,
                              fontFamily: "segoe",
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${Provider.of<AppData>(context, listen: false).killometer}"+" SDG"
                          //  "\$${Provider.of<AppData>(context, listen: false).earnings}"
                          ,
                          style: TextStyle(
                              color: textcolor,
                              fontSize: 24,
                              fontFamily: "segoe",
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );

    //  Column(
    //   children: [
    //     Container(
    //       color: Colors.black87,
    //       width: double.infinity,
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(vertical: 70),
    //         child: Column(
    //           children: [
    //             Text(
    //               'Total Earnings',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             Text(
    //               "\$${Provider.of<AppData>(context, listen: false).earnings}",
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontFamily: 'Brand Bold',
    //                   fontSize: 50),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Container(width: MediaQuery.of(context).size.width,
    //     height:MediaQuery.of(context).size.height,
    //       color: bordercolor,
    //       child: TextButton(
    //         onPressed: () {
    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (context) => HistoryScreen()));
    //         },
    //         child: Row(
    //           children: [
    //             Image.asset(
    //               'images/tuktuk1.png',
    //               width: 70,
    //             ),
    //             SizedBox(
    //               width: 16,
    //             ),
    //             Text(
    //               'Total Trips',
    //               style: TextStyle(fontSize: 16),
    //             ),
    //             Expanded(
    //               child: Container(
    //                 child: Text(
    //                   Provider.of<AppData>(context, listen: false)
    //                       .counttrips
    //                       .toString(),
    //                   textAlign: TextAlign.end,
    //                   style: TextStyle(fontSize: 18),
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     Divider(height: 2.0, thickness: 2.0),
    //   ],
    // );
  }
}
