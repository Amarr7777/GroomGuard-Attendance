import 'package:flutter/material.dart';
import 'package:frontend/students/student_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final List<CameraDescription> cameras;

  const CourseCard({required this.course, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentList(
                      courseName: course['name'],
                      students: course['students'],
                      cameras: cameras,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course['name'],
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          course['code'],
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w300, color: Colors.black),
                        )
                      ],
                    ),
                    Row(children: [
                      Text(course['numberOfStudents'].toString(),
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(width: 10),
                      Icon(Icons.supervisor_account_sharp,
                          color: Theme.of(context).primaryColor)
                    ])
                  ],
                ),
              ))),
    );
  }
}
