const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory("AceNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);

  let txn = await nftContract.mint();
  await txn.wait();
  console.log("Minted NFT #1");

  txn = await nftContract.mint();
  await txn.wait();
  console.log("Minted NFT #2");

  txn = await nftContract.mint();
  await txn.wait();
  console.log("Minted NFT #3");

  txn = await nftContract.mint();
  await txn.wait();
  console.log("Minted NFT #4");

  txn = await nftContract.mint();
  await txn.wait();
  console.log("Minted NFT #5");

  txn = await nftContract.mint();
  await txn.wait();
  console.log("Minted NFT #6");

  txn = await nftContract.mint();
  await txn.wait();
  console.log("Minted NFT #7");
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
