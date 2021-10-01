class MyUser {

  final String uid;
  
  MyUser({ required this.uid });//added required keyword

} 



class UserData {

  final String uid;
  final String? Fname;
  final String? Lname;
  final String? Email;
  final String? Pass;
  final int? Age;//is it string?
  final String? Gender;
  final String? City;
  final String? Neighborhood;

  UserData({ required this.uid, this.Fname, this.Lname, this.Email, 
             this.Pass, this.Age, this.Gender, this.City,this.Neighborhood,  });

}