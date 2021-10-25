class MyUser {

  final String uid;
  //final String? Fname;
  MyUser({ required this.uid});//added required keyword

} 



class TraineeData {

  late final String uid;
  late final String? Tname;
   //final String? Lname;
  late final String? Phone;
  //final String? Pass;
  late final int? Age;//is it string?
  late final String? Gender;
  //final String? City;
  //final String? Neighborhood;

  TraineeData({ required this.uid, this.Tname, this.Phone, 
             this.Age, this.Gender,});// this.City,this.Neighborhood,  

}