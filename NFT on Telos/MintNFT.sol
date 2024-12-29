// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MyNFT {

  // Define a Token struct to store NFT information
  struct Token {
    string name;        // NFT name
    string description; // NFT description
    address owner;      // NFT owner address
  }

  // Use mapping to store the information of each NFT
  mapping(uint256 => Token) private tokens;

  // Use mapping to store the list of NFT IDs owned by each address
  mapping(address => uint256[]) private ownerTokens;

  // Record the next available NFT ID.
  uint256 nextTokenId = 1;

  // Create an NFT function to create a new NFT and assign it to the caller.
  function mint(string memory _name, string memory _description) public returns (uint256) { 
    Token memory newNFT = Token(_name, _description, msg.sender);
    tokens[nextTokenId] = newNFT;
    ownerTokens[msg.sender].push(nextTokenId);
    nextTokenId++;
    return nextTokenId-1;
  }

  
  //Create a function to get information on a specified NFT
 function getNFT(uint256 _tokenId) public view returns (string memory name, string memory description, address owner) {
    require(_tokenId >= 1 && _tokenId < nextTokenId, "Invalid token ID");
    Token memory token = tokens[_tokenId];
    name = token.name;
    description = token.description;
    owner = token.owner;
  }

  function getTokensByOwner(address _owner) public view returns(uint256[] memory){
    return ownerTokens[_owner];
}
  function deleteById(address account, uint256 _tokenId) internal {
    uint256[] storage ownerTokenList = ownerTokens[account];

    for (uint256 i = 0; i < ownerTokenList.length; i++) {
      if (ownerTokenList[i] == _tokenId) {
        // Swap the NFT ID with the last element of the array, then delete the last element of the array.
        ownerTokenList[i] = ownerTokenList[ownerTokenList.length - 1];
        ownerTokenList.pop();
        break;
      }
    }
  }

}