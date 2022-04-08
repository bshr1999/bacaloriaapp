import 'package:arena/module/subjects_screen/subjects_screen.dart';
import 'package:arena/shared/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/image_slider_model.dart';
import '../../model/subject_model.dart';
import '../news/news.dart';
import '../settings/settings.dart';
import '../subjects_file/subjects_file.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context)=>BlocProvider.of(context);

  List<BottomNavigationBarItem> item=[
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.menu_book,
      ),
      label: 'الصفحة الرئيسية',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.attach_file_outlined,
      ),
      label: 'الملفات الدراسية',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.vpn_lock_outlined,
      ),
      label: 'الاعلانات',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'الاعدادات',
    ),
  ];

  List<Widget>screens=[
    const SubjectsScreen(),
    const SubjectsFile(),
    const News(),
    const Settings(),
  ];

  int index=0;
  void barIndex(int index){
    this.index=index;
    emit(NavigationBarIndexState());
  }

  ListSliderModel? sliderModel;
  List<Widget>imageSlider=[];
  void getDataSupabase()async{
    DioHelper.getData(
      baseUrl:'https://uuswpiqmnxmpjoyjktfa.supabase.co/rest/v1/items?select=*',
      apiKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1c3dwaXFtbnhtcGpveWprdGZhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY0ODgxODE2NywiZXhwIjoxOTY0Mzk0MTY3fQ.lsgTxihoXlpl0Qj4fv2mtmStO9xBvEWrUsn3qtXwkYs',
      authorization:'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1c3dwaXFtbnhtcGpveWprdGZhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY0ODgxODE2NywiZXhwIjoxOTY0Mzk0MTY3fQ.lsgTxihoXlpl0Qj4fv2mtmStO9xBvEWrUsn3qtXwkYs'
    ).then((value){
      sliderModel=ListSliderModel.fromJson(json: value.data);
      for(int i=0;i<sliderModel!.model.length;i++){
        imageSlider.add(
          Image(
            width: double.infinity,
            image: NetworkImage(
              sliderModel!.model[i].image!
            ),
            fit: BoxFit.fill,
          ),
        );
      }
      emit(SliderImageModelSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SliderImageModelErrorState());
    });
  }

  SubjectListModel? subjectModel;
  List<Widget>gridWidget=[];
  void getSubjectDetails({required context}){
    DioHelper.getData(
      baseUrl:'https://uuswpiqmnxmpjoyjktfa.supabase.co/rest/v1/subjects?select=*',
      apiKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1c3dwaXFtbnhtcGpveWprdGZhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY0ODgxODE2NywiZXhwIjoxOTY0Mzk0MTY3fQ.lsgTxihoXlpl0Qj4fv2mtmStO9xBvEWrUsn3qtXwkYs',
      authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1c3dwaXFtbnhtcGpveWprdGZhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY0ODgxODE2NywiZXhwIjoxOTY0Mzk0MTY3fQ.lsgTxihoXlpl0Qj4fv2mtmStO9xBvEWrUsn3qtXwkYs',
    ).then((value) {
      subjectModel=SubjectListModel.fromJson(json: value.data);
      for (int i=0;i<subjectModel!.model.length;i++){
        gridWidget.add(gridViewItem(context: context, subjectModel: subjectModel!.model[i]));
      }
      emit(SubjectDetailsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SubjectDetailsErrorState());
    });
  }

}