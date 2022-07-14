import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch:Colors.red ,
  scaffoldBackgroundColor:HexColor('333739'),
  appBarTheme:AppBarTheme(
    titleSpacing:20.0 ,
    iconTheme:IconThemeData(
      color:Colors.white,
    ) ,
    backgroundColor:HexColor('333739'),
    elevation:0.0 ,
    backwardsCompatibility:false ,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor:Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle:TextStyle(
        color:Colors.white,
        fontSize:20.0,
        fontWeight:FontWeight.bold
    ),
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
      type:BottomNavigationBarType.fixed ,
      selectedItemColor:Colors.red,
      unselectedItemColor:Colors.white ,
      elevation:0.0,
      backgroundColor:HexColor('333739')
  ),
  floatingActionButtonTheme:FloatingActionButtonThemeData(
      backgroundColor:Colors.red
  ),
  textTheme:TextTheme(
    bodyText1:TextStyle(
        fontSize:18.0,
        fontWeight:FontWeight.w600,
        color:Colors.white
    ),
    bodyText2:TextStyle(
      fontSize: 15.0,
      color:Colors.grey,
    ),
  ),
);
ThemeData lightTheme = ThemeData(
  primarySwatch:Colors.red ,
  scaffoldBackgroundColor:Colors.white ,
  appBarTheme:AppBarTheme(
    titleSpacing:20.0 ,
    iconTheme:IconThemeData(
      color:Colors.black,
    ) ,
    backgroundColor:Colors.white,
    elevation:0.0 ,
    backwardsCompatibility: false,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor:Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle:TextStyle(
        color:Colors.black,
        fontSize:20.0,
        fontWeight:FontWeight.bold
    ),
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
      type:BottomNavigationBarType.fixed ,
      selectedItemColor:Colors.red,
      unselectedItemColor:Colors.grey ,
      elevation:0.0,
      backgroundColor:Colors.white
  ),
  floatingActionButtonTheme:FloatingActionButtonThemeData(
      backgroundColor:Colors.red
  ),
  textTheme:TextTheme(
    bodyText1:TextStyle(
      fontSize:18.0,
      fontWeight:FontWeight.w600,
      color:Colors.black,
    ),
  ),

);