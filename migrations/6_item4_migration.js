const Migrations = artifacts.require("Item4");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
