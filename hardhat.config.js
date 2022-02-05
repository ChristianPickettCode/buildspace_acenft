require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    ropsten: {
      url: process.env.STAGING_ROPSTEN_ALCHEMY_KEY,
      accounts: [process.env.PRIVATE_KEY],
    },
    rinkeby: {
      url: process.env.STAGING_RINKEBY_ALCHEMY_KEY,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: {
      rinkeby: process.env.ETHERSCAN_KEY,
    },
  },
};
