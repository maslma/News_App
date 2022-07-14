import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/search/search_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {

  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context, state) {} ,
      builder:(context, state) {
        var cubit =NewsCubit.get(context);
        return Scaffold(
          appBar:AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                icon:Icon(Icons.search) ,
                onPressed:()
                {
                  navigateTo(context, SearchScreen());
                } ,
              ),
              IconButton(
                icon:Icon(Icons.brightness_4_outlined) ,
                onPressed:(){
                  NewsCubit.get(context).changeAppMode();
                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  // prefs.setBool('isDark', true).then((value){
                  //   if (value) {
                  //
                  //   }
                  // });
                  // NewsCubit.get(context).changeAppMode();
                } ,
              ),
            ],
          ) ,
          body:cubit.screen[cubit.currentIndex] ,
          bottomNavigationBar:BottomNavigationBar(
            items:cubit.bottomItems,
            currentIndex:cubit.currentIndex ,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
          ) ,
        );
      } ,
    );
  }
}
