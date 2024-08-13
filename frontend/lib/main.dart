import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:frontend/Login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/firebase_options.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Example of creating a teacher
  await createUser('teacherId1', 'Sreedevi', 'teacher.one@example.com',
      'Teacher', 'classA', 'faceId123');

  await createClass('classId1', 'Class A', 'teacherId1');
  await createCourse('courseId1', 'Math 101', 'M101');
  await enrollStudent('enrollmentId1', 'studentId1', 'classId1', 'courseId1');

  // Example of creating a student
  await createUser('studentId1', 'John Doe', 'student.one@example.com',
      'Student', 'classA', 'faceId456');

  // Example of creating an attendance record
  await createAttendance(
      'attId1', 'studentId1', 'classA', 'Present', 'Compliant', DateTime.now());

  // Example of creating a grooming status record
  await createGroomingStatus('statusId1', 'studentId1', 'classA', 'Compliant',
      'teacherId1', DateTime.now(), 'All good');

  // Example of creating admin settings
  await createAdminSettings('settingId1', {'Hair': 'Short'},
      {'LateThreshold': 10}, ['adminId1', 'adminId2']);

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

Future<void> createUser(String userId, String name, String email, String role,
    String classId, String faceId) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': name,
      'email': email,
      'role': role,
      'classId': classId,
      'faceId': faceId,
    });
    print('User created successfully');
  } catch (e) {
    print('Error creating user: $e');
  }
}

Future<void> createClass(
    String classId, String className, String teacherId) async {
  try {
    await FirebaseFirestore.instance.collection('classes').doc(classId).set({
      'className': className,
      'teacherId': teacherId,
    });
    print('Class created successfully');
  } catch (e) {
    print('Error creating class: $e');
  }
}

Future<void> createCourse(
    String courseId, String courseName, String courseCode) async {
  try {
    await FirebaseFirestore.instance.collection('courses').doc(courseId).set({
      'courseName': courseName,
      'courseCode': courseCode,
    });
    print('Course created successfully');
  } catch (e) {
    print('Error creating course: $e');
  }
}

Future<void> enrollStudent(
    String enrollmentId, String userId, String classId, String courseId) async {
  try {
    await FirebaseFirestore.instance
        .collection('enrollments')
        .doc(enrollmentId)
        .set({
      'userId': userId,
      'classId': classId,
      'courseId': courseId,
    });
    print('Enrollment created successfully');
  } catch (e) {
    print('Error creating enrollment: $e');
  }
}

Future<void> createAttendance(String attendanceId, String userId,
    String classId, String status, String groomingStatus, DateTime date) async {
  try {
    await FirebaseFirestore.instance
        .collection('attendance')
        .doc(attendanceId)
        .set({
      'userId': userId,
      'classId': classId,
      'status': status,
      'groomingStatus': groomingStatus,
      'date': Timestamp.fromDate(date),
    });
    print('Attendance record created successfully');
  } catch (e) {
    print('Error creating attendance record: $e');
  }
}

Future<void> createGroomingStatus(
    String statusId,
    String userId,
    String classId,
    String status,
    String reviewedBy,
    DateTime date,
    String notes) async {
  try {
    await FirebaseFirestore.instance
        .collection('groomingStatus')
        .doc(statusId)
        .set({
      'userId': userId,
      'classId': classId,
      'status': status,
      'reviewedBy': reviewedBy,
      'date': Timestamp.fromDate(date),
      'notes': notes,
    });
    print('Grooming status created successfully');
  } catch (e) {
    print('Error creating grooming status: $e');
  }
}

Future<void> createAdminSettings(
    String settingId,
    Map<String, dynamic> groomingCriteria,
    Map<String, dynamic> attendanceSettings,
    List<String> authorizedPersonnel) async {
  try {
    await FirebaseFirestore.instance
        .collection('adminSettings')
        .doc(settingId)
        .set({
      'groomingCriteria': groomingCriteria,
      'attendanceSettings': attendanceSettings,
      'authorizedPersonnel': authorizedPersonnel,
    });
    print('Admin settings created successfully');
  } catch (e) {
    print('Error creating admin settings: $e');
  }
}
