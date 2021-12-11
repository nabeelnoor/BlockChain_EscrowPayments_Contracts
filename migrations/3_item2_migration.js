const Migrations = artifacts.require("Item2");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
