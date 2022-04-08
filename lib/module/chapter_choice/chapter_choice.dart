import 'package:arena/model/subject_model.dart';
import 'package:arena/module/home/home_cubit.dart';
import 'package:arena/module/home/home_states.dart';
import 'package:arena/shared/local/components.dart';
import 'package:arena/shared/local/constant.dart';
import 'package:arena/shared/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class ChapterChoice extends StatelessWidget {
  String? teacherName;
  SubjectModel subjectModel;
  ChapterChoice(this.teacherName,this.subjectModel,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor:  HexColor('#4d0303'),
              title: Text(
                  subjectModel.subjectName!
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=>chaptersList(
                        data: subjectModel.data[index],
                        context: context, index: index,
                      ),
                      separatorBuilder: (context,index)=>Container(
                        height: 1,
                        color: HexColor('#4d0303'),
                      ),
                      itemCount: subjectModel.data.length
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget chaptersList({required DataModel data,required context,required int index})=>InkWell(
  onTap: () {
    if (data.lock!) {
    var controller = TextEditingController();
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(

        title: const Text(
            'الاشتراك'
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'أدخل الكود للاشتراك في هذا القسم',
            ),
            const SizedBox(height: 5.0,),
            TextFormField(
              controller: controller,
              validator: (value) {
                if (value!.isEmpty) {
                  'الرجاء ادخال كود صالح';
                }
              },
            ),
            const SizedBox(height: 20.0,),
            loginButton(
              context: context,
              onTap: (){
                      DioHelper.deleteData(
                        apiKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1c3dwaXFtbnhtcGpveWprdGZhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY0ODgxODE2NywiZXhwIjoxOTY0Mzk0MTY3fQ.lsgTxihoXlpl0Qj4fv2mtmStO9xBvEWrUsn3qtXwkYs',
                        baseUrl: 'https://uuswpiqmnxmpjoyjktfa.supabase.co/rest/v1/uid?some_column=eq.someValue',
                        data: {'uid':'123'},
                        authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1c3dwaXFtbnhtcGpveWprdGZhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY0ODgxODE2NywiZXhwIjoxOTY0Mzk0MTY3fQ.lsgTxihoXlpl0Qj4fv2mtmStO9xBvEWrUsn3qtXwkYs'
                      ).then((value) {}).catchError((error){print(error);});
                    },
              hexColor: HexColor('#4d0303'),
              text: 'اشتراك',
            )
          ],
        ),
      );
    });
    }
  },
  child:   Padding(
    padding: const EdgeInsets.all(8.0),
    child:   Row(
      children: [
        CircleAvatar(
          backgroundColor: HexColor('#4d0303'),
          child: Icon(
            data.lock!?Icons.lock:Icons.library_books_outlined
          ),
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الفصل ${data.chapter}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              'النوع: ${data.lock!?'مدفوع':'مجاني'}',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ],
    ),
  ),
);