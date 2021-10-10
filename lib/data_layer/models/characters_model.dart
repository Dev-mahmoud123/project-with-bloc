class CharacterModel {
  late int charId;
  late String name;
  late String birthday;
  List<String>? occupation;
  late String img;
  String? status;
  String? nickname;
  late List<int> appearance;
  String? portrayed;
  String? category;
  List<dynamic>? betterCallSaulAppearance;

  CharacterModel(
      {required this.charId,
      required this.name,
      required this.birthday,
      this.occupation,
      required this.img,
      this.status,
      this.nickname,
      required this.appearance,
      this.portrayed,
      this.category,
      this.betterCallSaulAppearance});

  CharacterModel.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'].cast<String>();
    img = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'].cast<int>();
    portrayed = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }
}
