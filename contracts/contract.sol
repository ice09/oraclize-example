import "lib/std.sol";
import "lib/oraclizeAPI.sol";

contract Contract is named("Contract"), mortal, usingOraclize {

  string public ETHXBT;

  function Contract() {
    oraclize_setNetwork(networkID_morden);
  }
  
  function __callback(bytes32 myid, string result) {
    log0('callback');
    if (msg.sender != oraclize_cbAddress()) throw;
    log0('set result');
    ETHXBT = result;
  }
  
  function update() {
    oraclize_query(10, "URL", "json(https://poloniex.com/public?command=returnTicker).BTC_ETH.last");
  }
}
