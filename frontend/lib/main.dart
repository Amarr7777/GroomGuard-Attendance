import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:frontend/Login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/firebase_options.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await createTeacher();
  // await createCourse();
  // await createStudent();
  
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Attendance',
      theme: ThemeData(
        primaryColor: const Color(0xFF01B088),
        useMaterial3: true,
      ),
      // home: HomeScreen(cameras: cameras),
      home: LoginScreen(cameras: cameras),
    );
  }
}


// Future<void> createTeacher() async {
//   try {
//     await FirebaseFirestore.instance.collection('teachers').doc('teacherId1').set({
//       'name': 'Sreedevi',
//       'email': 'teacher.one@example.com',
//       'courses': [
//         FirebaseFirestore.instance.collection('courses').doc('courseId1').path,
//         FirebaseFirestore.instance.collection('courses').doc('courseId2').path,
//       ]
//     });
//     print('Teacher 1 created successfully');
//   } catch (e) {
//     print('Error creating teacher 1: $e');
//   }
// }

// Future<void> createTeacher2() async {
//   try {
//     await FirebaseFirestore.instance.collection('teachers').doc('teacherId2').set({
//       'name': 'Rajesh Kumar',
//       'email': 'teacher.two@example.com',
//       'courses': [
//         FirebaseFirestore.instance.collection('courses').doc('courseId3').path,
//         FirebaseFirestore.instance.collection('courses').doc('courseId4').path,
//       ]
//     });
//     print('Teacher 2 created successfully');
//   } catch (e) {
//     print('Error creating teacher 2: $e');
//   }
// }

// Future<void> createTeacher3() async {
//   try {
//     await FirebaseFirestore.instance.collection('teachers').doc('teacherId3').set({
//       'name': 'Anita Sharma',
//       'email': 'teacher.three@example.com',
//       'courses': [
//         FirebaseFirestore.instance.collection('courses').doc('courseId5').path,
//         FirebaseFirestore.instance.collection('courses').doc('courseId6').path,
//       ]
//     });
//     print('Teacher 3 created successfully');
//   } catch (e) {
//     print('Error creating teacher 3: $e');
//   }
// }

// Future<void> createCourse() async {
//   try {
//     await FirebaseFirestore.instance.collection('courses').doc('courseId1').set({
//       'name': 'Introduction to Computer Science',
//       'code': 'CS101',
//       'numberOfStudents': 20,
//       'teacherId': FirebaseFirestore.instance.collection('teachers').doc('teacherId1').path,
//       'students': [
//         FirebaseFirestore.instance.collection('students').doc('studentId1').path,
//         FirebaseFirestore.instance.collection('students').doc('studentId2').path,
//         FirebaseFirestore.instance.collection('students').doc('studentId3').path,
//       ]
//     });
//     print('Course 1 created successfully');
//   } catch (e) {
//     print('Error creating course 1: $e');
//   }
// }

// Future<void> createCourse2() async {
//   try {
//     await FirebaseFirestore.instance.collection('courses').doc('courseId2').set({
//       'name': 'Data Structures',
//       'code': 'CS102',
//       'numberOfStudents': 25,
//       'teacherId': FirebaseFirestore.instance.collection('teachers').doc('teacherId1').path,
//       'students': [
//         FirebaseFirestore.instance.collection('students').doc('studentId2').path,
//         FirebaseFirestore.instance.collection('students').doc('studentId3').path,
//         FirebaseFirestore.instance.collection('students').doc('studentId4').path,
//       ]
//     });
//     print('Course 2 created successfully');
//   } catch (e) {
//     print('Error creating course 2: $e');
//   }
// }

// Future<void> createCourse3() async {
//   try {
//     await FirebaseFirestore.instance.collection('courses').doc('courseId3').set({
//       'name': 'Operating Systems',
//       'code': 'CS201',
//       'numberOfStudents': 30,
//       'teacherId': FirebaseFirestore.instance.collection('teachers').doc('teacherId2').path,
//       'students': [
//         FirebaseFirestore.instance.collection('students').doc('studentId3').path,
//         FirebaseFirestore.instance.collection('students').doc('studentId5').path,
//         FirebaseFirestore.instance.collection('students').doc('studentId6').path,
//       ]
//     });
//     print('Course 3 created successfully');
//   } catch (e) {
//     print('Error creating course 3: $e');
//   }
// }

// Future<void> createStudent() async {
//   try {
//     await FirebaseFirestore.instance.collection('students').doc('studentId1').set({
//       'name': 'John Doe',
//       'rollNumber': '10001',
//       'attendancePercentage': 95,
//       'courses': [
//         FirebaseFirestore.instance.collection('courses').doc('courseId1').path,
//       ],
//       'attendanceRecords': [
//         {
//           'courseId': FirebaseFirestore.instance.collection('courses').doc('courseId1').path,
//           'status': 'present',
//           'timestamp': Timestamp.fromDate(DateTime.parse('2023-07-24T08:00:00Z')),
//         },
//         {
//           'courseId': FirebaseFirestore.instance.collection('courses').doc('courseId1').path,
//           'status': 'absent',
//           'timestamp': Timestamp.fromDate(DateTime.parse('2023-07-25T08:00:00Z')),
//         }
//       ]
//     });
//     print('Student 1 created successfully');
//   } catch (e) {
//     print('Error creating student 1: $e');
//   }
// }

// Future<void> createStudent2() async {
//   try {
//     await FirebaseFirestore.instance.collection('students').doc('studentId2').set({
//       'name': 'Jane Smith',
//       'rollNumber': '10002',
//       'attendancePercentage': 85,
//       'courses': [
//         FirebaseFirestore.instance.collection('courses').doc('courseId1').path,
//         FirebaseFirestore.instance.collection('courses').doc('courseId2').path,
//       ],
//       'attendanceRecords': [
//         {
//           'courseId': FirebaseFirestore.instance.collection('courses').doc('courseId1').path,
//           'status': 'present',
//           'timestamp': Timestamp.fromDate(DateTime.parse('2023-07-24T08:00:00Z')),
//         },
//         {
//           'courseId': FirebaseFirestore.instance.collection('courses').doc('courseId2').path,
//           'status': 'present',
//           'timestamp': Timestamp.fromDate(DateTime.parse('2023-07-25T08:00:00Z')),
//         }
//       ]
//     });
//     print('Student 2 created successfully');
//   } catch (e) {
//     print('Error creating student 2: $e');
//   }
// }

// Future<void> createStudent3() async {
//   try {
//     await FirebaseFirestore.instance.collection('students').doc('studentId3').set({
//       'name': 'David Brown',
//       'rollNumber': '10003',
//       'attendancePercentage': 90,
//       'courses': [
//         FirebaseFirestore.instance.collection('courses').doc('courseId2').path,
//         FirebaseFirestore.instance.collection('courses').doc('courseId3').path,
//       ],
//       'attendanceRecords': [
//         {
//           'courseId': FirebaseFirestore.instance.collection('courses').doc('courseId2').path,
//           'status': 'absent',
//           'timestamp': Timestamp.fromDate(DateTime.parse('2023-07-24T08:00:00Z')),
//         },
//         {
//           'courseId': FirebaseFirestore.instance.collection('courses').doc('courseId3').path,
//           'status': 'present',
//           'timestamp': Timestamp.fromDate(DateTime.parse('2023-07-25T08:00:00Z')),
//         }
//       ]
//     });
//     print('Student 3 created successfully');
//   } catch (e) {
//     print('Error creating student 3: $e');
//   }
// }

// Future<void> createStudent4() async {
//   try {
//     await FirebaseFirestore.instance.collection('students').doc('studentId4').set({
//       'name': 'Alice Johnson',
//       'rollNumber': '10004',
//       'attendancePercentage': 92,
//       'courses': [
//         FirebaseFirestore.instance.collection('courses').doc('courseId2').path,
//         FirebaseFirestore.instance.collection('courses').doc('courseId4').path,
//       ],
//       'attendanceRecords': [
//         {
//           'courseId': FirebaseFirestore.instance.collection('courses').doc('courseId2').path,
//           'status': 'present',
//           'timestamp': Timestamp.fromDate(DateTime.parse('2023-07-26T08:00:00Z')),
//         },
//         {
//           'courseId': FirebaseFirestore.instance.collection('courses').doc('courseId4').path,
//           'status': 'present',
//           'timestamp': Timestamp.fromDate(DateTime.parse('2023-07-27T08:00:00Z')),
//         }
//       ]
//     });
//     print('Student 4 created successfully');
//   } catch (e) {
//     print('Error creating student 4: $e');
//   }
// }

// Future<void> createStudent5() async {
//   try {
//     await FirebaseFirestore.instance.collection('students').doc('studentId5').set({
//       'name': 'Bob Lee',
//       'rollNumber': '10005',
//       'attendancePercentage': 88,
//       'courses': [
//         FirebaseFirestore.instance.collection('courses').doc('courseId3').path,
//         FirebaseFirestore.instance.collection('courses').doc('courseId5').path,
//       ],
//       'attendanceRecords': [
//         {
//           'courseId': FirebaseFirestore.instance.collection('courses').doc('courseId3').path,
//           'status': 'absent',
//           'timestamp': Timestamp.fromDate(DateTime.parse('2023-07-26T08:00:00Z')),
//         },
//         {
//           'courseId': FirebaseFirestore.instance.collection('courses').doc('courseId5').path,
//           'status': 'present',
//           'timestamp': Timestamp.fromDate(DateTime.parse('2023-07-27T08:00:00Z')),
//         }
//       ]
//     });
//     print('Student 5 created successfully');
//   } catch (e) {
//     print('Error creating student 5: $e');
//   }
// }
