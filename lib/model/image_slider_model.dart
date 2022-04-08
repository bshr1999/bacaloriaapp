class ListSliderModel{
  List<SliderModel> model=[];

  ListSliderModel();
  ListSliderModel.fromJson({required List<dynamic> json}){
    for (var element in json) {
      model.add(SliderModel.fromJson(json: element));
    }
  }
}

class SliderModel{
  int? id;
  String? image;

  SliderModel.fromJson({required Map<dynamic,dynamic>json}){
    id=json['id'];
    image=json['image'];
  }

}