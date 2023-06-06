import 'package:uide/resources/resources.dart';

enum Gender {
  female,
  male,
}

class Roommate {
  final int id;
  bool liked;
  final String title;
  final String description;
  final int budget;
  final String image;
  Gender gender;
  final String name;
  final int age;

  Roommate({
    required this.id,
    required this.liked,
    required this.title,
    required this.description,
    required this.image,
    required this.gender,
    required this.budget,
    required this.name,
    required this.age,
  });
}

class Roommates {
  static List<Roommate> roommates = [
    Roommate(
      id: 1,
      liked: false,
      title: 'Баян Сулу 17, ЖК"Алтын уй"',
      budget: 100000,
      description: 'Алматы, Бостандыкский р-н',
      image: Images.userAvatar,
      age: 21,
      name: 'Даулет',
      gender: Gender.male,
    ),
    Roommate(
      id: 2,
      liked: false,
      title: 'мкр Аскартау, Арайлы 12 ЖК"Сакура"',
      budget: 120000,
      description: 'Алматы, Бостандыкский р-н',
      image: Images.userAvatar2,
      age: 23,
      name: 'Диас',
      gender: Gender.male,
    ),
    Roommate(
      id: 3,
      liked: false,
      title: 'мкр Май юниверс',
      budget: 100000000,
      description: 'Алматы, Бостандыкский р-н',
      image: Images.kairatNurtas,
      age: 34,
      name: 'Кайрат',
      gender: Gender.male,
    ),
    Roommate(
      id: 4,
      liked: false,
      title: 'мкр Аскартау, Арайлы 12 ЖК"Сакура"',
      budget: 200000,
      description: 'Алматы, Бостандыкский р-н',
      image: Images.userAvatar3,
      age: 22,
      name: 'Дархан',
      gender: Gender.male,
    ),
  ];
}
