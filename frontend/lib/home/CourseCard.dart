import 'package:flutter/material.dart';
import 'package:frontend/students/student_list.dart';
import 'package:google_fonts/google_fonts.dart';

class courseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  const courseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentList(
                    courseName: course['name'], // Pass course name
                    students: course['students'], // Pass list of students
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    Text(course['numberOfStudents'],
                        style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(width: 10),
                    Icon(Icons.supervisor_account_sharp,
                        color: Theme.of(context).primaryColor)
                  ])
                ],
              ),
            )));
  }
}
