import Layout from "./components/Layout/Layout";
import alanBtn from "@alan-ai/alan-sdk-web";

function App() {
 const ALAN_API ="86e893def59fa09ea3ab18c2643b5c9e2e956eca572e1d8b807a3e2338fdd0dc/stage";
  useEffect(() => {
    alanBtn({
      key: ALAN_API,
      onCommand: (commandData) => {
        if (commandData.command === "go:back") {
          // Call the client code that will react to the received command
        }
      },
    });
  }, []);
  return <Layout />;
}

export default App;
