class UserModel {
  final String photoUrl;
  final String nickname;
  final String id;

  @override
  String toString() =>
      'UserModel{photoUrl: $photoUrl, nickname: $nickname, id: $id}';

  UserModel({required this.id, required this.nickname, required this.photoUrl});
}
