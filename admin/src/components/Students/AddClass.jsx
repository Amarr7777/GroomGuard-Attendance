import React, { useState, useEffect } from "react";
import CloseIcon from "@mui/icons-material/Close";
import { collection, getDocs, query, where, addDoc } from "firebase/firestore";
import { firestore } from "../../firebase/config";

function AddCourse({ handleCourseModal, onCourseAdded }) {
  const [courseName, setCourseName] = useState("");
  const [courseCode, setCourseCode] = useState("");
  const [selectedTeachers, setSelectedTeachers] = useState([]);
  const [selectedClasses, setSelectedClasses] = useState([]);
  const [teachers, setTeachers] = useState([]);
  const [classes, setClasses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const fetchTeachersAndClasses = async () => {
      try {
        // Fetch teachers
        const teacherQuery = query(
          collection(firestore, "users"),
          where("role", "==", "Teacher")
        );
        const teachersSnapshot = await getDocs(teacherQuery);
        const teachersList = teachersSnapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        setTeachers(teachersList);

        // Fetch classes
        const classesSnapshot = await getDocs(collection(firestore, "classes"));
        const classesList = classesSnapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        setClasses(classesList);

        setLoading(false);
      } catch (error) {
        console.error("Error fetching teachers and classes:", error);
        setError("Failed to load data. Please try again later.");
        setLoading(false);
      }
    };

    fetchTeachersAndClasses();
  }, []);

  const handleFormSubmit = async (e) => {
    e.preventDefault();

    // Validate input
    if (!courseName || !courseCode) {
      setError("Course name and course code are required.");
      return;
    }
    if (selectedTeachers.length === 0 || selectedClasses.length === 0) {
      setError("Please select at least one teacher and one class.");
      return;
    }

    try {
      await addDoc(collection(firestore, "courses"), {
        courseName,
        courseCode,
        teacherIds: selectedTeachers,
        classIds: selectedClasses,
      });
      onCourseAdded(); // Notify parent component about the new course
      handleCourseModal(); // Close the modal after successful submission
    } catch (error) {
      console.error("Error adding course:", error);
      setError("Failed to add course. Please try again.");
    }
  };

  const handleTeacherChange = (id) => {
    setSelectedTeachers((prevSelectedTeachers) =>
      prevSelectedTeachers.includes(id)
        ? prevSelectedTeachers.filter((teacherId) => teacherId !== id)
        : [...prevSelectedTeachers, id]
    );
  };

  const handleClassChange = (id) => {
    setSelectedClasses((prevSelectedClasses) =>
      prevSelectedClasses.includes(id)
        ? prevSelectedClasses.filter((classId) => classId !== id)
        : [...prevSelectedClasses, id]
    );
  };

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <div className="absolute flex justify-center items-center inset-0 bg-transparent backdrop-blur-md w-full z-50">
      <div className="bg-white p-4 rounded-md shadow-md w-96 mx-auto">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-lg font-bold text-primaryColor">Add Course</h2>
          <div onClick={handleCourseModal} className="cursor-pointer">
            <CloseIcon className="text-gray-500" />
          </div>
        </div>
        <hr />
        {error && <p className="text-red-500 text-sm">{error}</p>}
        <form className="space-y-4 mt-2" onSubmit={handleFormSubmit}>
          <div className="flex flex-col space-y-2">
            <label className="text-sm text-gray-600">Course Name</label>
            <input
              type="text"
              placeholder="Enter course name"
              className="border border-gray-300 p-2 rounded-md"
              value={courseName}
              onChange={(e) => setCourseName(e.target.value)}
              required
            />
          </div>
          <div className="flex flex-col space-y-2">
            <label className="text-sm text-gray-600">Course Code</label>
            <input
              type="text"
              placeholder="Enter course code"
              className="border border-gray-300 p-2 rounded-md"
              value={courseCode}
              onChange={(e) => setCourseCode(e.target.value)}
              required
            />
          </div>
          <div className="flex flex-col space-y-2">
            <label className="text-sm text-gray-600">Select Teacher(s)</label>
            <div className="space-y-2 max-h-32 overflow-y-scroll">
              {teachers.map((teacher) => (
                <div key={teacher.id} className="flex items-center space-x-2">
                  <input
                    type="checkbox"
                    value={teacher.id}
                    onChange={() => handleTeacherChange(teacher.id)}
                    checked={selectedTeachers.includes(teacher.id)}
                  />
                  <span>{teacher.name}</span>
                </div>
              ))}
            </div>
          </div>
          <div className="flex flex-col space-y-2 ">
            <label className="text-sm text-gray-600">Select Classes</label>
            <div className="space-y-2 max-h-32 overflow-y-scroll">
              {classes.map((classItem) => (
                <div key={classItem.id} className="flex items-center space-x-2">
                  <input
                    type="checkbox"
                    value={classItem.id}
                    onChange={() => handleClassChange(classItem.id)}
                    checked={selectedClasses.includes(classItem.id)}
                  />
                  <span>{classItem.className}</span>
                </div>
              ))}
            </div>
          </div>
          <button
            type="submit"
            className="px-5 py-2 bg-primaryColor text-white rounded-md hover:bg-white hover:border hover:border-primaryColor hover:text-primaryColor"
          >
            Add Course
          </button>
        </form>
      </div>
    </div>
  );
}

export default AddCourse;
