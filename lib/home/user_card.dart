import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_permit/fonts/fonts.dart';
import 'package:work_permit/globalvarialbles.dart';

class UserCardList extends StatelessWidget {
  final String title;
  final String image;

  const UserCardList({
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            baseUrl + image, 
          ),
          radius: 15,
        ),
        //contentPadding: const EdgeInsets.all(8),
        // leading: Image.network(
        //   baseUrl + image,
        //   width: 28,
        //   height: 28,
        //   fit: BoxFit.cover,
        // ),
        title: Text(
          title,
          style: GoogleFonts.secularOne(textStyle: normalstyle, fontSize: 13)
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: maincolor,
        ),
      ),
    );
  }
}
