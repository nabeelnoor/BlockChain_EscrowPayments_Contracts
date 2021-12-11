const Migrations = artifacts.require("Item3");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
