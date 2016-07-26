// This is a marker for contracts not to be deployed to  any environment
contract abstract {}

contract owned is abstract {
  address owner;

  function owned() {
    owner = msg.sender;
  }

  function changeOwner(address newOwner) onlyowner {
    owner = newOwner;
  }
  modifier onlyowner() {
    if (msg.sender == owner) _
  }
}

contract mortal is abstract, owned {
  function kill() onlyowner {
    if (msg.sender == owner) suicide(owner);
  }
}

contract NameReg is abstract {
  function register(bytes32 name) {}

  function unregister() {}

  function addressOf(bytes32 name) constant returns(address addr) {}

  function nameOf(address addr) constant returns(bytes32 name) {}

  function kill() {}
}

contract nameRegAware is abstract {
  function nameRegAddress() returns(address) {
    return 0x084f6a99003dae6d3906664fdbf43dd09930d0e3;
  }

  function named(bytes32 name) returns(address) {
    return NameReg(nameRegAddress()).addressOf(name);
  }
}

contract named is abstract, nameRegAware {
  function named(bytes32 name) {
    NameReg(nameRegAddress()).register(name);
  }
}

library strings {

  struct slice {
    uint _len;
    uint _ptr;
  }

  function toSlice(string self) internal returns(slice) {
    uint ptr;
    assembly {
      ptr: = add(self, 0x20)
    }
    return slice(bytes(self).length, ptr);
  }

  function compare(slice self, slice other) internal returns(int) {
    uint shortest = self._len;
    if (other._len < self._len)
      shortest = other._len;

    var selfptr = self._ptr;
    var otherptr = other._ptr;
    for (uint idx = 0; idx < shortest; idx += 32) {
      uint a;
      uint b;
      assembly {
        a: = mload(selfptr)
        b: = mload(otherptr)
      }
      if (a != b) {
        // Mask out irrelevant bytes and check again
        uint mask = ~(2 ** (8 * (32 - shortest + idx)) - 1);
        var diff = (a & mask) - (b & mask);
        if (diff != 0)
          return int(diff);
      }
      selfptr += 32;
      otherptr += 32;
    }
    return int(self._len) - int(other._len);
  }
}
