const SafeMath = artifacts.require("SafeMath");
const BankDeposit = artifacts.require("BankDeposit");

module.exports = function (deployer) {
  deployer.deploy(SafeMath);
  deployer.link(SafeMath, BankDeposit);
  deployer.deploy(BankDeposit);
};
