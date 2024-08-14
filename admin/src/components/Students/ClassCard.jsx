import React, { useState, useEffect } from "react";
import EditIcon from "@mui/icons-material/Edit";
import DeleteIcon from "@mui/icons-material/Delete";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import SearchIcon from "@mui/icons-material/Search";
import StudentCard from "./StudentCard";
import { collection, query, where, getDocs } from "firebase/firestore";
import { firestore } from "../../firebase/config"; // Ensure this is correctly imported

function ClassCard({ course }) {
  const [showStudents, setShowStudents] = useState(false);
  const [students,setStudents] = useState([])
  const [searchTerm, setSearchTerm] = useState("");

  var visibility = "hidden";
  var rounded = "rounded-xl";
  showStudents
    ? ((visibility = "visible"), (rounded = "rounded-t-xl"))
    : (visibility = "hidden");

  const fetchStudents = async () => {
    try {
      const studentsQuery = query(
        collection(firestore, "users"),
        where("role", "==", "Student"),
        where("classId", "==", course.id)
      );

      const studentSnapshot = await getDocs(studentsQuery);
      const studentList = studentSnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      setStudents(studentList);
    } catch (error) {
      console.error("Error fetching students:", error);
    }
  };

  useEffect(() => {
    fetchStudents();
  }, [showStudents, course.id]);

  const filteredStudents = students.filter((student) =>
    student.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div>
      <div
        className={`flex justify-between bg-white shadow-lg px-5 py-3 ${rounded} items-center`}
      >
        <div>
          <p className="text-primaryColor font-Outfit font-bold">
            {course.className}
          </p>
        </div>
        <div>
          <p className="text-primaryColor font-Outfit font-bold">
            {students.length}
          </p>
        </div>
        <div className="flex gap-5">
          <div className="rounded-full p-2 hover:bg-red-50 cursor-pointer">
            <DeleteIcon className="text-red-900" />
          </div>
          <div className="rounded-full p-2 hover:bg-green-50 cursor-pointer">
            <EditIcon className="text-primaryColor" />
          </div>
          <div className="rounded-full p-2 hover:bg-green-50 cursor-pointer">
            <ArrowDropDownIcon
              className="text-primaryColor"
              onClick={() => {
                setShowStudents(!showStudents);
              }}
            />
          </div>
        </div>
      </div>
      <div
        className={`flex flex-col justify-between bg-white shadow-lg px-5 py-3 rounded-b-xl items-start max-h-96 overflow-y-scroll gap-2 ${visibility}`}
      >
        <div className="w-full">
          <div className="flex justify-between md:w-full ">
            <h1 className="text-lg font-bold text-primaryColor">
              Student List
            </h1>
            <div className="hidden md:visible px-4 py-2 rounded-3xl bg-white md:flex items-center">
              <SearchIcon className="text-primaryColor" />
              <input
                type="text"
                className="px-2 outline-none text-gray-500 font-Outfit"
                placeholder="Search"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
          </div>
          <hr className="w-full pb-1" />
        </div>
        {filteredStudents.map((student) => (
          <StudentCard key={student.id} student={student} />
        ))}
      </div>
    </div>
  );
}

export default ClassCard;
