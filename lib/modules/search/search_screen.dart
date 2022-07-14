import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';


class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state){
         var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar:AppBar() ,
          body:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onTap: (){},
                    onChange: (value)
                    {
                      NewsCubit.get(context).getSearch(value);
                    },
                    validate: (String? value){
                      if(value!.isEmpty){
                        return 'title must not be empty';
                      }
                      return null;
                    },
                    preIcon: Icons.search,
                   lable: 'Search',
                  context:context
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch:true )),

            ],
          ) ,

        );
      } ,
    );
  }
}
