import React from "react";
import UserIcon from "@mui/icons-material/Person";

function CourseCard({course}) {
  return (
    <div className="w-64 md:w-96 h-56 bg-white shadow-lg rounded-xl  hover:shadow-2xl">
      <div className="w-64 md:w-96 h-24 bg-primaryColor rounded-t-xl flex justify-center items-center">
        <p className="font-Outfit font-bold text-white text-xl">
          {course.courseName}
        </p>
      </div>
      <div className="flex justify-between p-5">
        <div className="flex flex-col">
          <p className="font-Outfit text-lg">Sreedevi R</p>
          <p className="font-Outfit font-thin">{course.courseCode}</p>
        </div>
        <div>
          <p className="font-Outfit text-lg">63</p>
          <UserIcon className="text-primaryColor" />
        </div>
      </div>
    </div>
  );
}

export default CourseCard;
