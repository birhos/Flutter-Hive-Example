import 'package:hive/hive.dart';

part 'userModel.g.dart';

// flutter packages pub run build_runner build

@HiveType(typeId: 1)
class UserModel {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  UserModel({this.name, this.age});
}
