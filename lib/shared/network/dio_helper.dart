import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;
  static Dio? dioSub;

  static initSubDio(){
    dioSub=Dio(
      BaseOptions(
        baseUrl: 'https://uuswpiqmnxmpjoyjktfa.supabase.co/rest/v1/subjects?select=*',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://uuswpiqmnxmpjoyjktfa.supabase.co/rest/v1/items?select=*',
        receiveDataWhenStatusError: true,
      ),
    );
  }

static Future<Response>getData({
  required String baseUrl,
  required String apiKey,
  required String authorization,
}){
    dio!.options.baseUrl=baseUrl;
    dio!.options.headers={
      'apikey':apiKey,
      'Authorization':authorization
    };
    return dio!.get(
      apiKey
    );
  }

  static Future<Response>postData({
    required String apiKey,
    required String baseUrl,
    required Map<String, dynamic> data,
    required String authorization,
  }){
    dio!.options.headers={
      'apikey':apiKey,
      'Authorization':authorization,
      'Content-Type':'application/json',
    };
    return dio!.post(
      baseUrl,
      data: data,
    );
  }

  static Future<Response>deleteData({
    required String apiKey,
    required String baseUrl,
    required var data,
    required String authorization,
  }){

    dio!.options.headers={
      'apikey':apiKey,
      'Authorization':authorization,
    };
    return dio!.delete(
      baseUrl,
      data: data,
    );
  }
}