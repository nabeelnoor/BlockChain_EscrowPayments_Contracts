const Migrations = artifacts.require("Item");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
