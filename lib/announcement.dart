import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'navbar.dart';


class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {

  List imageList = [
    {"id": 1, "image_path": 'assets/ads 1.png'},
    {"id": 1, "image_path": 'assets/ads 2.jpg'},
    {"id": 1, "image_path": 'assets/ads 3.png'},
    {"id": 1, "image_path": 'assets/ads 4.jpg'},
    {"id": 1, "image_path": 'assets/ads 5.webp'}
  ];

  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;

  @override
 Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Announcements'),
      centerTitle: true,
    ),
    body: ListView(
      children: [
        buildCard(
          'General Announcement',
          ''
        ),
      ],
    ),
  );

  Widget buildCard(String title, String urlImage) => Padding(
      padding: const EdgeInsets.all(10),
  child: Card(
    child: ExpandablePanel(
      header: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
        collapsed:  Text(

        ),
        expanded:
    ),
  ),
  );
}
