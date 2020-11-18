
contract owned {
    address public owner;
    

    function owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function changeOwner(address newOwner) onlyOwner public {
        owner = newOwner;
    }
}
  
/******************************************/
/*       node pool manager       */
/******************************************/

contract DEDEPool is owned {
    
   struct nodepool {
        uint256 quota;
        uint256 release;
        uint256 balance;
    }
    
    mapping (address => nodepool) public nodepools;
 
 
    function DEDEPool() owned() public {}
 
 
   function JoinNode(address nodeadd,uint256 quota) onlyOwner  public  returns(bool)  {
       if(nodepools[nodeadd].quota==0){
           nodepools[nodeadd].quota=quota;
           nodepools[nodeadd].release=0;
           nodepools[nodeadd].balance=0;
       }
       return true;
  }
  
}
