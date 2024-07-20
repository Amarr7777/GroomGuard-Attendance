import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'CourseCard.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<dynamic> courses = [];
  List<dynamic> filteredCourses = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCourses();
    searchController.addListener(() {
      filterCourses();
    });
  }

  Future<void> loadCourses() async {
    final String response = await rootBundle.loadString('lib/constants/courses.json');
    final data = await json.decode(response);
    setState(() {
      courses = data['courses'];
      filteredCourses = courses;
    });
  }

  void filterCourses() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredCourses = courses.where((course) {
        return course['name'].toString().toLowerCase().contains(query) ||
               course['code'].toString().toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/mainBg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          filteredCourses.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    return courseCard(course: filteredCourses[index]);
                  },
                ),
        ],
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/appBarBg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "SREEDEVI",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: GoogleFonts.outfit(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
