// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
contract staking {


    address tokenContractAddr;
    address boredApeContract = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;
    struct stakeDetails {
        uint stakeDate;
        uint stakeBal;
    }

    constructor (address _tokenContractAddr) {
        tokenContractAddr = _tokenContractAddr;
    }

    mapping (address => stakeDetails) stakings;

   

    function stake(uint _amount) public {
        checkForToken();
        deposit(_amount);
        stakeDetails storage sk = stakings[msg.sender];
        sk.stakeDate = block.timestamp;
        sk.stakeBal += _amount;
    }

    function deposit (uint _amount)public {
        IERC20(tokenContractAddr).transferFrom(msg.sender, address(this), _amount);
    }

    function checkForToken () public view  {
        uint boredBal = IERC721(boredApeContract).balanceOf(msg.sender);
        require(boredBal > 0, "you can't stake without boredApe");
        // uint tokenBal = IERC20(tokenContractAddr).balanceOf(msg.sender);
        // require(tokenBal > 0, "You dont have this token");
    }

     function withdraw ()public  {
        stakeDetails storage sk = stakings[msg.sender];
        uint balance = sk.stakeBal;
        uint totalTime =  block.timestamp - sk.stakeDate ;
        uint gain = ((balance / 25920000) * totalTime);
        uint withdrawal = gain + balance;
        sk.stakeBal = 0;
        IERC20(tokenContractAddr).transfer(msg.sender, withdrawal);
    }

}