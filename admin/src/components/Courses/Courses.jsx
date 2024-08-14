import React from "react";
import CourseCard from "./CourseCard";
import SearchIcon from "@mui/icons-material/Search";
import AddIcon from "@mui/icons-material/Add";

function Courses() {
  return (
    <div className="min-h-screen">
      <div className="flex w-full justify-end p-4 fixed top-0 right-0 z-50">
        <div className="px-4 py-2 shadow-lg rounded-3xl bg-white flex items-center">
          <SearchIcon className="text-primaryColor" />
          <input
            type="text"
            placeholder="Search for a course"
            className="px-2 outline-none text-gray-500 font-Outfit"
          />
        </div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-16 w-full justify-items-center mt-20 ">
        {" "}
        {/* Adjusted margin for spacing */}
        <CourseCard />
        <CourseCard />
        <CourseCard />
        <CourseCard />
        <CourseCard />
        <CourseCard />
        <CourseCard />
        <CourseCard />
        <CourseCard />
        <CourseCard />
      </div>
      <div className="flex justify-center items-center fixed bottom-5 right-5 w-16 h-16 bg-primaryColor rounded-full shadow-lg hover:scale-105 cursor-pointer">
        <AddIcon className="text-white scale-105" />
      </div>
    </div>
  );
}

export default Courses;
