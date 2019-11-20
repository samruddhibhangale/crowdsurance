pragma solidity ^0.5.10;


contract airplane{

    struct flightDetails{
        uint flightNumber;
        string DOF;
        uint depature;
        uint arrival;
        uint actualDepature;
        uint actualArrival;
    }

    mapping(uint => flightDetails) allFlightDetails;
    
    function pushFlightDetails(uint _flightNumber,string memory _DOF,uint _depature,uint _arrival) public {
    
            flightDetails memory newflightDetails;
    
            newflightDetails.flightNumber=_flightNumber;
            newflightDetails.DOF=_DOF;
            newflightDetails.depature=_depature;
            newflightDetails.arrival=_arrival;
            newflightDetails.actualDepature=25;
            newflightDetails.actualArrival=25;
    
            allFlightDetails[_flightNumber]=newflightDetails;
    }
    
    function updateActual(uint _flightNumber,uint _actualDepature,uint  _actualArrival) public
    {
            allFlightDetails[_flightNumber].actualDepature=_actualDepature;
            allFlightDetails[_flightNumber].actualArrival=_actualArrival;   
    }
    
    function searchFlightLate(uint _flightNumber) public view returns(bool)
    {
        if(allFlightDetails[_flightNumber].actualArrival>allFlightDetails[_flightNumber].arrival)
        {
            return true;
        }
        else{
            return false;
        }
    }
    
    
    function getInfo(uint _flightNumber) public view returns(uint ,string memory ,uint ,uint ,uint ,uint  )  {


return (allFlightDetails[_flightNumber].flightNumber,allFlightDetails[_flightNumber].DOF,allFlightDetails[_flightNumber].depature,allFlightDetails[_flightNumber].arrival,allFlightDetails[_flightNumber].actualDepature,allFlightDetails[_flightNumber].actualArrival);
    }
}
