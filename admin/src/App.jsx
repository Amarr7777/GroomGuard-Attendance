import React, { useState } from "react";
import Sidebar from "./components/sidebar/Sidebar";
import Students from "./components/Students/Students";
import Courses from "./components/Courses/Courses";
import Teachers from "./components/Teachers/Teachers";
import mainBG from "./assets/mainBg.png";

function App() {
  const [renderScreenVal, setRenderScreenVal] = useState(0);

  const renderScreen = () => {
    switch (renderScreenVal) {
      case 0:
        return <Students />;
      case 1:
        return <Courses />;
      case 2:
        return <Teachers />;
      default:
        return <Students />;
    }
  };

  return (
    <div
      className="flex"
      style={{
        backgroundImage: `url(${mainBG})`,
        backgroundSize: "fill",  // Changed to 'cover'
        backgroundPosition: "center",
        backgroundRepeat: "repeat"  // Changed to 'no-repeat'
      }}
    >
      <Sidebar setRenderScreenVal={setRenderScreenVal} />
      <div className="ml-16 flex-grow p-4">
        {renderScreen()}
      </div>
    </div>
  );
}

export default App;
