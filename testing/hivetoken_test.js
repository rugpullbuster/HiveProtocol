const defs = require('./defs');
const utils = require('./utils');
var fs = require('fs');
const defGasPrice = '10000000000'; // default gas price in wei (10Gwei)
const defGasLimit = 4000000; // 4M gas limit

/************************************************************************/
/*	                      initialize INI Parser                         */
/************************************************************************/
var ConfigIniParser = require("config-ini-parser").ConfigIniParser;
var delimiter = "\r\n"; //or "\n" for *nux
configParser = new ConfigIniParser(delimiter);
var iniContent = fs.readFileSync('./session.ini', 'utf-8');
configParser.parse(iniContent);
/************************************************************************/
/*	                        initialize Web3                             */
/************************************************************************/
utils.web3.eth.defaultCommon = {customChain: {name: 'bsc-testnet', chainId: 97, networkId: 97}};
/************************************************************************/
/*	                      initialize accounts                           */
/************************************************************************/
// Init mainAccount // 0x96D82296ef04e42Ae3a1dE611445d3EE9486d5C3
const mainAccount = utils.web3.eth.accounts.wallet.add(defs.mainAccPriv);
// Init Account1 // 0x6756183E14ad778818f05A3aF692C2F4b6C7fDE7
const Account1 = utils.web3.eth.accounts.wallet.add(defs.Account1Priv);
// Init Account2 // 0x9230Aa3C6c01cc8760710613091d8a1d601BFb82
const Account2 = utils.web3.eth.accounts.wallet.add(defs.Account2Priv);
// Init Account3 // 0x25115631eE867BCf44CF8Cf003EaF6078198138E
const Account3 = utils.web3.eth.accounts.wallet.add(defs.Account3Priv);
// Init Account4 // 0x103F078eA413bd6Aaab96Fa1B687f36b3f3d0543
const Account4 = utils.web3.eth.accounts.wallet.add(defs.Account4Priv);
// Init testAccount // 0x9f1De4E8c2a63828932e76A75bBc1315e87d10d0
const testAccount = utils.web3.eth.accounts.wallet.add(defs.testAccPriv);

utils.web3.eth.defaultAccount = mainAccount.address;
var pairInitFlag = false, pairContract, liquidity, reserveToken, reserveETH;
/************************************************************************/
/*	                    initialize pancakeswap                          */
/************************************************************************/
var psRouterContract = new utils.web3.eth.Contract(defs.routerABI, defs.pancakeRouter);
psRouterContract.defaultAccount = mainAccount.address;
psRouterContract.options.from = mainAccount.address;
psRouterContract.options.gasPrice = defGasPrice;
psRouterContract.options.gas = defGasLimit;
/************************************************************************/
/*	                  initialize token contract                         */
/************************************************************************/
var tokenContract = new utils.web3.eth.Contract(defs.tokenABI, defs.tokenAddr);
tokenContract.defaultAccount = mainAccount.address;
tokenContract.options.from = mainAccount.address;
tokenContract.options.gasPrice = defGasPrice;
tokenContract.options.gas = defGasLimit;
/************************************************************************/
/*	             initialize presale Generator contract                  */
/************************************************************************/
var presaleGenContract = new utils.web3.eth.Contract(defs.presaleGenABI, defs.presaleGen);
presaleGenContract.defaultAccount = mainAccount.address;
presaleGenContract.options.from = mainAccount.address;
presaleGenContract.options.gasPrice = defGasPrice;
presaleGenContract.options.gas = defGasLimit;
/************************************************************************/
/*                            Test Token                                */
/************************************************************************/
utils.logger.info("*******************************************************");
utils.logger.info("Testing Hive Contract at: " , defs.tokenAddr );
utils.logger.info("Testing session on      : " , new Date().toISOString() );
utils.logger.info("*******************************************************");
testToken();



// Main Test Function
async function testToken() {

  /*
  ////////////////////////////////////////////////////////////////////////
  //                          initialize token                          //
  ////////////////////////////////////////////////////////////////////////
  
  utils.logger.info("Initializing Token:");
  utils.logger.info('--------------------------------------------------------');
  await initToken();
  var intRes = await utils.getTokenBalance(tokenContract, mainAccount.address);
  utils.logger.info("MainAccount Balance     : ", intRes);
  intRes = await utils.getCirculatingSupply(tokenContract);
  utils.logger.info("Circulating Supply      : ", intRes);
  utils.logger.info("\r\nToken Init Test Processed");
  utils.logger.info('--------------------------------------------------------');
  */
  ////////////////////////////////////////////////////////////////////////
  //                           create presale                              //
  ////////////////////////////////////////////////////////////////////////
  
  utils.logger.info("Creating Presale:");
  utils.logger.info('--------------------------------------------------------');
  //await testCreatePresale();

  await testBuyPresale();

  //await testFinalizePresale();

  utils.logger.info('--------------------------------------------------------');
  

  ////////////////////////////////////////////////////////////////////////
  //                           create pair                              //
  ////////////////////////////////////////////////////////////////////////
  /*
  utils.logger.info("Creating Pair:");
  utils.logger.info('--------------------------------------------------------');
  await createPair();

  intRes = await utils.getCirculatingSupply(tokenContract);
  utils.logger.info("Circulating Supply      : ", intRes);
  var trade = await utils.getUserTrade(tokenContract, mainAccount.address, 1);
  utils.logger.info("MainAccount Trade       : ", trade);               // show last trade log of main account
  utils.logger.info("\r\nPair Creation Test Processed");
  utils.logger.info('--------------------------------------------------------');
  */
  ////////////////////////////////////////////////////////////////////////
  //                          test trading                              //
  ////////////////////////////////////////////////////////////////////////
  /*
  var snapshot = await getLastStakingSnapshot(tokenContract);
  utils.logger.info("  current timestamp  :", new Date().toISOString().slice(0, 19).replace('T', ' '));
  var snapTimeStamp = new Date(snapshot.timestamp * 1000);
  utils.logger.info("  snapshot timestamp :", snapTimeStamp.toISOString().slice(0, 19).replace('T', ' '));
  var duration = new Date() - snapTimeStamp;
  var date_diff = new Date( duration );
  var days = Math.floor(duration / 1000 / 60 / (60 * 24));
  utils.logger.info("  duration           :", days + " Days "+ date_diff.getHours() + ":" + date_diff.getMinutes() + ":" + date_diff.getSeconds());
  utils.logger.info("  totStaked          :", snapshot.totStaked);
  utils.logger.info("  totTokenReward     :", snapshot.totTokenReward);
  utils.logger.info("  totETHReward       :", snapshot.totETHReward);
  utils.logger.info("  totTokenClaimed    :", snapshot.totTokenClaimed);
  utils.logger.info("  totETHClaimed      :", snapshot.totETHClaimed);
  */
  /*
  await testTrading();
  utils.logger.info("\r\nTrading Test Processed");
  utils.logger.info('--------------------------------------------------------');
  */  
  ////////////////////////////////////////////////////////////////////////
  //                          test staking                              //
  ////////////////////////////////////////////////////////////////////////
  /*  
  //await testStaking();

  // claim tokens
  //await claimStakingReward();

  await testFinancialCleanup();

  utils.logger.info("\r\nStaking Test Processed");
  utils.logger.info('--------------------------------------------------------');
  */
  
  ////////////////////////////////////////////////////////////////////////
  //                      test LP Liquification                         //
  ////////////////////////////////////////////////////////////////////////
  /*
  await liquifyLPTokens();
  utils.logger.info("\r\nLP Liquification Test Processed");
  utils.logger.info('--------------------------------------------------------');
  */
  
  ////////////////////////////////////////////////////////////////////////
  //	                    remove liquidity                              //
  ////////////////////////////////////////////////////////////////////////
  /*
  await removeLiquidity();
  utils.logger.info('Done');
  */
}

// Initialization Unit
async function initToken() {
    await tokenContract.methods.init([Account1.address,Account2.address,Account3.address,Account4.address]).send({}, function(err, res) {
        if (err) {
            utils.logger.info('Init Failed Error:', err);
            return;
          }
          utils.logger.info('Init Success:',res);
          return;
    });
}

// Presale creation Unit
async function testCreatePresale() {
  // approve router
  var approveHash = await utils.approveSpender(tokenContract, mainAccount.address, defs.presaleGen, BigInt(99999999999999999999999999999999));
  var approveRec = await utils.getTxReceipt(approveHash);
  if(approveRec && approveRec.status){
    utils.logger.info('Presale Approve Success  : ', approveHash);
    await utils.sleep(4000);
      var sBlock = await utils.getBlockNo();
      sBlock += 1000; // 2hrs from now
      var eBlock = sBlock + 86400 ; //3days from sBlock
      var param0 = 41666666666666666667n;          // token amount just for presale = token price * hard cap(bnb)
      var param1 = 13888888888888888889n;          // token price >> how many Hive/BNB in presale >> 0.0000000000072BNB/HVE
      var param2 = 1000000000000000000n;           // max Spend Per Buyer >> 1BNB
      var param3 = 3000000000000000000n;           // hard cap >> 3BNB
      var param4 = 1000000000000000000n;           // soft cap >> 1BNB
      var param5 = 600n;                           // liquidity Percent >> 60%
      var param6 = 8333333333333333334n;           // listing rate >> how many Hive/BNB in listing
      var param7 = BigInt(sBlock);                 // start block
      var param8 = BigInt(eBlock);                 // end block
      var param9 = 100000n;                        // lock Period
      var createPresaleHash = await utils.createPresale(presaleGenContract, mainAccount.address, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9);
      var createPresaleRec = await utils.getTxReceipt(createPresaleHash);
      if(createPresaleRec && createPresaleRec.status){
        utils.logger.info('CreatePresale Success   : ', createPresaleHash);
        var evPresale = createPresaleRec.logs.find(x => x.topics[0].startsWith("0xa62fce43")).data;
        defs.presaleAddr = '0x' + evPresale.substring(26, 66);
        utils.logger.info('Presale Address         : ', defs.presaleAddr);
        evPresale = createPresaleRec.logs.find(x => x.topics[0].startsWith("0xddf252ad")).data;
        var totToken = BigInt(evPresale.substring(0,66));
        utils.logger.info('Total Tokens            : ', totToken);

      }
      else
        utils.logger.info('CreatePresale Failed');
  }
  else
      utils.logger.info('PresaleGen Approve Failed');
}

async function testBuyPresale() {
  /************************************************************************/
  /*	                  initialize presale contract                       */
  /************************************************************************/
  var presaleContract = new utils.web3.eth.Contract(defs.presaleABI, defs.presaleAddr);
  presaleContract.defaultAccount = mainAccount.address;
  presaleContract.options.from = mainAccount.address;
  presaleContract.options.gasPrice = defGasPrice;
  presaleContract.options.gas = defGasLimit;

  var amtETH = utils.web3.utils.toWei('0.5', 'ether');
  var amtToken = 6944444444444444444n; // token price /2 >> 13888888888888888889 / 2
  utils.logger.info('--------------------------------------------------------');
  utils.logger.info('------        Participating in Presale          --------');
  utils.logger.info('--------------------------------------------------------');
  /*
  // main account buy
  utils.logger.info('--------------       Main Account       ----------------');
  var buyPresaleHash = await utils.buyPresaleToken(presaleContract, mainAccount.address, amtToken, amtETH);
  var buyPresaleRec = await utils.getTxReceipt(buyPresaleHash);
  if(buyPresaleRec && buyPresaleRec.status){
    utils.logger.info('BuyPresaleToken Success : ', buyPresaleHash);
    var buyConfirm = await utils.getPresaleBuyer(presaleContract, mainAccount.address);
    utils.logger.info('Balance                 : ', buyConfirm);
  }
  else
    utils.logger.info('BuyPresaleToken Failed');
  
  // Account1 account buy
  utils.logger.info('------------------     Account1     --------------------');
  var buyPresaleHash = await utils.buyPresaleToken(presaleContract, Account1.address, amtToken, amtETH);
  var buyPresaleRec = await utils.getTxReceipt(buyPresaleHash);
  if(buyPresaleRec && buyPresaleRec.status){
    utils.logger.info('BuyPresaleToken Success : ', buyPresaleHash);
    var buyConfirm = await utils.getPresaleBuyer(presaleContract, Account1.address);
    utils.logger.info('Balance                 : ', buyConfirm);
  }
  else
    utils.logger.info('BuyPresaleToken Failed');
  */
  // Account2 account buy
  utils.logger.info('------------------     Account2     --------------------');
  var buyPresaleHash = await utils.buyPresaleToken(presaleContract, Account2.address, amtToken, amtETH);
  var buyPresaleRec = await utils.getTxReceipt(buyPresaleHash);
  if(buyPresaleRec && buyPresaleRec.status){
    utils.logger.info('BuyPresaleToken Success : ', buyPresaleHash);
    var buyConfirm = await utils.getPresaleBuyer(presaleContract, Account2.address);
    utils.logger.info('Balance                 : ', buyConfirm);
  }
  else
    utils.logger.info('BuyPresaleToken Failed');

  // Account3 account buy
  utils.logger.info('------------------     Account3     --------------------');
  var buyPresaleHash = await utils.buyPresaleToken(presaleContract, Account3.address, amtToken, amtETH);
  var buyPresaleRec = await utils.getTxReceipt(buyPresaleHash);
  if(buyPresaleRec && buyPresaleRec.status){
    utils.logger.info('BuyPresaleToken Success : ', buyPresaleHash);
    var buyConfirm = await utils.getPresaleBuyer(presaleContract, Account3.address);
    utils.logger.info('Balance                 : ', buyConfirm);
  }
  else
    utils.logger.info('BuyPresaleToken Failed');

  // Account4 account buy
  utils.logger.info('------------------     Account4     --------------------');
  var buyPresaleHash = await utils.buyPresaleToken(presaleContract, Account4.address, amtToken, amtETH);
  var buyPresaleRec = await utils.getTxReceipt(buyPresaleHash);
  if(buyPresaleRec && buyPresaleRec.status){
    utils.logger.info('BuyPresaleToken Success : ', buyPresaleHash);
    var buyConfirm = await utils.getPresaleBuyer(presaleContract, Account4.address);
    utils.logger.info('Balance                 : ', buyConfirm);
  }
  else
    utils.logger.info('BuyPresaleToken Failed');

  // test account buy
  utils.logger.info('--------------       Test Account       ----------------');
  var buyPresaleHash = await utils.buyPresaleToken(presaleContract, testAccount.address, amtToken, amtETH);
  var buyPresaleRec = await utils.getTxReceipt(buyPresaleHash);
  if(buyPresaleRec && buyPresaleRec.status){
    utils.logger.info('BuyPresaleToken Success : ', buyPresaleHash);
    var buyConfirm = await utils.getPresaleBuyer(presaleContract, testAccount.address);
    utils.logger.info('Balance                 : ', buyConfirm);
  }
  else
    utils.logger.info('BuyPresaleToken Failed');
}

async function testFinalizePresale() {
  /************************************************************************/
  /*	                  initialize Generator contract                     */
  /************************************************************************/
  var presaleContract = new utils.web3.eth.Contract(defs.presaleABI, defs.presaleAddr);
  presaleContract.defaultAccount = mainAccount.address;
  presaleContract.options.from = mainAccount.address;
  presaleContract.options.gasPrice = defGasPrice;
  presaleContract.options.gas = defGasLimit;
  utils.logger.info('--------------------------------------------------------');
  utils.logger.info('------           Finalizing Presale             --------');
  utils.logger.info('--------------------------------------------------------');
  
  var finPresaleHash = await utils.finalizePresale(presaleContract);
  var finPresaleRec = await utils.getTxReceipt(finPresaleHash);
  if(finPresaleRec && finPresaleRec.status){
    utils.logger.info('FinalizePresale Success : ', finPresaleHash);
    //////////////////////////////////////////////////////
    //    get pair address and enable trading(taxing)
    //////////////////////////////////////////////////////
    var evPair = finPresaleRec.logs.find(x => x.topics[0].startsWith("0x0d3648bd")).data;
    defs.pairAddr = '0x' + evSwap.substring(26,66);
    utils.logger.info('Pair Created            : ', defs.pairAddr);

  }
  else
    utils.logger.info('FinalizePresale Failed');
  

  ///////////////////////////////////////
  //	Initialize trading
  ///////////////////////////////////////
  var initTradeHash = await utils.initializeTrading(tokenContract, defs.pairAddr);
  var initTradeRec = await utils.getTxReceipt(initTradeHash);
  if(initTradeRec && initTradeRec.status){
    utils.logger.info('InitTrading Success     : ', initTradeHash);
  } 
  else
    utils.logger.info('InitTrading Failed');


  //////////////////////////////////////////////////////
  //    claim tokens for participating accounts << should be tax free
  //////////////////////////////////////////////////////
  // main account claim
  utils.logger.info('--------------       Main Account       ----------------');
  var claimPresaleHash = await utils.claimPresaleTokens(presaleContract, mainAccount.address);
  var claimPresaleRec = await utils.getTxReceipt(claimPresaleHash);
  if(claimPresaleRec && claimPresaleRec.status){
    utils.logger.info('claimPresaleTokens Success : ', claimPresaleHash);
    var accBal = await utils.getTokenBalance(tokenContract, mainAccount.address);
    utils.logger.info("Account Token Balance      : ", accBal);
  }
  else
    utils.logger.info('claimPresaleTokens Failed');

  // Account1 account claim
  utils.logger.info('------------------     Account1     --------------------');
  var claimPresaleHash = await utils.claimPresaleTokens(presaleContract, Account1.address);
  var claimPresaleRec = await utils.getTxReceipt(claimPresaleHash);
  if(claimPresaleRec && claimPresaleRec.status){
    utils.logger.info('claimPresaleTokens Success : ', claimPresaleHash);
    var accBal = await utils.getTokenBalance(tokenContract, Account1.address);
    utils.logger.info("Account Token Balance      : ", accBal);
  }
  else
    utils.logger.info('claimPresaleTokens Failed');
  
  // Account2 account claim
  utils.logger.info('------------------     Account2     --------------------');
  var claimPresaleHash = await utils.claimPresaleTokens(presaleContract, Account2.address);
  var claimPresaleRec = await utils.getTxReceipt(claimPresaleHash);
  if(claimPresaleRec && claimPresaleRec.status){
    utils.logger.info('claimPresaleTokens Success : ', claimPresaleHash);
    var accBal = await utils.getTokenBalance(tokenContract, Account2.address);
    utils.logger.info("Account Token Balance      : ", accBal);
  }
  else
    utils.logger.info('claimPresaleTokens Failed');
  
  // Account3 account claim
  utils.logger.info('------------------     Account3     --------------------');
  var claimPresaleHash = await utils.claimPresaleTokens(presaleContract, Account3.address);
  var claimPresaleRec = await utils.getTxReceipt(claimPresaleHash);
  if(claimPresaleRec && claimPresaleRec.status){
    utils.logger.info('claimPresaleTokens Success : ', claimPresaleHash);
    var accBal = await utils.getTokenBalance(tokenContract, Account3.address);
    utils.logger.info("Account Token Balance      : ", accBal);
  }
  else
    utils.logger.info('claimPresaleTokens Failed');

  // Account4 account buy
  utils.logger.info('------------------     Account4     --------------------');
  var claimPresaleHash = await utils.claimPresaleTokens(presaleContract, Account4.address);
  var claimPresaleRec = await utils.getTxReceipt(claimPresaleHash);
  if(claimPresaleRec && claimPresaleRec.status){
    utils.logger.info('claimPresaleTokens Success : ', claimPresaleHash);
    var accBal = await utils.getTokenBalance(tokenContract, Account4.address);
    utils.logger.info("Account Token Balance      : ", accBal);
  }
  else
    utils.logger.info('claimPresaleTokens Failed');

  // test account claim
  utils.logger.info('--------------       Test Account       ----------------');
  var claimPresaleHash = await utils.claimPresaleTokens(presaleContract, testAccount.address);
  var claimPresaleRec = await utils.getTxReceipt(claimPresaleHash);
  if(claimPresaleRec && claimPresaleRec.status){
    utils.logger.info('claimPresaleTokens Success : ', claimPresaleHash);
    var accBal = await utils.getTokenBalance(tokenContract, testAccount.address);
    utils.logger.info("Account Token Balance      : ", accBal);
  }
  else
    utils.logger.info('claimPresaleTokens Failed');

}

// Pair creation Unit
async function createPair() {
    // approve router
    var approveHash = await utils.approveSpender(tokenContract, mainAccount.address, defs.pancakeRouter, BigInt(99999999999999999999999999999999));
    var approveRec = await utils.getTxReceipt(approveHash);
    if(approveRec && approveRec.status){
      utils.logger.info('Router Approve Success  : ', approveHash);
      await utils.sleep(10000);
        var addLiquidityHash = await utils.addPairLiquidity(psRouterContract, BigInt(10000000000000000000), utils.web3.utils.toWei('1', 'ether'));
        var addLiquidityRec = await utils.getTxReceipt(addLiquidityHash);
        if(addLiquidityRec && addLiquidityRec.status){
          utils.logger.info('AddLiquidityETH Success : ', addLiquidityHash);
          defs.pairAddr = '0x' + addLiquidityRec.logs[0].data.substring(26, 66);
          utils.logger.info('Pair Address            : ', defs.pairAddr);
          reserveETH = BigInt(addLiquidityRec.logs[7].data.substring(0,66));
          utils.logger.info('Reserve ETH             : ', reserveETH);
          reserveToken = BigInt('0x' + addLiquidityRec.logs[7].data.substring(66));
          utils.logger.info('Reserve Token           : ', reserveToken);
          liquidity = BigInt(addLiquidityRec.logs[6].data);
          utils.logger.info('Liquidity               : ', liquidity);

          ///////////////////////////////////////
          //	initialize pair contract
          ///////////////////////////////////////
          pairContract = new utils.web3.eth.Contract(defs.pairABI, defs.pairAddr);
          pairContract.defaultAccount = mainAccount.address;
          pairContract.options.from = mainAccount.address;
          pairContract.options.gasPrice = defGasPrice;
          pairContract.options.gas = defGasLimit;
          pairInitFlag = true;

          ///////////////////////////////////////
          //	Initialize trading
          ///////////////////////////////////////
          var initTradeHash = await utils.initializeTrading(tokenContract, defs.pairAddr);
          var initTradeRec = await utils.getTxReceipt(initTradeHash);
          if(initTradeRec && initTradeRec.status){
            utils.logger.info('InitTrading Success     : ', initTradeHash);
          } 
          else
            utils.logger.info('InitTrading Failed');

        }
        else
          utils.logger.info('AddLiquidityETH Failed');
    }
    else
        utils.logger.info('Router Approve Failed');
}

// Trading Unit
async function testTrading() {

  if(!pairInitFlag){                                                    
    pairContract = new utils.web3.eth.Contract(defs.pairABI, defs.pairAddr);
    pairContract.defaultAccount = mainAccount.address;
    pairContract.options.from = mainAccount.address;
    pairContract.options.gasPrice = defGasPrice;
    pairContract.options.gas = defGasLimit;
  }
  var token0 = await utils.getPairToken0(pairContract);
  var reserves = await utils.getPairReserves(pairContract);
  reserveToken = (token0 == defs.tokenAddr) ? BigInt(reserves._reserve0) : BigInt(reserves._reserve1);
  reserveETH = (token0 == defs.tokenAddr) ? BigInt(reserves._reserve1) : BigInt(reserves._reserve0);
  
  var intRes = await utils.isTaxEnabled(tokenContract);
  utils.logger.info("TaxEnabled : ", intRes);
  /*
  // buy 10% of token reserves
  utils.logger.info("-------------------------------------------------------");
  utils.logger.info("---------    Buying 10% of Pair Reserves     ----------");
  var neededToken = reserveToken/10n;
  var neededETH = utils.getAmountIn(neededToken, reserveETH, reserveToken); // calc ETH needed to buy 10% of reserves 
  var buyHash = await utils.buyToken(psRouterContract, testAccount.address, utils.web3.utils.toWei(neededETH.toString(), 'wei'));
  var buyRec = await utils.getTxReceipt(buyHash);
  if(buyRec && buyRec.status){
    utils.logger.info('swapExactETHForTokens Success : ', buyHash);
    var evSwap = buyRec.logs.find(x => x.topics[0].startsWith("0xd78ad95f")).data;
    var actETH = BigInt('0x' + evSwap.substring(66,130));
    utils.logger.info('actual ETH                    : ', actETH);
    var actToken = BigInt('0x' + evSwap.substring(130, 194));
    utils.logger.info('actual Token                  : ', actToken);
    var evSync = buyRec.logs.find(x => x.topics[0].startsWith("0x1c411e9a")).data;
    reserveToken = BigInt(evSync.substring(0,66));
    utils.logger.info('Reserve Token                 : ', reserveToken);
    reserveETH = BigInt('0x' + evSync.substring(66));
    utils.logger.info('Reserve ETH                   : ', reserveETH);
  }
  
  // sell % of token reserves (6%)
  var reserves = await utils.getPairReserves(pairContract);
  reserveToken = BigInt(reserves._reserve0);
  reserveETH = BigInt(reserves._reserve1);
  utils.logger.info("-------------------------------------------------------");
  utils.logger.info("-------    Selling 6% of Pair Reserves       ----------");
  var accBal = await utils.getTokenBalance(tokenContract, Account1.address);
  utils.logger.info("Account Balance           : ", accBal);
  var soldToken = reserveToken * 60n / 1000n;
  if(accBal > soldToken){
    var retETH = utils.getAmountOut(soldToken, reserveToken, reserveETH); // calc ETH returned from selling 
    var sellHash = await utils.sellToken(psRouterContract, tokenContract, Account1.address, soldToken);
    var sellRec = await utils.getTxReceipt(sellHash);
    if(sellRec && sellRec.status){
      utils.logger.info('swapTokenswithFee Success : ', sellHash);
      var evSellingFeeCollected = sellRec.logs.find(x => x.topics[0].startsWith("0xcb38d5e6")).data;
      var totToken  = BigInt(evSellingFeeCollected.substring(0,66));
      utils.logger.info('Total Act Tokens          : ', totToken);
      var taxVal = BigInt('0x' + evSellingFeeCollected.substring(66,130));
      var taxPCT = Number(taxVal * 100000n / totToken) / 1000;
      utils.logger.info('Token Total Tax           :  %d  [%d%%]', taxVal , taxPCT);
      utils.logger.info('Net Token Sold            : ', totToken - taxVal );
      var evSwapAndLiquify = sellRec.logs.find(x => x.topics[0].startsWith("0x17bbfb9a"));
      if(evSwapAndLiquify && evSwapAndLiquify.data && evSwapAndLiquify.data.length > 0){
        utils.logger.info("-------       Swap and Liquify Event         ----------");
        var tokensSwapped  = BigInt(evSwapAndLiquify.data.substring(0,66));
        utils.logger.info('Tokens Swapped            : ', tokensSwapped);
        var ETHReceived = BigInt('0x' + evSwapAndLiquify.data.substring(66,130));
        utils.logger.info('ETH Received              : ', ETHReceived);
        var tokensLiquid = BigInt('0x' + evSwapAndLiquify.data.substring(130, 194));
        utils.logger.info('Tokens added to Liq.      : ', tokensLiquid);
      }
      intRes = await utils.getTokenBalance(tokenContract, defs.tokenAddr);
      utils.logger.info("Contract Balance          : ", intRes);
      intRes = await utils.getCirculatingSupply(tokenContract);
      utils.logger.info("Circulating Supply        : ", intRes);
      intRes = await utils.getSwapAndLiquifyBalance(tokenContract);
      utils.logger.info("SwapAndLiquifyBalance     : ", intRes);


    }
  }
  // sell % of token reserves (3%)
  var reserves = await utils.getPairReserves(pairContract);
  reserveToken = BigInt(reserves._reserve0);
  reserveETH = BigInt(reserves._reserve1);
  utils.logger.info("-------------------------------------------------------");
  utils.logger.info("-------    Selling 3% of Pair Reserves       ----------");
  accBal = await utils.getTokenBalance(tokenContract, Account1.address);
  utils.logger.info("Account Balance           : ", accBal);
  var soldToken = reserveToken * 30n / 1000n;
  if(accBal > soldToken){
    var retETH = utils.getAmountOut(soldToken, reserveToken, reserveETH); // calc ETH returned from selling 
    var sellHash = await utils.sellToken(psRouterContract, tokenContract, Account1.address, soldToken);
    var sellRec = await utils.getTxReceipt(sellHash);
    if(sellRec && sellRec.status){
      utils.logger.info('swapTokenswithFee Success : ', sellHash);
      var evSellingFeeCollected = sellRec.logs.find(x => x.topics[0].startsWith("0xcb38d5e6")).data;
      var totToken  = BigInt(evSellingFeeCollected.substring(0,66));
      utils.logger.info('Total Act Tokens          : ', totToken);
      var taxVal = BigInt('0x' + evSellingFeeCollected.substring(66,130));
      var taxPCT = Number(taxVal * 100000n / totToken) / 1000;
      utils.logger.info('Token Total Tax           :  %d  [%d%%]', taxVal , taxPCT);
      utils.logger.info('Net Token Sold            : ', totToken - taxVal );
      var evSwapAndLiquify = sellRec.logs.find(x => x.topics[0].startsWith("0x17bbfb9a"));
      if(evSwapAndLiquify && evSwapAndLiquify.data && evSwapAndLiquify.data.length > 0){
        utils.logger.info("-------       Swap and Liquify Event         ----------");
        var tokensSwapped  = BigInt(evSwapAndLiquify.data.substring(0,66));
        utils.logger.info('Tokens Swapped            : ', tokensSwapped);
        var ETHReceived = BigInt('0x' + evSwapAndLiquify.data.substring(66,130));
        utils.logger.info('ETH Received              : ', ETHReceived);
        var tokensLiquid = BigInt('0x' + evSwapAndLiquify.data.substring(130, 194));
        utils.logger.info('Tokens added to Liq.      : ', tokensLiquid);
      }
      intRes = await utils.getTokenBalance(tokenContract, defs.tokenAddr);
      utils.logger.info("Contract Balance          : ", intRes);
      intRes = await utils.getCirculatingSupply(tokenContract);
      utils.logger.info("Circulating Supply        : ", intRes);
      intRes = await utils.getSwapAndLiquifyBalance(tokenContract);
      utils.logger.info("SwapAndLiquifyBalance     : ", intRes);
    }
  }
  */
  // sell % of token reserves (1.1%)
  var reserves = await utils.getPairReserves(pairContract);
  reserveToken = BigInt(reserves._reserve0);
  reserveETH = BigInt(reserves._reserve1);
  utils.logger.info("-------------------------------------------------------");
  utils.logger.info("-------    Selling 1.1% of Pair Reserves     ----------");
  accBal = await utils.getTokenBalance(tokenContract, Account1.address);
  utils.logger.info("Account Balance           : ", accBal);
  var soldToken = reserveToken * 11n / 1000n;
  if(accBal > soldToken){
    var retETH = utils.getAmountOut(soldToken, reserveToken, reserveETH); // calc ETH returned from selling 
    var sellHash = await utils.sellToken(psRouterContract, tokenContract, Account1.address, soldToken);
    var sellRec = await utils.getTxReceipt(sellHash);
    if(sellRec && sellRec.status){
      utils.logger.info('swapTokenswithFee Success : ', sellHash);
      var evSellingFeeCollected = sellRec.logs.find(x => x.topics[0].startsWith("0xcb38d5e6")).data;
      var totToken  = BigInt(evSellingFeeCollected.substring(0,66));
      utils.logger.info('Total Act Tokens          : ', totToken);
      var taxVal = BigInt('0x' + evSellingFeeCollected.substring(66,130));
      var taxPCT = Number(taxVal * 100000n / totToken) / 1000;
      utils.logger.info('Token Total Tax           :  %d  [%d%%]', taxVal , taxPCT);
      utils.logger.info('Net Token Sold            : ', totToken - taxVal );
      var evSwapAndLiquify = sellRec.logs.find(x => x.topics[0].startsWith("0x17bbfb9a"));
      if(evSwapAndLiquify && evSwapAndLiquify.data && evSwapAndLiquify.data.length > 0){
        utils.logger.info("-------       Swap and Liquify Event         ----------");
        var tokensSwapped  = BigInt(evSwapAndLiquify.data.substring(0,66));
        utils.logger.info('Tokens Swapped            : ', tokensSwapped);
        var ETHReceived = BigInt('0x' + evSwapAndLiquify.data.substring(66,130));
        utils.logger.info('ETH Received              : ', ETHReceived);
        var tokensLiquid = BigInt('0x' + evSwapAndLiquify.data.substring(130, 194));
        utils.logger.info('Tokens added to Liq.      : ', tokensLiquid);
      }
      intRes = await utils.getTokenBalance(tokenContract, defs.tokenAddr);
      utils.logger.info("Contract Balance          : ", intRes);
      intRes = await utils.getCirculatingSupply(tokenContract);
      utils.logger.info("Circulating Supply        : ", intRes);
      intRes = await utils.getSwapAndLiquifyBalance(tokenContract);
      utils.logger.info("SwapAndLiquifyBalance     : ", intRes);
    }
  }
  // sell % of token reserves (0.9%)
  var reserves = await utils.getPairReserves(pairContract);
  reserveToken = BigInt(reserves._reserve0);
  reserveETH = BigInt(reserves._reserve1);
  utils.logger.info("-------------------------------------------------------");
  utils.logger.info("-------    Selling 0.9% of Pair Reserves     ----------");
  accBal = await utils.getTokenBalance(tokenContract, Account1.address);
  utils.logger.info("Account Balance           : ", accBal);
  var soldToken = reserveToken * 9n / 1000n;
  if(accBal > soldToken){
    var retETH = utils.getAmountOut(soldToken, reserveToken, reserveETH); // calc ETH returned from selling 
    var sellHash = await utils.sellToken(psRouterContract, tokenContract, Account1.address, soldToken);
    var sellRec = await utils.getTxReceipt(sellHash);
    if(sellRec && sellRec.status){
      utils.logger.info('swapTokenswithFee Success : ', sellHash);
      var evSellingFeeCollected = sellRec.logs.find(x => x.topics[0].startsWith("0xcb38d5e6")).data;
      var totToken  = BigInt(evSellingFeeCollected.substring(0,66));
      utils.logger.info('Total Act Tokens          : ', totToken);
      var taxVal = BigInt('0x' + evSellingFeeCollected.substring(66,130));
      var taxPCT = Number(taxVal * 100000n / totToken) / 1000;
      utils.logger.info('Token Total Tax           :  %d  [%d%%]', taxVal , taxPCT);
      utils.logger.info('Net Token Sold            : ', totToken - taxVal );
      var evSwapAndLiquify = sellRec.logs.find(x => x.topics[0].startsWith("0x17bbfb9a"));
      if(evSwapAndLiquify && evSwapAndLiquify.data && evSwapAndLiquify.data.length > 0){
        utils.logger.info("-------       Swap and Liquify Event         ----------");
        var tokensSwapped  = BigInt(evSwapAndLiquify.data.substring(0,66));
        utils.logger.info('Tokens Swapped            : ', tokensSwapped);
        var ETHReceived = BigInt('0x' + evSwapAndLiquify.data.substring(66,130));
        utils.logger.info('ETH Received              : ', ETHReceived);
        var tokensLiquid = BigInt('0x' + evSwapAndLiquify.data.substring(130, 194));
        utils.logger.info('Tokens added to Liq.      : ', tokensLiquid);
      }
      intRes = await utils.getTokenBalance(tokenContract, defs.tokenAddr);
      utils.logger.info("Contract Balance          : ", intRes);
      intRes = await utils.getCirculatingSupply(tokenContract);
      utils.logger.info("Circulating Supply        : ", intRes);
      intRes = await utils.getSwapAndLiquifyBalance(tokenContract);
      utils.logger.info("SwapAndLiquifyBalance     : ", intRes);
    }
  }
  

}

// Staking Unit
async function testStaking() {
  var stakingInterval = await utils.getStakingInterval(tokenContract);
  utils.logger.info("Staking Interval          : ", stakingInterval);
  var intRes = await utils.getTokenBalance(tokenContract, defs.tokenAddr);
  utils.logger.info("Contract Token Balance    : ", intRes);
  intRes = await utils.getETHBalance(defs.tokenAddr);
  utils.logger.info("Contract ETH Balance      : ", intRes);
  utils.logger.info("-------------------------------------------------------");
  utils.logger.info("--------------    Staking Snapshots     ---------------");
  utils.logger.info("-------------------------------------------------------");
  var stakingledger = [];
  var idx = 0;
  while(true){
    try{
      var snapshot = await utils.getStakingSnapshot(tokenContract, idx, false);
      utils.logger.info("Snapshot[%d]----------:", idx);
      utils.logger.info("  timestamp          :", snapshot.timestamp);
      utils.logger.info("  totStaked          :", snapshot.totStaked);
      utils.logger.info("  totTokenReward     :", snapshot.totTokenReward);
      utils.logger.info("  totETHReward       :", snapshot.totETHReward);
      utils.logger.info("  totTokenClaimed    :", snapshot.totTokenClaimed);
      utils.logger.info("  totETHClaimed      :", snapshot.totETHClaimed);
      stakingledger.push(snapshot)
      idx++;
    } catch(err){
      break;
    }
  }
  utils.logger.info("-------------------------------------------------------");
  utils.logger.info("-----------------    User Trades     ------------------");
  utils.logger.info("-------------------------------------------------------");
  // main account
  utils.logger.info("Main: ", mainAccount.address);
  var rewardBal = await utils.getBalanceRewards(tokenContract,mainAccount.address);
  utils.logger.info("walletBalance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  await logUserTrades(mainAccount.address);
  utils.logger.info("-------------------------------------------------------");

  // Account 1
  utils.logger.info("Account1: ", Account1.address);
  rewardBal = await utils.getBalanceRewards(tokenContract,Account1.address);
  utils.logger.info("walletBalance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  await logUserTrades(Account1.address);
  utils.logger.info("-------------------------------------------------------");

  // Account 2
  utils.logger.info("Account2: ", Account2.address);
  rewardBal = await utils.getBalanceRewards(tokenContract,Account2.address);
  utils.logger.info("walletBalance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  await logUserTrades(Account2.address);
  utils.logger.info("-------------------------------------------------------");

  // Account 3
  utils.logger.info("Account3: ", Account3.address);
  rewardBal = await utils.getBalanceRewards(tokenContract,Account3.address);
  utils.logger.info("walletBalance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  await logUserTrades(Account3.address);
  utils.logger.info("-------------------------------------------------------");

  // Account 4
  utils.logger.info("Account4: ", Account4.address);
  rewardBal = await utils.getBalanceRewards(tokenContract,Account4.address);
  utils.logger.info("walletBalance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  await logUserTrades(Account4.address);
  utils.logger.info("-------------------------------------------------------");

  // Test Account
  utils.logger.info("Test: ", testAccount.address);
  rewardBal = await utils.getBalanceRewards(tokenContract,testAccount.address);
  utils.logger.info("walletBalance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  await logUserTrades(testAccount.address);
  utils.logger.info("-------------------------------------------------------");


}
async function claimStakingReward() {
  // main account
  utils.logger.info("Main: ", mainAccount.address);
  var rewardBal = await utils.getBalanceRewards(tokenContract,mainAccount.address);
  var intRes = await utils.getETHBalance(mainAccount.address);
  utils.logger.info("Token Balance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("ETH Balance          : ", intRes);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  var claimHash = await utils.claimRewards(tokenContract,mainAccount.address);
  var claimRec = await utils.getTxReceipt(claimHash);
  if(claimRec && claimRec.status){
    intRes = await utils.getTokenBalance(tokenContract,mainAccount.address);
    utils.logger.info("new Token Balance    : ", intRes);
    intRes = await utils.getETHBalance(mainAccount.address);
    utils.logger.info("new ETH Balance      : ", intRes);
  }
  utils.logger.info("-------------------------------------------------------");

  // Account 1
  utils.logger.info("Account1: ", Account1.address);
  var rewardBal = await utils.getBalanceRewards(tokenContract,Account1.address);
  var intRes = await utils.getETHBalance(Account1.address);
  utils.logger.info("Token Balance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("ETH Balance          : ", intRes);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  var claimHash = await utils.claimRewards(tokenContract,Account1.address);
  var claimRec = await utils.getTxReceipt(claimHash);
  if(claimRec && claimRec.status){
    intRes = await utils.getTokenBalance(tokenContract,Account1.address);
    utils.logger.info("new Token Balance    : ", intRes);
    intRes = await utils.getETHBalance(Account1.address);
    utils.logger.info("new ETH Balance      : ", intRes);
  }
  utils.logger.info("-------------------------------------------------------");

  // Account 2
  utils.logger.info("Account2: ", Account2.address);
  var rewardBal = await utils.getBalanceRewards(tokenContract,Account2.address);
  var intRes = await utils.getETHBalance(Account2.address);
  utils.logger.info("Token Balance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("ETH Balance          : ", intRes);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  var claimHash = await utils.claimRewards(tokenContract,Account2.address);
  var claimRec = await utils.getTxReceipt(claimHash);
  if(claimRec && claimRec.status){
    intRes = await utils.getTokenBalance(tokenContract,Account2.address);
    utils.logger.info("new Token Balance    : ", intRes);
    intRes = await utils.getETHBalance(Account2.address);
    utils.logger.info("new ETH Balance      : ", intRes);
  }
  utils.logger.info("-------------------------------------------------------");

  // Account 3
  utils.logger.info("Account3: ", Account3.address);
  var rewardBal = await utils.getBalanceRewards(tokenContract,Account3.address);
  var intRes = await utils.getETHBalance(Account3.address);
  utils.logger.info("Token Balance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("ETH Balance          : ", intRes);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  var claimHash = await utils.claimRewards(tokenContract,Account3.address);
  var claimRec = await utils.getTxReceipt(claimHash);
  if(claimRec && claimRec.status){
    intRes = await utils.getTokenBalance(tokenContract,Account3.address);
    utils.logger.info("new Token Balance    : ", intRes);
    intRes = await utils.getETHBalance(Account3.address);
    utils.logger.info("new ETH Balance      : ", intRes);
  }
  utils.logger.info("-------------------------------------------------------");

  // Account 4
  utils.logger.info("Account4: ", Account4.address);
  var rewardBal = await utils.getBalanceRewards(tokenContract,Account4.address);
  var intRes = await utils.getETHBalance(Account4.address);
  utils.logger.info("Token Balance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("ETH Balance          : ", intRes);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  var claimHash = await utils.claimRewards(tokenContract,Account4.address);
  var claimRec = await utils.getTxReceipt(claimHash);
  if(claimRec && claimRec.status){
    intRes = await utils.getTokenBalance(tokenContract,Account4.address);
    utils.logger.info("new Token Balance    : ", intRes);
    intRes = await utils.getETHBalance(Account4.address);
    utils.logger.info("new ETH Balance      : ", intRes);
  }
  utils.logger.info("-------------------------------------------------------");
  /* // skip the test account for financial cleanup check
  // Test Account
  utils.logger.info("Test: ", testAccount.address);
  var intRes = await utils.getETHBalance(testAccount.address);
  utils.logger.info("Token Balance        : ", rewardBal.walletBalance);
  utils.logger.info("dueTokenReward       : ", rewardBal.dueTokenReward);
  utils.logger.info("ETH Balance          : ", intRes);
  utils.logger.info("dueETHReward         : ", rewardBal.dueETHReward);
  var claimHash = await utils.claimRewards(tokenContract,testAccount.address);
  var claimRec = await utils.getTxReceipt(claimHash);
  if(claimRec && claimRec.status){
    intRes = await utils.getTokenBalance(tokenContract,testAccount.address);
    utils.logger.info("new Token Balance    : ", intRes);
    intRes = await utils.getETHBalance(testAccount.address);
    utils.logger.info("new ETH Balance      : ", intRes);
  }
  utils.logger.info("-------------------------------------------------------");
  */
}

async function getLastStakingSnapshot (contract) {
  var lastSnapshot;
  var idx = 0;
  while(true){
    try{
      var snapshot = await utils.getStakingSnapshot(tokenContract, idx, false);
      lastSnapshot = snapshot;
      idx++;
    } catch(err){
      break;
    }
  }
  return lastSnapshot;
}
// Multi-Sig LP Token Liquification Unit
async function liquifyLPTokens() {

  if(!pairInitFlag){                                                    
    pairContract = new utils.web3.eth.Contract(defs.pairABI, defs.pairAddr);
    pairContract.defaultAccount = mainAccount.address;
    pairContract.options.from = mainAccount.address;
    pairContract.options.gasPrice = defGasPrice;
    pairContract.options.gas = defGasLimit;
  }

  var intRes = await utils.getTokenBalance(pairContract, defs.tokenAddr);
  utils.logger.info("Contract LP Token Balance    : ", intRes);

  /*
  // check if a non valid account will authorize as a liquidity manager
  try{
    var authHash = await utils.liquifyLP(tokenContract, testAccount.address, intRes, mainAccount.address, 1, false)
    .then(() => {
      utils.logger.info("Test of auth failed: ", authHash);
    })
    .catch((err) => {
      utils.logger.info("Test of Auth success: a non liquidity manager account got rejected");
    });
  } catch(err){
    utils.logger.info("Test of Auth success: a non liquidity manager account got rejected");
  }
  */

  var authHash = await utils.liquifyLP(tokenContract, Account1.address, intRes, mainAccount.address, 1);
  var authRec = await utils.getTxReceipt(authHash);
  if(authRec && authRec.status){
    utils.logger.info("Test of auth step1: ", authHash);
  }
  /*
  // check if repeated ath of the same account will revert
  try{
    var authHash = await utils.liquifyLP(tokenContract, Account1.address, intRes, mainAccount.address, 1, false)
    .then(() => {
      utils.logger.info("Test of repeated auth failed: ", authHash);
    })
    .catch((err) => {
      utils.logger.info("Test of repeated Auth success: repeated auth got rejected");
    });
  } catch(err){
    utils.logger.info("Test of repeated Auth success: repeated auth got rejected");
  }
  */
  authHash = await utils.liquifyLP(tokenContract, Account2.address, intRes, mainAccount.address, 1);
  var authRec = await utils.getTxReceipt(authHash);
  if(authRec && authRec.status){
    utils.logger.info("Test of auth step2: ", authHash);
  }

  authHash = await utils.liquifyLP(tokenContract, mainAccount.address, intRes, mainAccount.address, 1);
  var authRec = await utils.getTxReceipt(authHash);
  if(authRec && authRec.status){
    utils.logger.info("Test of auth step3: ", authHash);
  }
}
// Multi-Sig LP Token Liquification Unit
async function testFinancialCleanup() {

  var authHash = await utils.financialCleanup(tokenContract, Account1.address, 2);
  var authRec = await utils.getTxReceipt(authHash);
  if(authRec && authRec.status){
    utils.logger.info("Test of auth step1: ", authHash);
  }

  authHash = await utils.financialCleanup(tokenContract, Account2.address, 2);
  var authRec = await utils.getTxReceipt(authHash);
  if(authRec && authRec.status){
    utils.logger.info("Test of auth step2: ", authHash);
  }

  authHash = await utils.financialCleanup(tokenContract, mainAccount.address,  2);
  var authRec = await utils.getTxReceipt(authHash);
  if(authRec && authRec.status){
    utils.logger.info("Test of auth step3: ", authHash);
  }
}
async function logUserTrades(accAddr) {
  var idx = 0;
  while(true){
    try{
      var trade = await utils.getUserTrade(tokenContract,accAddr, idx, false);
      utils.logger.info("Trade[%d]-------------: ", idx);
      utils.logger.info("  timestamp          : ", trade.timestamp);
      utils.logger.info("  tradeAmount        : ", trade.tradeAmount);
      utils.logger.info("  tBalance           : ", trade.tBalance);
      utils.logger.info("  rewardTokenBalance : ", trade.rewardTokenBalance);
      utils.logger.info("  rewardETHBalance   : ", trade.rewardETHBalance);
      utils.logger.info("  sellFlag           : ", trade.sellFlag);
      idx++;
    } catch(err){
      break;
    }
  }
}
// Liquidity Restore Unit
async function removeLiquidity() {

  if(!pairInitFlag){                                                    // manual liquidity removal
    pairContract = new utils.web3.eth.Contract(defs.pairABI, defs.pairAddr);
    pairContract.defaultAccount = mainAccount.address;
    pairContract.options.from = mainAccount.address;
    pairContract.options.gasPrice = defGasPrice;
    pairContract.options.gas = defGasLimit;
    liquidity = await utils.getTokenBalance(pairContract, mainAccount.address);
    utils.logger.info('Total LP Tokens            : ', liquidity);
  }

  // approve router
  var approveHash = await utils.approveSpender(pairContract, mainAccount.address, defs.pancakeRouter, BigInt(99999999999999999999999999999999));
  var approveRec = await utils.getTxReceipt(approveHash);
  if(approveRec && approveRec.status){
    utils.logger.info('Router Approve Success      : ', approveHash);
      var removeLiquidityHash = await utils.removePairLiquidity(psRouterContract, liquidity);
      var removeLiquidityRec = await utils.getTxReceipt(removeLiquidityHash);
      if(removeLiquidityRec && removeLiquidityRec.status){
        utils.logger.info('RemoveLiquidityETH Success : ', removeLiquidityHash);
      }
      else
      utils.logger.info('RemoveLiquidityETH Failed');
  }
  else
      utils.logger.info('Router Approve Failed');
}




