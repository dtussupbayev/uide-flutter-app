import 'package:uide/resources/resources.dart';

class House {
  final int id;
  bool liked;
  final String title;
  final String description;
  final String price;
  final String image;

  House({
    required this.id,
    required this.liked,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });
}

class Houses {
  static List<House> houses = [
    House(
        id: 1,
        liked: false,
        title: 'мкр Аскартау, Арайлы 12 ЖК"Сакура"',
        price: '700000',
        description: 'Алматы, Бостандыкский р-н',
        image: Images.mainRoom),
    House(
        id: 2,
        liked: false,
        title: 'Баян Сулу 17, ЖК"Алтын уй"',
        price: '400000',
        description: 'Алматы, Медеуский район',
        image: Images.richRoom),
    House(
        id: 3,
        liked: false,
        title: 'Best big room in Almaty',
        price: '30000',
        description:
            'Live one in big room dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
        image: Images.bedroom1),
    House(
        id: 4,
        liked: false,
        title: 'Best big room in Almaty',
        price: '30000',
        description:
            'Live one in big room dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
        image: Images.budgetRoom1),
    House(
        id: 5,
        liked: false,
        title: 'Best big room in Almaty',
        price: '30000',
        description:
            'Live one in big room dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
        image: Images.singleRoom),
  ];
}
