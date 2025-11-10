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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // =========================
              // MENU WAKTU SHOLAT BY LOKASI
              // =========================
              _buildHeroSection(),
              // =========================
              // MENU SECTION
              // =========================
              _buidMenuGridSection(),
              // =========================
              // CAROUSEL SECTION
              // =========================
              _buildCarouselSection(),
            ],
          ),
        ),
      ),
    );
  }
  // =========================
  // MENU HERO WIDGET
  // =========================
  Widget _buildHeroSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 290,
          decoration: BoxDecoration(
            color: Color(0xFFB3E5FC),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          image: DecorationImage(image: AssetImage('assets/images/pagi.jpg'
          ),
          fit: BoxFit.cover,
          ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Assalamu\'alaikum',
                  style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                Text('Ngargoyoso', style: TextStyle(
                  fontFamily: 'PoppinsSemiBold', 
                  fontSize: 22,
                  color: Colors.white,
                  ),
                ),
                Text(
                  DateFormat('HH:mm')
                  .format(DateTime.now()),
                  style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 50,
                    height: 1.2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // =========================
  // MENU ITEM WIDGET
  // =========================
  Widget _buildMenuItem(
    String iconPath, 
    String title, 
    String routeName,
    ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, routeName);
        },
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.amber.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconPath, width: 35,),
              const SizedBox(height: 6),
              Text(title, style: TextStyle(fontFamily: 'PoppinsRegular', fontSize: 13,),)
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // MENU GRID SECTION WIDGET
  // =========================
  Widget _buidMenuGridSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
      crossAxisCount: 4, 
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMenuItem('assets/images/doa.jpg', 'Doa', '/doa'),
        _buildMenuItem('assets/images/sholat.jpg', 'Sholat', '/doa'),
        _buildMenuItem('assets/images/wifimalam.jpg', 'Kajian', '/doa'),
        _buildMenuItem('assets/images/calkulator.jpg', 'Zakat', '/doa'),
        _buildMenuItem('assets/images/sholat.jpg', 'Khutbah', '/doa'),
      ],
      ),
    );
  }

  // =========================
  // CAROUSEL SECTION WIDGET
  // =========================
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
