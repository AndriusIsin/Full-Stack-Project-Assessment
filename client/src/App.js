import "./App.css";
import { useState, useEffect } from "react";
import AddAndSearch from "./Components/AddAndSearch";
import Footer from "./Components/Footer";
import NavBar from "./Components/NavBar";
import VideoList from "./Components/VideoList";
import Welcome from "./Components/Welcome";
import AddVideo from "./Components/AddVideo";
function App() {
  const [keyword, setKeyword] = useState("");
  const [videoCards, setVideoCards] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    fetchVideos();
  }, [videoCards]);
  const fetchVideos = async () => {
    try {
      const response = await fetch(
        "http://ec2-13-41-79-238.eu-west-2.compute.amazonaws.com:4000/videos/"
      );
      if (!response.ok) {
        throw Error(
          `The fetching of videos was not successful. Error: ${response.status}`
        );
      }
      const data = await response.json();
      setVideoCards(data);
      setLoading(false);
      setError(null);
    } catch (error) {
      setError(error.message);
      setLoading(false);
    }
  };

  return (
    <>
      <NavBar />
      <Welcome />
      <AddAndSearch setKeyword={setKeyword} />
      <AddVideo setVideoCards={setVideoCards} videoCards={videoCards} />
      {error ? (
        <h1 className="error-msg "> {error}</h1>
      ) : !loading ? (
        <VideoList
          setKeyword={setKeyword}
          keyword={keyword}
          videoCards={videoCards}
          setVideoCards={setVideoCards}
        />
      ) : (
        <h1 className="blink_me">Loading.....</h1>
      )}
      <Footer />
    </>
  );
}

export default App;
