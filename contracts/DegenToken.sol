// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 1. To mint tokens = _mint()
// 2. To transfer tokens = _transfer()
// 3. To burn tokens = _burn()

contract DegenToken is ERC20 {

    string public tokenName = "DEGEN GAME";
    string public tokenSymbol = "DGNG";
    mapping (address => string[]) purchases;
    address public owner;


    constructor() ERC20(tokenName, tokenSymbol){
        _mint(msg.sender, 10000);
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Sorry! only owner can mint tokens!");
        _;
    }

    // Mint function
    function mintTokens(address _receiver, uint256 _tokens) public onlyOwner{
        require(_receiver != address(0), "This address doesn't exist");
        require(_tokens > 0, "You can't mint negative number of tokens");
        _mint(_receiver, _tokens);
    }

    // Game Shop
    function shopItems() public pure returns(string memory) {
        return "1. KRAMPUS SKIN [800 DGN] 2.SHOGUN SKIN [600 DGN] 3. RAPTOR SKIN [250 DGN] 4. SCOUNDREL [175 DGN]";
    }

    // Function to redeem tokens
    function redeemTokens(uint _ch) external{
        require(_ch <= 4,"Wrong option selected!");

        if(_ch == 1){
            require(balanceOf(msg.sender)>=800, "Oops! Insufficient Tokens");
            _burn(msg.sender, 800);
            purchases[msg.sender].push("KRAMPUS SKIN");
        }

        else if(_ch ==2){
            require(balanceOf(msg.sender) >= 600, "Oops! Insufficient Tokens");
            _burn(msg.sender, 600);
            purchases[msg.sender].push("SHOGUN SKIN");
        }

        else if(_ch == 3){
            require(balanceOf(msg.sender) >= 250, "Oops! Insufficient Tokens");
            _burn(msg.sender, 250);
            purchases[msg.sender].push("RAPTOR SKIN");
        }

        else{
            require(balanceOf(msg.sender) >= 175, "Oops! Insufficient Tokens");
            _burn(msg.sender, 175);
            purchases[msg.sender].push("SCOUNDREL");
        }

    }

    function myPurchases() public view returns (string[] memory, uint256){
        uint256 length = purchases[msg.sender].length;
        require(length > 0, "No purchases found for this address");
        return (purchases[msg.sender], length);
    }
    
    // Transfer Tokens Function
    function transferTokens(address _reciever, uint _tokens) external{
        require(balanceOf(msg.sender) >= _tokens, "Sorry, not enough balance in wallet.");
        transfer(_reciever, _tokens);
    }

    // Function to check token balance
    function checkTokenBalance() external view returns(uint){
        return balanceOf(msg.sender);
    }

    // Function to burn tokens
    function burnTokens(uint _tokens) external{
        require(balanceOf(msg.sender)>= _tokens, "You don't have enough tokens!");
        _burn(msg.sender, _tokens);
    }

}
