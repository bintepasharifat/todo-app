// import 'dart:ffi';

class TODOMODEL{
  String title;
  bool isCompleted;
  TODOMODEL({required this.title,required this.isCompleted});

  void toggleCompleted(){
    isCompleted =!isCompleted;
  }
}