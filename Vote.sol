//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Strings.sol";

contract Election
{
using Strings for uint256;
address[] admnL;
mapping ( address => bool ) voted;
uint C1;
uint C2;
enum state { off , on }
state public status = state.off ; 

constructor ()
{
admnL.push(msg.sender);
}

function vote ( uint _CID ) public
{
require ( status == state.on , "Voting is not Ongoing");
require ( voted[msg.sender] == false , "Already Voted");
require ( _CID == 1 || _CID == 2 , "Invalid Choice");

if ( _CID == 1 )
{
C1 ++;
}
else
{
C2 ++;
}

voted[msg.sender] = true ;

}

function getVotes() public view returns ( string memory )
{
return string ( abi.encodePacked ( "Candidate 1 : " , C1.toString() , "\nCandidate 2 : " , C2.toString() ) ) ;
}

function isadmn () internal view returns ( bool )
{

bool admn = false;
for (uint i = 0; i < admnL.length; i++)
{
if(admnL[i] == msg.sender)
{
admn = true;
break;
}
}

return admn;
}


function addadmn( address newadmn) public
{

require(isadmn() , "Unauthorised Access");

admnL.push(newadmn);
}

function toggle () public 
{
require(isadmn() , "Unauthorised Access");

if(status == state.off)
{
status = state.on;
}

else
{
status = state.off;
}

}

}
