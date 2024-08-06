import React from "react";
import EditIcon from "@mui/icons-material/Edit";
import DeleteIcon from "@mui/icons-material/Delete";

function StudentCard() {
  return (
    <div className="flex justify-between bg-white shadow-lg px-5 py-3 rounded-xl items-center">
      <div>
        <p className="text-primaryColor font-Outfit font-bold">4MCAB</p>
      </div>
      <div>
        <p className="text-primaryColor font-Outfit font-bold">63</p>
      </div>
      <div className="flex gap-5">
        <div className="rounded-full p-2 hover:bg-red-50 cursor-pointer">
          <DeleteIcon className="text-red-900" />
        </div>
        <div className="rounded-full p-2 hover:bg-green-50 cursor-pointer">
          <EditIcon className="text-primaryColor" />
        </div>
      </div>
    </div>
  );
}

export default StudentCard;
