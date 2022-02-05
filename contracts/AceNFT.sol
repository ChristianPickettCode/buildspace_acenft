// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract AceNFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  string[] deck = [
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/vjdSLhI5WZMYWyZmYlovUFci-UWIllVay45yeAi5W4w",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/KfH-MlRNX56jf3mnnWNQd2Id13h3s0HMlT55MkjzK78",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/ji3-oZj366uHQslC_36i7b97qylbIAkcNit_tOFHdD4",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/IZvz2uggkYSeKaHmW37LLgtqaAW10ZCDSnp8rQJI1UA"
  ];

  event NewAceNFTMinted(address sender, uint256 tokenId);

  constructor() ERC721("AceNFT", "ACE") {
    console.log("This is my NFT contract!");
  }

  function mint() public {
    uint256 newItemId = _tokenIds.current();
    _safeMint(msg.sender, newItemId);
    _setTokenURI(newItemId, pickRandomCard(newItemId));
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    _tokenIds.increment();
    emit NewAceNFTMinted(msg.sender, newItemId);
  }

  function pickRandomCard(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(
      string(abi.encodePacked("CARD", Strings.toString(tokenId)))
    );
    rand = rand % deck.length;
    return deck[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(input)));
  }
}
