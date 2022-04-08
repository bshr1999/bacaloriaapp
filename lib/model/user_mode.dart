class UserModel{
  String? name;
  String? email;
  String? uid;
  String? image;
  UserModel({
    required this.image,
    required this.name,
    required this.email,
    required this.uid,
  });

  UserModel.fromJson(Map<String,dynamic>json){
    email=json['email'];
    name=json['name'];
    uid=json['uid'];
    image=json['image'];
  }

  // ignore: non_constant_identifier_names
  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'uid':uid,
      'image':image,
    };
  }
}