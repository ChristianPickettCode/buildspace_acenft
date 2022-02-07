const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory("AceNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);

  let txn;

  for (let index = 13; index < 26; index++) {
    txn = await nftContract.mint(index);
    await txn.wait();
  }

  txn = await nftContract.mint(0);
  await txn.wait();

  txn = await nftContract.mintSet([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]);
  await txn.wait();

  for (let index = 0; index < 13; index++) {
    txn = await nftContract.mint(index);
    await txn.wait();
  }
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
