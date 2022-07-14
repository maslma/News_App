import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../modules/web_view/web_view_screen.dart';
import '../cubit/cubit.dart';



//لما توخذ required Function بنعطيها anlos method وبنكتب دالة بداخلها
Widget defaultButton({
   double width = double.infinity,
   Color background = Colors.blue,
   double radius = 10.0,
   bool isUperCase = true,
  required Function function,
  required String text,
}) =>
    Container(
width:width ,
height:50.0 ,
child: MaterialButton(
  onPressed: (){
    function();
  } ,
child:Text(
isUperCase ? text.toUpperCase() : text,
style:const TextStyle(
color:Colors.white,
) ,

) ,
),
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(radius),
        color:background ,

      ) ,
);
// لما يكون عندي Function  بدون required بنكتبها كالتالي Function? onSubmit كمثال ولما نيجي نستدعيها بنعمل anlos method
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  bool isClikable = true,
  Function? onChange,
  Function? onSubmit,
  Function? onTap,
  required Function validate,
  required String lable,
  required IconData preIcon,
  IconData? suffix,
  Function? suffixPressed,
  context,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClikable,
  onChanged: (s){
    onChange!(s);
  },
  onFieldSubmitted: (s){
    onSubmit!(s);
  },
  validator: (s){
    validate(s);
  },
  onTap: (){
    onTap!();
  },
  style: TextStyle(
    color: NewsCubit.get(context).isDark? Colors.white:  Colors.black,
  ),
  decoration: InputDecoration(
    label: Text(lable),
    labelStyle: TextStyle(
      color:NewsCubit.get(context).isDark? Colors.white: Colors.black,
    ),
    prefixIcon: Icon(preIcon,color:NewsCubit.get(context).isDark? Colors.white: Colors.black),
    suffixIcon: suffix !=null ?IconButton(onPressed: (){suffixPressed!();}, icon: Icon(suffix,color:Colors.black,)):null,
    border:OutlineInputBorder(
      borderSide: BorderSide(
        color: NewsCubit.get(context).isDark? Colors.white: Colors.black,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color:NewsCubit.get(context).isDark? Colors.white:  Colors.black,
      ),
    ),

  ),
);
// Widget defaultFormField(
// {
// required TextEditingController controller,
// required TextInputType type,
// bool isPassWord =false,
// bool isClickable = true,
// Function? onSubmit,
// Function? onChange,
// Function? onTap,
// required Function validate,
// required String label,
// required IconData prefix,
//   IconData? suffix,
// Function? suffixPressed,
// })=>TextFormField(
// controller:controller ,
// keyboardType:type ,
// obscureText:isPassWord,
// enabled:isClickable ,
// onFieldSubmitted:(val) => onSubmit!(val),
// onChanged:(val) => onChange!(val),
// validator:(val) => validate(val),
// onTap:(){
//   onTap!();
// },
// decoration:InputDecoration(
// labelText:label,
//   prefixIcon:Icon(
// prefix,
// ),
// suffixIcon: suffix != null ? IconButton(
//   onPressed:(){
//     suffixPressed!();
//   } ,
//   icon:Icon(
//   suffix,
//   ),
// ) : null,
// border:const OutlineInputBorder(),
// ) ,
// );

// هاد للسكرينات ال desgin
Widget builderArticleItem(article,context)=>InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width:120.0 ,
          height: 120.0,
          decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(10.0),
            image:DecorationImage(
              image:article['urlToImage'] == null ?AssetImage('assets/images/news.jpg') as ImageProvider<Object> :NetworkImage('${article['urlToImage']}'),
              fit:BoxFit.cover,
            ),
          ) ,
        ),
        SizedBox(
          width:20.0 ,),
        Expanded(
          child: Container(
            height:120.0 ,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start ,
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style:Theme.of(context).textTheme.bodyText1,
                    maxLines:3 ,
                    overflow:TextOverflow.ellipsis ,
                  ),
                ),
                Text('${article['publishedAt']}',
                  style:Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
//هاد للخط الفاصل
Widget myDivider() =>Padding(
  padding: const EdgeInsetsDirectional.only(
    start:20.0,
  ),
  child: Container(
    width:double.infinity,
    height:1.0 ,
    color:Colors.grey[500] ,
  ),
);
// هاد لما نستقبل البيانات ب listview
Widget articleBuilder(list,context,{isSearch = false}) => ConditionalBuilder(
  condition:list.length > 0 ,
  builder:(context)=>ListView.separated(
    physics: BouncingScrollPhysics() ,
    itemBuilder: (context,index)=>builderArticleItem(list[index],context),
    separatorBuilder: (context,index)=>myDivider() ,
    itemCount:list.length,
  ) ,
  fallback:(context)=> isSearch ?Container() :Center(child: CircularProgressIndicator()) ,
);
// هاد لل Navigator
void navigateTo(context , widget ) => Navigator.push(context,
    MaterialPageRoute(
      builder:(context) => widget,
    ));