import 'package:flutter/material.dart';
import 'package:work_permit/globalvarialbles.dart';

class CardList extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  //final int id;

  const CardList({
   // required this.id,
    required this.title,
    required this.image,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ListTile(
        //contentPadding: const EdgeInsets.all(8),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            baseUrl + image,
          ),
          radius: 16,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: maincolor,
        ),
      ),
    );
  }
}
