pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// @TODO: Inherit the crowdsale contracts
contract PupperCoinCrowdsale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {


    constructor(
        
        uint rate, 
        PupperCoin token, 
        address payable wallet, 
        uint goal, 
        uint open,
        uint close


    )
        
    Crowdsale(rate, wallet, token)
    TimedCrowdsale(now, now + 24 weeks)
    CappedCrowdsale(goal)
    RefundableCrowdsale(goal)
        public
    {
        // constructor can stay empty
    }
}

contract PupperCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;


    constructor(
       
        string memory name,
        string memory symbol,
        address payable wallet, 
        uint goal
        
        

    )
        public
    {
        
        PupperCoin token = new PupperCoin(name, symbol, 0);
        token_address = address(token);

        PupperCoinCrowdsale token_sale = new PupperCoinCrowdsale(1, token, wallet, goal, now, now + 24 weeks);
        token_sale_address = address(token_sale);
        

        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}
