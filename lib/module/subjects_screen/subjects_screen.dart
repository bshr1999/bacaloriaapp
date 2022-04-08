import 'package:arena/model/subject_model.dart';
import 'package:arena/module/chapter_choice/chapter_choice.dart';
import 'package:arena/shared/local/components.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../home/home_cubit.dart';
import '../home/home_states.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Builder(
      builder: (context) {
        return BlocConsumer<HomeCubit,HomeStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: HexColor('#4d0303'),
                title: const Text(
                  'A & B',
                ),
              ),
              body: HomeCubit.get(context).sliderModel!=null && HomeCubit.get(context).subjectModel!=null?
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250.0,
                        initialPage: 0,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: HomeCubit.get(context).imageSlider,
                    ),
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'المواد المتاحة:',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: HomeCubit.get(context).gridWidget,
                      mainAxisSpacing: .4,
                      crossAxisSpacing: .4,
                      childAspectRatio: .7/.9,
                    ),
                  ],
                ),
              ):const Center(child: CircularProgressIndicator(color: Colors.black,)),
            );
          },
        );
      }
    );
  }
}




Widget gridViewItem({required context,required SubjectModel subjectModel,})=> Padding(
  padding: const EdgeInsets.all(12.0),
  child:   Stack(
    alignment: Alignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 4,
            color: HexColor('#4d0303'),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المادة: ${subjectModel.subjectName}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0,),
              Text(
                  'عدد الفصول: ${subjectModel.allChapter}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0,),
              Text(
                'المدرس: ${subjectModel.teacherName}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: loginButton(
                  context: context,
                  hexColor: HexColor('#4d0303'),
                  text: 'اشتراك',
                  onTap: () {
                    navigateTo(context: context, widget: ChapterChoice(subjectModel.teacherName,subjectModel));
                  },
                ),
              )
            ],
          ),
        ),
      )
    ],
  ),
);
