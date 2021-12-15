const Migrations = artifacts.require("EscrowPayments");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
