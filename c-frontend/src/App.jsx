import { useState, useEffect } from "react";
import "./App.css";
import { Routes, Route } from "react-router-dom";
import Schedule from "./Components/Schedule";
import { calendarABI } from "./ABI";

function App() {
  const [web3, setWeb3] = useState(null);
  const [calendarContract, setCalendarContract] = useState(null);
  const [meetingFee, setMeetingFee] = useState("");
  const contractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138";
  useEffect(() => {
    if (window.ethereum) {
      window.ethereum
        .request({ method: "eth_requestAccounts" })
        .then(() => {
          const web3Instance = new Web3(window.ethereum);
          setWeb3(web3Instance);
          const calendarInstance = new web3Instance.eth.Contract(
            calendarABI,
            contractAddress
          );
          setCalendarContract(calendarInstance);
          calendarInstance.methods
            .sessionFee()
            .call()
            .then((fee) => {
              setMeetingFee(web3Instance.utils.fromWei(fee, "ether"));
            });
        })
        .catch((err) => {
          console.error(err);
        });
    } else {
      alert("No wallet available");
    }
  }, []);
  return (
    <Routes>
      <Route
        path="/"
        element={
          <Schedule
            meetingFee={meetingFee}
            web3={web3}
            calendarContract={calendarContract}
          />
        }
      />
    </Routes>
  );
}

export default App;
