
contract owned {
    address public owner;
    
 
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
 

    /* Initializes contract with initial  the creator of the contract */
    function DEDEPool() owned() public { }
 
 
   function JoinNode(address nodeadd,uint256 quota) onlyOwner  public  returns(bool)  {
       if(nodepools[nodeadd].quota==0){
           nodepools[nodeadd].quota=quota;
           nodepools[nodeadd].release=0;
           nodepools[nodeadd].balance=0;
       }
       return true;
  }
  
     function ReleaseToNode(address nodeadd,uint256 release) onlyOwner  public  returns(bool)  {
       if(nodepools[nodeadd].quota>0){
           nodepools[nodeadd].release +=release;
           nodepools[nodeadd].balance=nodepools[nodeadd].quota-nodepools[nodeadd].release;
           return true;
       }
       return false;
  }
  
  function GetNodeInfo(address nodeadd)  public 
  returns(uint256,uint256,uint256){
       return (nodepools[nodeadd].quota,nodepools[nodeadd].release,nodepools[nodeadd].balance);
  }
}
