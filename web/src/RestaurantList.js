function RestaurantEntry(props) {


    const handleClick = () => {
      props.onClickHandler(props.data.location);
    };
    // Add basic styling for each restaurant entry
    const entryStyle = {
      display: "inline-block",
      padding: "10px",
      margin: "5px",
      border: "1px solid gray",
      borderRadius: "5px",
      cursor: "pointer",
    };
  
    return (
      <div style={entryStyle} onClick={handleClick}>
        {props.data.name}
      </div>
    );
  }
  
  function RestaurantList(props) {
    const entries = props.list;
    const list = entries.map((entry) => {
      return <RestaurantEntry data={entry} onClickHandler={props.onClickHandler} key={Math.random()}></RestaurantEntry>
    });
    return (
      <div id="restaurant-list" style={ {'display': 'grid'} } >
      {list}
      </div>
    )
  }
  
  
export default RestaurantList;