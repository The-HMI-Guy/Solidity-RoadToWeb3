// Import this file to use console.log
import "hardhat/console.sol";

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Thehmiguy is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter; //initializing counters library

    uint256 MAX_SUPPLY = 100000; //use cap-letters for constants
    uint8 MAX_MINT = 10;

    mapping(address => uint8) public mintCount;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("thehmiguy", "HMI") {}

    function safeMint(address to, string memory uri) public {
        uint256 tokenId = _tokenIdCounter.current();
        require(mintCount[msg.sender] < MAX_MINT, "You may not mint more than 10 NFTs per wallet");
        require(tokenId <= MAX_SUPPLY, "I'm sorry all NFTs have been minted");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        mintCount[msg.sender] += 1; 
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}