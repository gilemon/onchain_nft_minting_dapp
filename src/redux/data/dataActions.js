// log
import store from "../store";

const fetchDataRequest = () => {
  return {
    type: "CHECK_DATA_REQUEST",
  };
};

const fetchDataSuccess = (payload) => {
  return {
    type: "CHECK_DATA_SUCCESS",
    payload: payload,
  };
};

const fetchDataFailed = (payload) => {
  return {
    type: "CHECK_DATA_FAILED",
    payload: payload,
  };
};

export const fetchData = () => {
  return async (dispatch) => {
    dispatch(fetchDataRequest());
    try {
      console.log('yo');
      console.log(store.getState().blockchain.account);
      let svg1 = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCBoZWlnaHQ9IjUwMCIgd2lkdGg9IjUwMCIgZmlsbD0iaHNsKDI2OCwgNTAlLCAyNSUpIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGRvbWluYW50LWJhc2VsaW5lPSJtaWRkbGUiIGZpbGw9ImhzbCgyMzksIDEwMCUsIDgwJSkiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGZvbnQtc2l6ZT0iNDEiPm5vIHRva2VuIGluIGhlcmUgKHlldCk8L3RleHQ+PC9zdmc+";
      let svg2 = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCBoZWlnaHQ9IjUwMCIgd2lkdGg9IjUwMCIgZmlsbD0iaHNsKDI2OCwgNTAlLCAyNSUpIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGRvbWluYW50LWJhc2VsaW5lPSJtaWRkbGUiIGZpbGw9ImhzbCgyMzksIDEwMCUsIDgwJSkiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGZvbnQtc2l6ZT0iNDEiPm5vIHRva2VuIGluIGhlcmUgKHlldCk8L3RleHQ+PC9zdmc+";
      let totalSupply = await store
        .getState()
        .blockchain.smartContract.methods.totalSupply()
        .call();
      // let cost = await store
      //   .getState()
      //   .blockchain.smartContract.methods.cost()
      //   .call();
      if (totalSupply) {
        let dataURI = await store
          .getState()
          .blockchain.smartContract.methods.tokenURI(totalSupply)
          .call();

        const json = Buffer.from(dataURI.substring(29), "base64").toString();
        const result = JSON.parse(json);
        svg1 = result.image;
        
        let balance = await store
          .getState()
          .blockchain.smartContract.methods.balanceOf(store.getState().blockchain.account).call();
        console.log(balance);
        let myLastToken = totalSupply;
        if (balance) {
          //get last owned token ID different from totalSupply;
          let n = balance - 1;
          while ((n >= 0) && (myLastToken == totalSupply)) {
            myLastToken = await store
              .getState()
              .blockchain.smartContract.methods.tokenOfOwnerByIndex(store.getState().blockchain.account, n).call();
            n--;
          }
          console.log(myLastToken);
       }
       console.log(myLastToken);
       let dataURI2 = await store
         .getState()
         .blockchain.smartContract.methods.tokenURI(myLastToken).call();
       const json2 = Buffer.from(dataURI2.substring(29), "base64").toString();
       const result2 = JSON.parse(json2);
       svg2 = result2.image;
     }
      
      dispatch(
        fetchDataSuccess({
          totalSupply,
          svg1,
          svg2
        })
      );
    } catch (err) {
      console.log(err);
      dispatch(fetchDataFailed("Could not load data from contract."));
    }
  };
};

