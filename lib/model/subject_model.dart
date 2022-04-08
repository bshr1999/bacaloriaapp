class SubjectListModel{
  List<SubjectModel> model=[];
  SubjectListModel();
  SubjectListModel.fromJson({required List<dynamic> json}){
    for (var element in json) {
      model.add(SubjectModel.fromJson(json: element));
    }
  }
}

class SubjectModel{
  String? subjectName;
  int? allChapter;
  String? teacherName;
  List<DataModel> data=[];
  SubjectModel.fromJson({required Map<dynamic,dynamic>json}){
    subjectName=json['subjects'];
    allChapter=json['chapters'];
    teacherName=json['teacher'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel{
  String? chapter;
  bool? lock;
  String? video_url;

  DataModel.fromJson(Map<String,dynamic>json){
   chapter=json['chapter'];
   lock=json['lock'];
   video_url=json['video_url'];
  }
}