var Tokoin = artifacts.require("Tokoin");
var date = new Date();

contract('Tokoin', function (accounts) {

  // //-test get
  // it('get contract owner', function(){
  //   var tokoinInstance;
  //   return Tokoin.deployed().then(function(instance){
  //     tokoinInstance = instance;
  //     return tokoinInstance.get();
  //   });
  // });

  //-test get; another form
  // it('get contract owner', async () => {
  //   var tokoinInstance = await Tokoin.deployed();
  //   var tokoinOwner = await tokoinInstance.get.call(accounts[0]);
  // });

  //-test mint
  it('Mint and Grant Tokoin', function(){
    var tokoinInstance;
    return Tokoin.deployed().then(function(instance){
    tokoinInstance = instance;
    return tokoinInstance._mint('0xed9d02e382b34818e88B88a309c7fe71E65f419d', 123, 10, 201906221, 24, 
    '0xed9d02e382b34818e88B88a309c7fe71E65f419d', '0xed9d02e382b34818e88B88a309c7fe71E65f419d');
    //return tokoinInstance._mint(tokoinInstance.contractOwner, 1111);
    });
  });

  //-test _transferFrom
  it('Transfer Tokoin', function(){
    var tokoinInstance;
    return Tokoin.deployed().then(function(instance){
    tokoinInstance = instance;
    return tokoinInstance._transferFrom('0xed9d02e382b34818e88B88a309c7fe71E65f419d', '0x6fcd8fb476453effbf9a657420331851b020dc87', 1);
    });
  });

  //-test _redeemCheckCondition
  it('Redeem Tokoin', function(){
    return Tokoin.deployed().then(function(instance){
    tokoinInstance = instance;
    return tokoinInstance._tokoinRedeem('0x6fcd8fb476453effbf9a657420331851b020dc87', '0x6fcd8fb476453effbf9a657420331851b020dc87', 1);
    });
  });

  //-test _redeemVerification
  it('Identification Check', function(){
    return Tokoin.deployed().then(function(instance){
    tokoinInstance = instance;
    return tokoinInstance._redeemVerification('0x6fcd8fb476453effbf9a657420331851b020dc87', 1);
    });
  });

  //-test _redeemCheckCondition
  it('Reference Check', function(){
    return Tokoin.deployed().then(function(instance){
    tokoinInstance = instance;
    return tokoinInstance._redeemCheckCondition(1);
    });
  });

  //-test _accessOutput
  it('Modify Access Output', function(){
    return Tokoin.deployed().then(function(instance){
    tokoinInstance = instance;
    return tokoinInstance._accessOutput();
    });
  });

  //-test _accessRule
  it('Modify Access Rule', function(){
    return Tokoin.deployed().then(function(instance){
    tokoinInstance = instance;
    return tokoinInstance._accessRule(123, 10, 201906221, 24, 
    '0xed9d02e382b34818e88B88a309c7fe71E65f419d', '0xed9d02e382b34818e88B88a309c7fe71E65f419d', 1);
    });
  });

  //-test _accessRevocation
  it('Modify Access Revocation', function(){
    return Tokoin.deployed().then(function(instance){
    tokoinInstance = instance;
    return tokoinInstance._accessRevocation();
    });
  });

});