
pragma solidity ^0.5.10;



contract airplane{
    function pushFlightDetails(uint _ufn,string memory _flightNumber,string memory _DOF,string memory _depature,string memory _arrival) public {}
    function updateActual(uint _ufn,uint _actualDepature,uint  _actualArrival) public{}
    function searchFlightLate(uint flight) public view returns(bool){}
}

contract crowdurance {

    address airplaneAddress;

    airplane aiplaneContract;

    constructor(address _contractAddress) public{
        airplaneAddress=_contractAddress;
        aiplaneContract=airplane(airplaneAddress);
    }

    struct claimDetails{
        string DOI;
        uint amountProposed;
        string details;
    }

    struct policyHolderStruct{
        uint policyId;
        address owner;
        string name;
        uint premiumAmount;
        string details;
        uint flightNo;
        bool rc;
        //claimDetails[] myclaims;
    }

    mapping(uint=>policyHolderStruct) public PolicyHolders;
      uint public poolBalance=0;
    uint[] public allPolicyHolders; 

    event policyCreateEvent(uint,address,string,uint);
    event claimRequested(uint,address,string,string);


    function createPolicy(uint _policyId,string memory _name,string memory _details,uint _flightNo) public payable {
        policyHolderStruct memory newPolicyHolder;

        newPolicyHolder.policyId=_policyId;
        newPolicyHolder.owner=msg.sender;
        newPolicyHolder.name=_name;
        newPolicyHolder.premiumAmount=1;
        newPolicyHolder.details=_details;
        newPolicyHolder.flightNo=_flightNo;
        newPolicyHolder.rc=false;


        poolBalance+=1;

        //add in allpolicyholders
        PolicyHolders[_policyId]=newPolicyHolder;

        emit policyCreateEvent(_policyId,msg.sender,_name,1);
    }

    function getPoolBalance() public returns(uint){
        return poolBalance;
    }


    function ClaimInsurance(uint _policyId, string memory _DOI,string memory _details,uint _amountProposed) public payable returns(bool){

        claimDetails memory newClaim;
        newClaim.DOI=_DOI;
        newClaim.details=_details;
        newClaim.amountProposed=_amountProposed;

        //PolicyHolders[_policyId].myclaims.push(newClaim);

        if(aiplaneContract.searchFlightLate(PolicyHolders[_policyId].flightNo))
        {
            (msg.sender).transfer(_amountProposed);
            emit claimRequested(_policyId,msg.sender,_DOI,_details);
            return true;
        }
        else
        {
            return false;
        }

    }
    
    
    function claimReward(uint _policyId) public payable{
     if(PolicyHolders[_policyId].rc==false){
         (msg.sender).transfer(500000000000000000);
         PolicyHolders[_policyId].rc=true;
     }
        
    }

   

}
