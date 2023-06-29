require("@nomiclabs/hardhat-waffle");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.18"},

  paths: {
    // it store compile contract intp the frontend part
    artifacts: "./donate/src/artifacts",
  },
};
