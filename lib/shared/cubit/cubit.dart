import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app2/shared/cubit/states.dart';

import '../../modules/business/business_scrren.dart';
import '../../modules/science/science_scrren.dart';
import '../../modules/sports/sports_scrren.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/diohelper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
// هاد لل Bottom
List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon:Icon(Icons.business),
        label:'Businees'
    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.sports),
        label:'Sports'
    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.science),
        label:'Science'
    ),
  ];
// هاد لل تغير الbottom لل  ontab
  void changeBottomNavBar(index){
    currentIndex=index;

    if(index == 1)
      getSports();
    if(index == 2)
      getScience();

    emit(NewsBottomNavState());
  }
// هاد للscreen عشان نغير عليه
  List<Widget> screen =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];

List<dynamic> business =[];
// هاد لبيانات الbusiness تمام
void getBusiness()
{
  // لما ابدا برضو ايمت
  emit(NewsGetBusinessLoadingState());
  DioHelper.getData(
      url:'v2/top-headlines',
      query: {
        'country': 'eg',
        'category' : 'business',
        'apiKey' : '2faed9fb1d254d2ea04e062071a449e2'
      }
  ).then((value)
  {
    //print(value.data['articles'][0]['title']);
    business = value.data['articles'];
    print(business[0]['title']);
    // لما اخلص اعمل ايمت success
    emit(NewsGetBusinessSuccessState());
  }
  ).catchError((error)
  {
    print(error.toString());
    // برضو ايمت الايرور
    emit(NewsGetBusinessErrorState(error.toString()));
  });
}

List<dynamic> sports =[];
// هاد لبيانات sports تمام
void getSports()
{
  // لما ابدا برضو ايمت
  emit(NewsGetSportsLoadingState());
  if(sports.length == 0)
  {
    DioHelper.getData(
        url:'v2/top-headlines',
        query: {
          'country': 'eg',
          'category' : 'sports',
          'apiKey' : '2faed9fb1d254d2ea04e062071a449e2'
        }
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      sports = value.data['articles'];
      print(sports[0]['title']);
      // لما اخلص اعمل ايمت success
      emit(NewsGetSportsSuccessState());
    }
    ).catchError((error)
    {
      print(error.toString());
      // برضو ايمت الايرور
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }
  else
  {
    emit(NewsGetSportsSuccessState());
  }

}
// هاد برضو لبيانات ال science تمام
List<dynamic> science =[];

  void getScience()
  {
    // لما ابدا برضو ايمت
    emit(NewsGetScienceLoadingState());
    if(science.length == 0)
    {
      DioHelper.getData(
          url:'v2/top-headlines',
          query: {
            'country': 'eg',
            'category' : 'science',
            'apiKey' : '2faed9fb1d254d2ea04e062071a449e2'
          }
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        // لما اخلص اعمل ايمت success
        emit(NewsGetScienceSuccessState());
      }
      ).catchError((error)
      {
        print(error.toString());
        // برضو ايمت الايرور
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else
    {
      emit(NewsGetScienceSuccessState());
    }

  }
  // هاد search
List<dynamic> search =[];
  void getSearch(String value)
  {
    // لما ابدا برضو ايمت
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url:'v2/everything',
        query: {
          'q' : '$value',
          'apiKey' : '2faed9fb1d254d2ea04e062071a449e2'
        }
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      // لما اخلص اعمل ايمت success
      emit(NewsGetSearchSuccessState());
    }
    ).catchError((error)
    {
      print(error.toString());
      // برضو ايمت الايرور
      emit(NewsGetSearchErrorState(error.toString()));
    });

  }
// هاد لتغير ال dark
bool isDark = false;
  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }

  }

}
