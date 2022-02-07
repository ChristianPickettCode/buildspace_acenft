// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract AceNFT is ERC721URIStorage, Ownable {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  struct CardData {
    string suit;
    string number;
    uint16 index;
    string url;
  }

  string[] deck = [
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/UUOVIpwH6Qc_tlWEDqZpU20CGRySEXmCvWYvBvLAETk",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/3BsQ_nbwA8P1yFLEU2ItgA_VHRkExL9nIBz3KGvk64w",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/TIzh103dcbE1UltErd9upz3rzXnzpUKne8zDn0p4bm4",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/0lfjHcc_rWGeNYCpX18MGVie6gMbxEbkRYEpODqBVJw",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/lDp_r_ItPMfYD582GGdGGHvvndbBeWCMAIDZnDcopPU",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/mvpsU5JLkpW6vXaOorV8p1Cgfqgx0Y2nOg7Hs4Dti0w",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/uTqf8Q6QlIWiqeTku5sVcOpj8JFsOdZYwGK-wrIQNxg",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/F4RZuzkxL4vhJFUHLuUVfWNizqDezyM14I1aYo7vuLM",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/jQm1jBU3cNxehgoJxBiL6JHcknbuaqO0zXOgZdhWBmo",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/yc_Oi-TRMNcaILawbEHas-LcvZx0ih33EbkA87VE3w0",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/Ozws2Uic5_79s_Gg6o7got1_-NdibCKj5CzAQnwlo-o",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/VAEf5wWf9Qzpcdied8YLFgBWo3COZ7MSlCh0zm4hd7w",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/XuLxzpMdHFlwxnFfrgEXDwN3icgurJjFE0XJ-5WLFcs",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/jZacs0iEwqMY5P9tZ9KjJmaynWwnjdf3NJJXPmM3IcA",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/vS37Fa-hPNCmfx6GWIQyIqy61ovUsUMaEVcQ0uE1t0Q",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/fTtTxd39lDzKWJouzsi5I_Y-POsnSaf1pqzzYoicI0c",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/KrasJqoB4od1ijfGLqgz879aWU_61H3c6kIWagZACKk",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/pphRRlQW7LNJA6gPEO9ersm12RWWSVXo3XnIQQQNQ04",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/74UaeYMJIKc-8TnBUURwOWN4ml9c4OneEACKcUIv8mg",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/8cyy3G9gX4TNyELeHUmv81ZFY6Ah-WowuGe6R7OFkPs",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/SOnlsBg-RKFaz7j7VPmYpPazmlTA3PTLgfbDieHbcCw",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/2Vzjev_1C5ev74VNHAUNLc1hEw3vbsUEfBTcj1b-Idw",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/CNmpv9udjCr8BEdCC6F6-kshe9Bquae1LYwcX394QmU",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/002pFCoG6VFIXpRlQRlcs6csdMIujYTzOvC2dhZcpJs",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/BiYRYhxjFgoQffROLa2jLdpXKvMd5Ex6UZvlpFwOlqs",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/Y84D-xiBl27_hlXgyOTzmJ9ilWB0XubUzLLTx0xTU-8",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/OzMVlXc0-uj7F9O9JWskfFs8e6jr_yQyoJZg9Wt_1QQ",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/vaJZLraOKc3-1299Vn0oD8kd3WBb18QU4NJzd3tW5QQ",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/ezEtkBHYPvQNTLDJm3qVSoj9Tu3Pb7Ur-nw76bRGgR8",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/xG8CZTPjZLsqSAOmM65QC4QSk6674Jn-oxRxddhXz_s",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/LC7XTNCVHXm6uBAAYWZQSVmwckT9J9LmSfuP6vohB8g",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/8G36US-NTVstp2l-t3HH9A2HsA0fDIdtdwcIRv6MSr8",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/MytK_PnsytPMihFI38C9ACGSGYLBjNzOX8kfdKZWkzc",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/WJHNIHmX2KZ5l-SHVB_r09H9zvNRn3NdjCoJxu-5SdU",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/A-fzNJ9rmz1Hf0DT606AcKg_I2dnV8t28HnmFZmZ8zE",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/lnqFp-pFuUl6EK4U41ZOTEFU-e-BGwPSf3Vexa8zE8Q",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/Cg2RS_Yq5T9gwDdB-Zk-xjiKsPx9vd5hC0GDnddQjHE",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/oGfwv_2cTQ00K5G1JbY2nTBXFTMUYq-1Swm4Zi3oHCk",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/Dce6DttMcCuspT-IW9SpAD_Cro_agPGKKQhn8cDSVHw",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/l6KzEuBC0M96qnaun-gc8JcWzEPc7XgwC6zWo7qVv9w",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/qGbKG7_YIsOb5Y9sVG_tnx9sYwdQLU2M_9DDNcDXro0",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/5mSJXQj6rve4aRiYUpPZTXmAZ-3NUU4QlDzLvjImLaQ",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/eHYoQfDIR-_UlV8DVghpjxp4R-lfcUcS5byL2RIY5GQ",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/PmMJuQLQA26WDEFbKLpzmrbs9D-5Wz1qC6euAyRpO6w",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/UtMhaIWBL_119U-UMEP-jDbnzn4mUJLfXcfDvzUyxaY",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/SlKSSgX1eSp019dhl1gQh1LPYBc8jjHLc2ixTjyi58o",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/9ROy6e0e73s9RH3oTgyg7CvE_4c7ga53BpG9mJuTALk",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/6XB2Lc24Tc8KqnkFzBW-yzdOciEjGkOJUMpD0mngUzU",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/5AeaLtbrec0mhsgMWTuy_0mxxUg1DtFGhIqKK6uZIL8",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/y3dyjQfFlBO9-WvqOj3gs76PtZZz8k_YVEhbUmvJkVQ",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/29EmQarajaa1FLRbas75D8cBv_vyFoS43kRJ9_f33ms",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/AiV3RUph6WBbxW_mUwrd51PwZRXbr2tEXNNJPw63qgo"
  ];

  string[] set = [
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/rRsoBfoGSbAomW8kYw8PrJmfWhBYbJrWIsBSNtMP5IM",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/qU3q9C6N7jLDM-HIwXxB_Px27IBRZY4CsP1fY1GWZrc",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/IWSQq36JFFPDdbCFm_WnXQj981tCYk42CNZw-OWazFs",
    "https://5ywn6daenz6poefpjkgs3c2vdgtzsk2vevam6ap7mvc4443iwdfq.arweave.net/5HVGOdg47xipVdEchnK6CDplnilOcgcLFO6W62Ek2WE"
  ];

  uint256 SPADES = 0;
  uint256 DIAMONDS = 13;
  uint256 CLUBS = 26;
  uint256 HEARTS = 39;

  mapping(uint256 => uint256) tokenIdToCardIndex;

  event NewAceNFTMinted(address sender, uint256 tokenId);

  constructor() ERC721("AceNFT", "ACE") {
    console.log("This is my NFT contract!");
  }

  function mint(uint256 index) public onlyOwner {
    uint256 newItemId = _tokenIds.current();
    _safeMint(msg.sender, newItemId);
    _setTokenURI(newItemId, deck[index]);
    tokenIdToCardIndex[newItemId] = index;
    console.log(
      "A CARD NFT w/ ID %s has been minted to %s",
      newItemId,
      msg.sender
    );
    _tokenIds.increment();
    emit NewAceNFTMinted(msg.sender, newItemId);
  }

  function mintCard() public {
    uint256 newItemId = _tokenIds.current();
    _safeMint(msg.sender, newItemId);

    uint256 rand = pickRandomCardIndex(newItemId);
    string memory cardURI = deck[rand];
    _setTokenURI(newItemId, cardURI);

    tokenIdToCardIndex[newItemId] = rand;
    console.log(
      "A CARD NFT w/ ID %s has been minted to %s",
      newItemId,
      msg.sender
    );
    _tokenIds.increment();
    emit NewAceNFTMinted(msg.sender, newItemId);
  }

  function mintDeck() public {
    for (uint256 index = 0; index < deck.length; index++) {
      uint256 newItemId = _tokenIds.current();
      _safeMint(msg.sender, newItemId);
      _setTokenURI(newItemId, deck[index]);
      console.log(
        "A CARD NFT w/ ID %s has been minted to %s",
        newItemId,
        msg.sender
      );
      _tokenIds.increment();
      emit NewAceNFTMinted(msg.sender, newItemId);
    }
  }

  function mintSet(uint256[] memory tokenIdList) public {
    validateSet(tokenIdList);
    uint256 suit = getCardSuit(tokenIdList[0]);

    uint256 newItemId = _tokenIds.current();
    _safeMint(msg.sender, newItemId);

    string memory setURI = set[suit];
    _setTokenURI(newItemId, setURI);

    console.log(
      "A SET NFT w/ ID %s has been minted to %s",
      newItemId,
      msg.sender
    );
    _tokenIds.increment();
    emit NewAceNFTMinted(msg.sender, newItemId);

    for (uint256 index = 0; index < tokenIdList.length; index++) {
      console.log("Burning CARD with ID %s.", tokenIdList[index]);
      _burn(tokenIdList[index]);
    }
  }

  function getCardSuit(uint256 tokenId) private view returns (uint256) {
    uint256 cardIndex = tokenIdToCardIndex[tokenId];
    if (cardIndex < 13) {
      return 0;
    } else if (cardIndex < 26) {
      return 1;
    } else if (cardIndex < 39) {
      return 2;
    } else {
      return 3;
    }
  }

  function validateSet(uint256[] memory tokenIdList) private view {
    require(tokenIdList.length == 13, "Not 13 cards");
    bool[] memory valid = new bool[](13);
    for (uint256 index = 0; index < 13; index++) {
      valid[index] = false;
    }
    for (uint256 index = 0; index < tokenIdList.length; index++) {
      require(msg.sender == ownerOf(tokenIdList[index]), "Not all your tokens");
      uint256 suitIndex = tokenIdToCardIndex[tokenIdList[index]];
      valid[suitIndex % 13] = true;
    }
    for (uint256 index = 0; index < 13; index++) {
      require(valid[index], "Not a full set");
    }
  }

  function pickRandomCardIndex(uint256 tokenId)
    internal
    view
    returns (uint256)
  {
    uint256 rand = random(
      string(abi.encodePacked("CARD", Strings.toString(tokenId)))
    );
    rand = rand % deck.length;
    return rand;
  }

  function random(string memory input) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(input)));
  }
}
