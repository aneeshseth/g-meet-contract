import React, { useState } from "react";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

function Schedule({ meetingFee, web3, calendarContract }) {
  const [selectedDate, setSelectedDate] = useState(null);
  const handleScheduleSession = async () => {
    const accounts = await web3.eth.getAccounts();
    calendarContract.methods
      .scheduleSession(
        "https://meet.google.com/kkf-qdkh-hwb",
        Math.floor(selectedDate.getTime() / 1000)
      )
      .send({ from: accounts[0], value: web3.utils.toWei(meetingFee, "ether") })
      .on("transactionHash", (hash) => {
        alert(hash);
      })
      .on("receipt", (receipt) => {
        console.log(receipt);
      })
      .on("error", (err) => {
        console.log(err);
      });
  };
  return (
    <div>
      <h2>Select Meeting Date and Time</h2>
      <DatePicker
        selected={selectedDate}
        onChange={(date) => setSelectedDate(date)}
        showTimeSelect
        timeFormat="HH:mm"
        timeIntervals={15}
        dateFormat="MMMM d, yyyy h:mm aa"
      />
      <button onClick={handleScheduleSession}>Schedule Session</button>
    </div>
  );
}

export default Schedule;
