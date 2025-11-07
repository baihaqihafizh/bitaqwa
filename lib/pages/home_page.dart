import 'dart:async'; //timer countdown
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; //carousel slider
import 'package:http/http.dart' as http; //ambil data API GPS
import 'dart:convert'; //decode JSON
import 'package:geolocator/geolocator.dart'; //GPS
import 'package:geocoding/geocoding.dart'; //konversi GPS
import 'package:intl/intl.dart'; // formater number
import 'package:permission_handler/permission_handler.dart'; // izin handler
import 'package:shared_preferences/shared_preferences.dart'; // cache lokal
import 'package:string_similarity/string_similarity.dart'; // fuzzy match

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController controller = CarouselController();
  int currenIndex = 0;

  final posterList = const <String>[
    'assets/images/ramadhan.jpg',
    'assets/images/idulfitri.jpg',
    'assets/images/iduladha.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 47, 141, 133),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                Image.asset('assets/images/ic_menu_doa.png'),
                                Text(
                                  'Doa & Zikir',
                                  style: TextStyle(
                                    fontFamily: 'poppinsRegular',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/ic_menu_jadwal_sholat.png',
                                ),
                                Text(
                                  'Jadwal Sholat',
                                  style: TextStyle(
                                    fontFamily: 'poppinsRegular',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/ic_menu_video_kajian.png',
                                ),
                                Text(
                                  'Video kajian',
                                  style: TextStyle(
                                    fontFamily: 'poppinsRegular',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                Image.asset('assets/images/ic_menu_zakat.png'),
                                Text(
                                  'zakat',
                                  style: TextStyle(
                                    fontFamily: 'poppinsRegular',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildCarouselSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        CarouselSlider.builder(
          itemCount: posterList.length,
          itemBuilder: (context, index, realindex) {
            final poster = posterList[index];
            return Container(
              child: Container(
                margin: EdgeInsets.all(15),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  child: Image.asset(
                    poster,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            height: 270,
            enlargeCenterPage: true,
            viewportFraction: 0.7,
            onPageChanged: (index, reason) {
              setState(() {
                currenIndex = index;
              });
            },
          ),
        ),
        // DOT INDIKATOR CAROUSEL
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: posterList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => currenIndex.animateToPage(entry.key),
              child: Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currenIndex == entry.key
                      ? Colors.amber
                      : Colors.grey[400],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

extension on int {
  void animateToPage(int key) {}
}
