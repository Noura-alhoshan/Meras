class UserModel {
  final String photoUrl='assets/images/Female.png';
  final String Fname;
  final String id;

  @override
  String toString() =>
      'UserModel{photoUrl: $photoUrl, nickname: $Fname, id: $id}';

  UserModel({required this.id, required this.Fname, });
}
