import React, { useEffect, useState } from "react";
import UserIcon from "@mui/icons-material/Person";
import {
  doc,
  getDoc,
  collection,
  query,
  where,
  getDocs,
} from "firebase/firestore";
import { firestore } from "../../firebase/config";

function CourseCard({ course }) {
  const [teacherName, setTeacherName] = useState("");
  const [student, setStudent] = useState([]);

  const fetchStudentCount = async () => {
    try {
      const studentsQuery = query(
        collection(firestore, "users"),
        where("role", "==", "Student"),
        where("courseIds", "array-contains", course.id) // Fetch students in any of the classIds
      );

      const studentSnapshot = await getDocs(studentsQuery);
      const studentList = studentSnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      setStudent(studentList);
    } catch (error) {
      console.error("Error fetching students:", error);
      setStudent([]); // Default to 0 if there's an error
    }
  };

  const fetchTeacherName = async () => {
    if (course.teacherIds && course.teacherIds.length > 0) {
      try {
        const teacherDocRef = doc(firestore, "users", course.teacherIds[0]); // Use the first teacherId
        const teacherDoc = await getDoc(teacherDocRef);
        if (teacherDoc.exists()) {
          setTeacherName(teacherDoc.data().name || "Unknown Teacher");
        } else {
          setTeacherName("Unknown Teacher");
        }
      } catch (error) {
        console.error("Error fetching teacher:", error);
        setTeacherName("Error fetching teacher");
      }
    } else {
      setTeacherName("No Teacher Assigned");
    }
  };

  useEffect(() => {
    fetchStudentCount();
    fetchTeacherName();
  }, []);

  return (
    <div className="w-64 md:w-96 h-56 bg-white shadow-lg rounded-xl hover:shadow-2xl">
      <div className="w-64 md:w-96 h-24 bg-primaryColor rounded-t-xl flex justify-center items-center">
        <p className="font-Outfit font-bold text-white text-xl">
          {course.courseName.toUpperCase()}
        </p>
      </div>
      <div className="flex justify-between p-5">
        <div className="flex flex-col">
          <p className="font-Outfit text-lg">{teacherName}</p>
          <p className="font-Outfit font-thin">{course.courseCode.toUpperCase()}</p>
        </div>
        <div className="flex flex-col justify-center items-center">
          <p className="font-Outfit text-lg">{student.length}</p>
          <UserIcon className="text-primaryColor ml-2" />
        </div>
      </div>
    </div>
  );
}

export default CourseCard;
