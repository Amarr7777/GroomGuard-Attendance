import 'package:flutter/material.dart';
import 'package:frontend/scanning/scan_screen.dart';
import 'package:frontend/students/student_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';

class StudentList extends StatelessWidget {
  final String courseName;
  final List<dynamic> students;
   final List<CameraDescription> cameras;

  const StudentList({
    super.key,
    required this.courseName,
    required this.students,
    required this.cameras,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
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
            ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return StudentCard(
                    student: student,
                    course: {
                      'name': courseName,
                      'students': students
                    }, // Pass course details
                  );
                }),
          ],
        ),
        floatingActionButton: Container(
          width: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ScanScreen(cameras: cameras),
                ),
              );
            },
            label: Text("Scan",
                style: GoogleFonts.outfit(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ));
  }

  PreferredSize _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(180),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_outlined,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.pop(
                              context); // Go back to the previous screen
                        },
                      ),
                      const SizedBox(width: 10),
                      Text(
                        courseName,
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
                          // controller: searchController,
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
