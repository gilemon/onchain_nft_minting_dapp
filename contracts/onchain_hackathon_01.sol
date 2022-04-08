// SPDX-License-Identifier: MIT

// Amended by Gilemon
// from https://github.com/HashLips/hashlips_nft_minting_dapp
// see at 0x15AcfD69842B52B5ef4c7c57a6468FFf96bB146C
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

contract OnChainPicture is ERC721Enumerable, Ownable {
  using Strings for uint256;
   struct Picture { 
      string name;
      string description;
      string pix1;
      string pix2;
      string pix3;
      string pix4;
      string pix5;
      string pix6;
      string pix7;
      string pix8;
      string pix9;
   }
  
  mapping (uint256 => Picture) public pictures;
  
  constructor() ERC721("OnChain Picture", "OCP") {}

  // public
  function mint(string memory _mintedBy, string memory _pix1, string memory _pix2, string memory _pix3, string memory _pix4, string memory _pix5, string memory _pix6, string memory _pix7, string memory _pix8, string memory _pix9) public payable {
    uint256 supply = totalSupply();
    require(supply + 1 <= 100); //only 100 tokens
    
    Picture memory newPicture = Picture(
        string(abi.encodePacked('OCP #', uint256(supply + 1).toString())), 
        _mintedBy,
        _pix1,
        _pix2,
        _pix3,
        _pix4,
        _pix5,
        _pix6,
        _pix7,
        _pix8,
        _pix9);
    
    if (msg.sender != owner()) {
      require(msg.value >= 0.005 ether);
    }
    
    pictures[supply + 1] = newPicture;
    _safeMint(msg.sender, supply + 1);
  }

  function buildImage(uint256 _tokenId) public view returns(string memory) {
      Picture memory currentPicture = pictures[_tokenId];
      return Base64.encode(bytes(
          abi.encodePacked(
              '<svg width="300" height="300" xmlns="http://www.w3.org/2000/svg">',
              '<rect height="100" width="100" fill="#',currentPicture.pix1,'" x="0" y="0"/>',
              '<rect height="100" width="100" fill="#',currentPicture.pix2,'" x="100" y="0"/>',
              '<rect height="100" width="100" fill="#',currentPicture.pix3,'" x="200" y="0"/>',
              '<rect height="100" width="100" fill="#',currentPicture.pix4,'" x="0" y="100"/>',
              '<rect height="100" width="100" fill="#',currentPicture.pix5,'" x="100" y="100"/>',
              '<rect height="100" width="100" fill="#',currentPicture.pix6,'" x="200" y="100"/>',
              '<rect height="100" width="100" fill="#',currentPicture.pix7,'" x="0" y="200"/>',
              '<rect height="100" width="100" fill="#',currentPicture.pix8,'" x="100" y="200"/>',
              '<rect height="100" width="100" fill="#',currentPicture.pix9,'" x="200" y="200"/>',
              '<text x="20" y="280" fill="#fff" font-size="12" font-family="Arial, Helvetica, sans-serif">',currentPicture.description,'</text>',
              '</svg>'
          )
      ));
  }
  
  function buildMetadata(uint256 _tokenId) public view returns(string memory) {
      Picture memory currentPicture = pictures[_tokenId];
      return string(abi.encodePacked(
              'data:application/json;base64,', Base64.encode(bytes(abi.encodePacked(
                          '{"name":"', 
                          currentPicture.name,
                          '", "description":"OnChain Picture for Hackathon token minted by ', 
                          currentPicture.description,
                          '", "attributes":"[',
                          '{"trait_type": "pix1", "value": "',currentPicture.pix1,'"},'
                          '{"trait_type": "pix2", "value": "',currentPicture.pix2,'"},'
                          '{"trait_type": "pix3", "value": "',currentPicture.pix3,'"},'
                          '{"trait_type": "pix4", "value": "',currentPicture.pix4,'"},'
                          '{"trait_type": "pix5", "value": "',currentPicture.pix5,'"},'
                          '{"trait_type": "pix6", "value": "',currentPicture.pix6,'"},'
                          '{"trait_type": "pix7", "value": "',currentPicture.pix7,'"},'
                          '{"trait_type": "pix8", "value": "',currentPicture.pix8,'"},'
                          '{"trait_type": "pix9", "value": "',currentPicture.pix9,'"}'
                          ']", "image": "', 
                          'data:image/svg+xml;base64,', 
                          buildImage(_tokenId),
                          '"}')))));
  }

  function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
      require(_exists(_tokenId),"ERC721Metadata: URI query for nonexistent token");
      return buildMetadata(_tokenId);
  }

  function withdraw() public payable onlyOwner {
    // This will payout the owner of the contract balance.
    // Do not remove this otherwise you will not be able to withdraw the funds.
    // =============================================================================
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
    // =============================================================================
  }
}
