import React, { useState } from "react";
import SearchIcon from "@mui/icons-material/Search";
import AddIcon from "@mui/icons-material/Add";
import TeacherCard from "./TeacherCard";
import AddTeacher from "./AddTeacher";

function Teachers() {
  const [showModal,SetShowModal] = useState(false);
  return (
    <div className={`min-h-screen w-full ${showModal?'md:fixed':null}`}>
      {showModal ? <AddTeacher SetShowModal={SetShowModal}/> : null}
      <div className="flex w-full justify-end p-4 fixed top-0 right-0 z-50">
        <div className="px-4 py-2 shadow-lg rounded-3xl bg-white flex items-center">
          <SearchIcon className="text-primaryColor" />
          <input
            type="text"
            className="px-2 outline-none text-gray-500 font-Outfit"
          />
        </div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-3 mt-20 gap-16 justify-items-center">
        <TeacherCard />
        <TeacherCard />
        <TeacherCard />
        <TeacherCard />
        <TeacherCard />
        <TeacherCard />
        <TeacherCard />
        <TeacherCard />
        <TeacherCard />
        <TeacherCard />
      </div>
      <div 
      onClick={()=>{
        SetShowModal(!showModal);
      }}
      className="flex justify-center items-center fixed bottom-5 right-5 w-16 h-16 bg-primaryColor rounded-full shadow-lg hover:scale-105 cursor-pointer">
        <AddIcon className="text-white scale-105" />
      </div>
    </div>
  );
}

export default Teachers;
