class Student {
  final String name;
  final String rollNumber;

  Student({required this.name, required this.rollNumber});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      rollNumber: json['rollNumber'],
    );
  }
}

class Course {
  final String name;
  final String code;
  final int numberOfStudents;
  final List<Student> students;

  Course({
    required this.name,
    required this.code,
    required this.numberOfStudents,
    required this.students,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    var studentsJson = json['students'] as List;
    List<Student> studentsList =
        studentsJson.map((studentJson) => Student.fromJson(studentJson)).toList();

    return Course(
      name: json['name'],
      code: json['code'],
      numberOfStudents: json['numberOfStudents'],
      students: studentsList,
    );
  }
}
