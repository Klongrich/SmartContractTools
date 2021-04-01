const KyleCoin = artifacts.require("ERC20");

module.exports = function (deployer) {
    deployer.deploy(KyleCoin, "KyleCoin", "KC", 18, 71400000000);
};
