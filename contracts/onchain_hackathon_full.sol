// SPDX-License-Identifier: MIT

// Amended by Gilemon
// from https://github.com/HashLips/hashlips_nft_minting_dapp
// https://dev.to/costamatheus97/web3-how-tos-interacting-with-external-smart-contracts-in-solidity-3of1
// see at 0x1ad1C7d5B9C1511fB139EA1751435c5E1E0C706A
/**
    !Disclaimer!
    These contracts have been used to create tutorials,
    and was created for the purpose to teach people
    how to create smart contracts on the blockchain.
    please review this code on your own before using any of
    the following code for production.
    Gilemon will not be liable in any way if for the use 
    of the code. That being said, the code has been tested 
    to the best of the developers' knowledge to work as intended.
*/

pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Base64.sol";

interface OnChainPicture {
    
    function buildMetadata(uint256 _tokenId) external view returns (string memory);
    
}

contract OnChainPictureFull is ERC721Enumerable, Ownable {
    
    address OnChainPictureAddress = 0x15AcfD69842B52B5ef4c7c57a6468FFf96bB146C;
    OnChainPicture OnChainPictureContract = OnChainPicture(OnChainPictureAddress);
    
    string mintedByName;
    
    constructor() ERC721("OnChain Picture Full", "OCPF") {}

    // public
    function mint(string memory _mintedBy) public payable {
      uint256 supply = totalSupply();
      require(supply + 1 <= 10); //only 10 tokens but should be 1?
    
      if (msg.sender != owner()) {
        require(msg.value >= 0.005 ether);
      }
      mintedByName = _mintedBy;
      _safeMint(msg.sender, supply + 1);
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_exists(_tokenId),"ERC721Metadata: URI query for nonexistent token");
        return OnChainPictureContract.buildMetadata(_tokenId);
    }
    
}