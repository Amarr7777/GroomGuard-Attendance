import React, { useRef, useState } from "react";
import CloseIcon from "@mui/icons-material/Close";
import Webcam from "react-webcam";

function AddTeacher({ SetShowModal }) {
  const [selectedClasses, setSelectedClasses] = useState([]);
  const [capturedImage, setCapturedImage] = useState(null);
  const webcamRef = useRef(null);
  const [showCamera, setShowCamera] = useState(false);

  const classes = ["Class 1", "Class 2", "Class 3", "Class 4"];

  const captureImage = () => {
    const imageSrc = webcamRef.current.getScreenshot();
    setCapturedImage(imageSrc);
    setShowCamera(false);
  };

  const handleFormSubmit = (e) => {
    e.preventDefault();

    if (capturedImage) {
      // Send capturedImage to your server or face recognition API
      console.log("Captured Face Image:", capturedImage);
    }

    // Rest of your form submission logic
  };



  return (
    <div className="absolute flex justify-center items-center inset-0 bg-transparent backdrop-blur-md w-full z-50">
      <div className="bg-white p-4 rounded-md shadow-md w-96 mx-auto">
        <div className="flex justify-between">
          <h2 className="text-lg font-bold mb-4 text-primaryColor">
            Add Teacher
          </h2>
          <div
            onClick={() => {
              SetShowModal(false);
            }}
            className="cursor-pointer"
          >
            <CloseIcon className="text-gray-500" />
          </div>
        </div>
        <hr />
        <form className="space-y-4 mt-2" onSubmit={handleFormSubmit}>
          <div className="flex flex-col space-y-1">
            <label className="text-sm text-gray-600">Name</label>
            <input
              type="text"
              placeholder="Name"
              className="border border-gray-300 p-2 rounded-md"
              required
            />
            {/* <label className="text-sm text-gray-600">Roll Number</label>
              <input
                type="text"
                placeholder="Roll Number"
                className="border border-gray-300 p-2 rounded-md"
                required
              /> */}
               <label className="text-sm text-gray-600">Email</label>
            <input
              type="email"
              placeholder="Email"
              className="border border-gray-300 p-2 rounded-md"
              required
            />
            <label className="text-sm text-gray-600">Courses</label>
            <select
              value={selectedClasses}
              onChange={(e) => {
                const selectedOptions = Array.from(
                  e.target.selectedOptions,
                  (option) => option.value
                );
                setSelectedClasses(selectedOptions);
              }}
              className="border border-gray-300 p-2 rounded-md"
              multiple
              required
            >
              <option value="" disabled className="text-gray-300 p-2">
                Select Classes
              </option>
              {classes.map((className) => (
                <option key={className} value={className}>
                  {className}
                </option>
              ))}
            </select>

           

            <label className="text-sm text-gray-600">Capture Face</label>
            {capturedImage ? (
              <img
                src={capturedImage}
                alt="Captured face"
                className="w-full h-auto"
              />
            ) : (
              <button
                type="button"
                onClick={() => setShowCamera(true)}
                className="border border-gray-300 p-2 rounded-md bg-primaryColor text-white"
              >
                Capture Face
              </button>
            )}

            {showCamera && (
              <div className="flex flex-col items-center">
                <Webcam
                  audio={false}
                  ref={webcamRef}
                  screenshotFormat="image/jpeg"
                  className="w-full h-auto"
                />
                <button
                  type="button"
                  onClick={captureImage}
                  className="mt-2 px-5 py-2 bg-primaryColor text-white rounded-md"
                >
                  Capture
                </button>
              </div>
            )}
          </div>
          <button
            type="submit"
            className="px-5 py-2 bg-primaryColor text-white rounded-md hover:bg-white hover:border hover:border-primaryColor hover:text-primaryColor"
          >
            Add
          </button>
        </form>
      </div>
    </div>
  );
}

export default AddTeacher;
