import React, { useState } from "react";
import CloseIcon from "@mui/icons-material/Close";
import { firestore } from "../../firebase/config";
import { addDoc, collection } from "firebase/firestore";

function AddClass({ handleClassModal, courses }) {
  const [className, setClassName] = useState("");
  const [selectedCourses, setSelectedCourses] = useState([]);

  const handleCourseSelection = (courseId) => {
    setSelectedCourses((prevSelectedCourses) => {
      if (prevSelectedCourses.includes(courseId)) {
        return prevSelectedCourses.filter((id) => id !== courseId);
      } else {
        return [...prevSelectedCourses, courseId];
      }
    });
  };

  const handleFormSubmit = async (e) => {
    e.preventDefault();
    if (className.trim() === "" || selectedCourses.length === 0) {
      alert("Please enter a class name and select at least one course.");
      return;
    }

    try {
      await addDoc(collection(firestore, "classes"), {
        className,
        courses: selectedCourses,
      });
      handleClassModal(); // Close the modal after successful submission
    } catch (error) {
      console.log("Error adding class:", error);
    }
  };

  return (
    <div className="absolute flex justify-center items-center inset-0 bg-transparent backdrop-blur-md w-full z-50">
      <div className="bg-white p-4 rounded-md shadow-md w-96 mx-auto">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-lg font-bold text-primaryColor">Add Class</h2>
          <div onClick={handleClassModal} className="cursor-pointer">
            <CloseIcon className="text-gray-500" />
          </div>
        </div>
        <hr />
        <form className="space-y-4 mt-2" onSubmit={handleFormSubmit}>
          <div className="flex flex-col space-y-2">
            <label className="text-sm text-gray-600">Class Name</label>
            <input
              type="text"
              placeholder="Enter class name"
              className="border border-gray-300 p-2 rounded-md"
              value={className}
              onChange={(e) => setClassName(e.target.value)}
              required
            />
          </div>
          <div className="flex flex-col space-y-2">
            <label className="text-sm text-gray-600">Courses</label>
            <div className="space-y-2 max-h-32 overflow-y-scroll">
              {courses.map((course) => (
                <div key={course.id} className="flex items-center">
                  <input
                    type="checkbox"
                    id={course.id}
                    value={course.id}
                    onChange={() => handleCourseSelection(course.id)}
                    className="mr-2"
                  />
                  <label htmlFor={course.id} className="text-sm text-gray-600">
                    {course.courseName}
                  </label>
                </div>
              ))}
            </div>
          </div>
          <button
            type="submit"
            className="px-5 py-2 bg-primaryColor text-white rounded-md hover:bg-white hover:border hover:border-primaryColor hover:text-primaryColor"
          >
            Add Class
          </button>
        </form>
      </div>
    </div>
  );
}

export default AddClass;
