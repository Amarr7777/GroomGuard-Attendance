import React, { useState } from "react";
import Sidebar from "./components/sidebar/Sidebar";
import General from "./components/General/General";
import mainBG from "./assets/mainBg.png";
import Students from "./components/Students/Students";
import Courses from "./components/Courses/Courses";
import Teachers from "./components/Teachers/Teachers";
function App() {
  const [renderScreenVal,setRenderScreenVal] = useState(0);
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
      className="flex h-screen"
      style={{
        backgroundImage: `url(${mainBG})`,
        backgroundSize: "cover",
        backgroundPosition: "center",
      }}
    >
      <Sidebar setRenderScreenVal={setRenderScreenVal}/>
      {renderScreen()}
    </div>
  );
}

export default App;
