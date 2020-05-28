const Migrations = artifacts.require("Migrations");
var tokoinTest = artifacts.require("./Tokoin.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(tokoinTest);
};