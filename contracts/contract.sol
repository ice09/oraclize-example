import "lib/std.sol";
import "lib/oraclizeAPI.sol";

contract FinalWinner is named("FinalWinner"), mortal, usingOraclize {

  using strings for * ;

  string public winner;
  uint public winAmount;
  Bet[] public allBets;
  address[] public allWins;

  struct Bet {
    address player;
    string team;
  }

  function FinalWinner() {
    oraclize_setNetwork(networkID_consensys);
  }

  function __callback(bytes32 myid, string result) {
    log0('__callback');
    if (msg.sender != oraclize_cbAddress()) 
      throw;
    
    winner = result;

    uint wins = 0;
    uint loses = 0;

    for (uint i = 0; i < allBets.length; i++) {
      if (winner.toSlice().compare(allBets[i].team.toSlice()) == 0) {
        wins += 1;
        allWins.push(allBets[i].player);
      } else {
        loses += 1;
      }
    }
    winAmount = wins + loses / wins;
  }

  function claim() {
    log0(bytes32(allWins.length));

    for (uint j = 0; j < allWins.length; j++) {
      log0(bytes32(allWins[j]));
      if (!allWins[j].send(winAmount * 1000000000000000000)) {
        log0('uhoh');
      } else {
        delete(allWins[j]);
      }
    }
  }

  function bet(string team) {
    if (msg.value != 1 ether) {
      log0('nonono');
      throw;
    }
    allBets.push(Bet(msg.sender, team));
  }

  function update() {
    oraclize_query("URL", "json(https://blockchainers.by.ether.camp:8080/web/euro2016winner.json).winner");
  }
}
