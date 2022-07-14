import 'package:dio/dio.dart';

class DioHelper
{
  // object dio
 static Dio? dio;
// create dio
 static init(){
    dio = Dio(
      BaseOptions(
        baseUrl:'https://newsapi.org/',
        receiveDataWhenStatusError:true,
      ),
    );
  }
// method get data (عشان نقدر نجيب الداتا )
static Future<Response>getData(
 {
required String url,
required Map<String,dynamic> query,
})async
{
   return await dio!.get(url,queryParameters:query,);
}

}