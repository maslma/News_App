import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app2/shared/cubit/cubit.dart';
import 'package:news_app2/shared/cubit/states.dart';
import 'package:news_app2/shared/network/local/cache_helper.dart';
import 'package:news_app2/shared/network/remote/diohelper.dart';
import 'package:news_app2/shared/styles/themes.dart';

import 'package:splash_screen_view/SplashScreenView.dart';

import 'layout/news_app/news_layout.dart';

void main()async
{
  // بيتأكد انو كل حاجة هنا في الميثود خلصت وبعدين يفتح الابليكيشن
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  CacheHelper.putBoolean(key: 'isDark', value: false);
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
   final bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>NewsCubit()..getBusiness()..changeAppMode(
          fromShared:isDark,
        ),),
      ],
      child: BlocConsumer<NewsCubit,NewsStates>(
          listener:(context,state){},
          builder:(context,state){
            return MaterialApp(
              debugShowCheckedModeBanner:false ,
              theme:lightTheme,
              themeMode:NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light ,
              darkTheme:darkTheme ,
              home:Directionality(
                  textDirection:TextDirection.ltr,
                  child: SplashScreenView(
                    navigateRoute: NewsLayout(),
                    duration: 3000,
                    imageSize: 150,
                    imageSrc: "assets/images/splashNews.jpg",
                    text: "News App",
                    textType: TextType.ScaleAnimatedText,
                    textStyle: TextStyle(
                      fontSize: 30.0,
                      fontWeight:FontWeight.bold,
                      color:Colors.red,
                    ),
                    backgroundColor:Colors.white,
                  ),

              ) ,
            );
          }
      ),
    );
  }
}
