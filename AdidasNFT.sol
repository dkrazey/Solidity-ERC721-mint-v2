// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts@4.4.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.4.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.4.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.4.0/utils/Counters.sol";

contract AdidasMonkey is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 public mintRate = 0.001 ether;
    uint public MAX_SUPPLY = 100;

    constructor() ERC721("Adidas Monkey", "ADID") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://twitter.com/adidasoriginals/photo";
    }

    function safeMint(address to) public payable {
        require(totalSupply() < MAX_SUPPLY, "Can't mint more.");
        require(msg.value >= mintRate, "Not enough Ether sent.");
        _tokenIdCounter.increment();
        _safeMint(to, _tokenIdCounter.current());
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function withdraw() public onlyOwner {
        require(address(this).balance > 0, "Balnce is 0");
        payable (owner()).transfer(address(this).balance);

    }
}
