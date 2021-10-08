
import 'package:flutter/material.dart';
import 'package:saasdriver/Assistants/assistantMethod.dart';
import 'package:saasdriver/Models/history.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../configMap.dart';

class HistoryItem extends StatelessWidget {
  final History history;
  HistoryItem({this.history});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical:10),
      child:Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15),
             boxShadow: [
          BoxShadow(
              offset: Offset(0.8, 1),
               color: textcolor.withOpacity(.25),
               spreadRadius: 1,
               blurRadius: 5),
        ],
        color: bordercolor),
        child: Padding(
          padding: const  EdgeInsets.symmetric(horizontal: 12,vertical:8 ),
          child: Column(
            children: [
            
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AssistantMethods.formatTripDate(history.createdAt),
                    style: TextStyle(color: textcolor, fontFamily: "segoe",letterSpacing: 1.2),
                    
                  ),
                ],
              ),
               SizedBox(height: 2,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                
                children: [  
                  Text(
                   AppLocalizations.of(context).from,
                    style: TextStyle(color: textcolor, fontFamily: "segoebold"),
                   
                  ),
                ],
              ),
               SizedBox(height: 2,),
              Row(
                children: [
                    Image.asset(
                        'images/locationgreen.png',
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            history.pickup,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontFamily: "segoebold",fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                ],
              ),
               SizedBox(height: 2,),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text( AppLocalizations.of(context).to, style: TextStyle(fontFamily: "segoebold"),),
                ],
              ),
              SizedBox(height: 2,),
              Row(
                children: [
                   Image.asset(
                      'images/locationred.png',
                      height: 16,
                      width: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      history.dropOff,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16,fontFamily: "segoebold",fontWeight: FontWeight.bold),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                     Text(
                        '\$${history.fares}',
                        style: TextStyle(
                            fontFamily: 'segoebold',
                            fontSize: 16,
                            color:  Color(0xfffe5d33)),
                      ),

                  ],
                ),
              )
              
            ],
          ),
        ),
      ),




      //  Column(
      //   children: [
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Container(
      //           child: Row(
      //             children: <Widget>[
      //               Image.asset(
      //                 'images/pickicon.png',
      //                 height: 16,
      //                 width: 16,
      //               ),
      //               SizedBox(
      //                 width: 18,
      //               ),
      //               Expanded(
      //                 child: Container(
      //                   child: Text(
      //                     history.pickup,
      //                     overflow: TextOverflow.ellipsis,
      //                     style: TextStyle(),
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: 5,
      //               ),
      //               Text(
      //                 '\$${history.fares}',
      //                 style: TextStyle(
      //                     fontFamily: 'Brand Bold',
      //                     fontSize: 16,
      //                     color: Colors.black87),
      //               ),
      //             ],
      //           ),
      //         ),
      //         SizedBox(
      //           height: 8,
      //         ),
      //         Row(
      //           mainAxisSize: MainAxisSize.max,
      //           children: [
      //             Image.asset(
      //               'images/desticon.png',
      //               height: 16,
      //               width: 16,
      //             ),
      //             SizedBox(
      //               width: 18,
      //             ),
      //             Text(
      //               history.dropOff,
      //               overflow: TextOverflow.ellipsis,
      //               style: TextStyle(fontSize: 18),
      //             ),
      //           ],
      //         ),
      //         SizedBox(
      //           height: 15.0,
      //         ),
      //         Text(AssistantMethods.formatTripDate(history.createdAt),style: TextStyle(color: Colors.grey),),
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}
