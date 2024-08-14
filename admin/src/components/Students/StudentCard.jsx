import React from "react";
import Close from "@mui/icons-material/Close";

function StudentCard({student}) {
  return (
    <div className="flex rounded-xl items-center justify-between shadow-md w-full py-2 px-5">
      <p className="font-Outfit text-primaryColor">{student.name}</p>
      <div className="rounded-full p-2 hover:bg-red-50 cursor-pointer">
        <Close 
        className="text-red-900" />
      </div>
    </div>
  );
}

export default StudentCard;
