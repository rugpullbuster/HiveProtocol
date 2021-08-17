const defs = require('./defs');
const Web3= require('web3');
const log4js = require('log4js');
log4js.configure({
  appenders: { console: { type: 'console', layout: { type: 'messagePassThrough' } }, txtLog: { type: 'fileSync', filename: 'session.txt', layout: { type: 'messagePassThrough' } } },
  categories: { default: { appenders: ['txtLog', 'console'], level: 'trace' } }
});
module.exports = {
  web3: new Web3(defs.rpcURL),
  logger: log4js.getLogger(),
  sleep: function(ms){
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
  },
  getTokenBalance: async function(contract, addr) {
    return new Promise(function(resolve, reject) {
      contract.methods.balanceOf(addr).call({}, function(err, res) {
          if (err) {
            reject(err)
            module.exports.logger.error('BalanceOf Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  getETHBalance: async function(addr) {
    return new Promise(function(resolve, reject) {
      module.exports.web3.eth.getBalance(addr, function(err, res) {
          if (err) {
            reject(err)
            module.exports.logger.error('ETH Balance Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  getUserTrade: async function(contract, account, idx, verbose = true) {
    return new Promise(function(resolve, reject) {
      contract.methods.userTrade(account, idx).call({}, function(err, res) {
          if (err) {
            reject(err)
            if(verbose)
              module.exports.logger.error('userTrade Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  getCirculatingSupply: async function(contract) {
    return new Promise(function(resolve, reject) {
      contract.methods.circulatingSupply().call({}, function(err, res) {
          if (err) {
            reject(err)
            module.exports.logger.error('CirculatingSupply Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  getSwapAndLiquifyBalance: async function(contract) {
    return new Promise(function(resolve, reject) {
      contract.methods.swapAndLiquifyBalance().call({}, function(err, res) {
          if (err) {
            reject(err)
            module.exports.logger.error('SwapAndLiquifyBalance Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  isTaxEnabled: async function(contract) {
    return new Promise(function(resolve, reject) {
      contract.methods.taxEnabled().call({}, function(err, res) {
          if (err) {
            reject(err)
            module.exports.logger.error('TaxEnabled Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  getAllowance: async function(contract, owner, spender) {
    return new Promise(function(resolve, reject) {
      contract.methods.allowance(owner, spender).call({}, function(err, res) {
          if (err) {
            reject(err)
            module.exports.logger.error('BalanceOf Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  approveSpender: async function(contract, owner, spender, amount) {
    return new Promise(function(resolve, reject) {
      contract.methods.approve(spender, amount).send({from: owner}, function(err, res) {
          if (err) {
            reject(err)
            module.exports.logger.error('Approve Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  createPresale: async function(contract, owner, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9) {
    return new Promise(function(resolve, reject) {
      contract.methods.createPresale(owner, defs.tokenAddr, defs.WETH, defs.zeroAddr, [param0, param1, param2, param3, param4, param5, param6, param7, param8, param9]).send({}, function(err, txHash) {
        if (err) {
          reject(err)
          module.exports.logger.error('CreatePresale Failed Error:', err);
          return null;
        }
        resolve(txHash);
        return;
      });
    });
  },
  buyPresaleToken: async function(contract, acc, amountToken, amountETH) {
    return new Promise(function(resolve, reject) {
      contract.methods.userDeposit(amountToken).send({from: acc,value: amountETH}, function(err, txHash) {
        if (err) {
          reject(err)
          module.exports.logger.error('UserDeposit Failed Error:', err);
          return null;
        }
        resolve(txHash);
        return;
      });
    });
  },
  getPresaleBuyer: async function(contract, acc) {
    return new Promise(function(resolve, reject) {
      contract.methods.BUYERS(acc).call({}, function(err, res) {
          if (err) {
            reject(err)
            module.exports.logger.error('BUYERS Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  finalizePresale: async function(contract) {
    return new Promise(function(resolve, reject) {
      contract.methods.addLiquidity().send({}, function(err, txHash) {
        if (err) {
          reject(err)
          module.exports.logger.error('AddLiquidity Failed Error:', err);
          return null;
        }
        resolve(txHash);
        return;
      });
    });
  },
  claimPresaleTokens: async function(contract, acc) {
    return new Promise(function(resolve, reject) {
      contract.methods.userWithdrawTokens().send({from: acc}, function(err, txHash) {
        if (err) {
          reject(err)
          module.exports.logger.error('UserWithdrawTokens Failed Error:', err);
          return null;
        }
        resolve(txHash);
        return;
      });
    });
  },
  addPairLiquidity: async function(contract, amountToken, amountETH) {
    return new Promise(function(resolve, reject) {
      var deadline = Math.floor((new Date().getTime() + (3*60*60*1000) )/ 1000); // unix timestamp 3hrs from now
      contract.methods.addLiquidityETH(defs.tokenAddr, amountToken, 0, 0, contract.defaultAccount, deadline).send({value: amountETH}, function(err, txHash) {
        if (err) {
          reject(err)
          module.exports.logger.error('addLiquidityETH Failed Error:', err);
          return null;
        }
        resolve(txHash);
        return;
      });
    });
  },
  removePairLiquidity: async function(contract, liquidity) {
    return new Promise(function(resolve, reject) {
      var deadline = Math.floor((new Date().getTime() + (3*60*60*1000) )/ 1000); // unix timestamp 3hrs from now
      contract.methods.removeLiquidityETH(defs.tokenAddr, liquidity, 0, 0, contract.defaultAccount, deadline).send({}, function(err, txHash) {
        if (err) {
          reject(err)
          module.exports.logger.error('removeLiquidityETH Failed Error:', err);
          return null;
        }
        resolve(txHash);
        return;
      });
    });
  },
  getPairToken0: async function(contract) {
    return new Promise(function(resolve, reject) {
      contract.methods.token0().call({}, function(err, res) {
          if (err) {
            reject(err)
            module.exports.logger.error('token0 Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  getPairReserves: async function(contract) {
    return new Promise(function(resolve, reject) {
      contract.methods.getReserves().call({}, function(err, res) {
          if (err) {
            reject(err)
            module.exports.logger.error('getReserves Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  initializeTrading: async function(contract, pairAddr) {
    return new Promise(function(resolve, reject) {
      contract.methods.initTrading(pairAddr).send({}, function(err, txHash) {
        if (err) {
          reject(err)
          module.exports.logger.error('initTrading Failed Error:', err);
          return null;
        }
        resolve(txHash);
        return;
      });
    });
  },
  buyToken: async function(routerContract, account, amountETH) {
    return new Promise(function(resolve, reject) {
      var deadline = Math.floor((new Date().getTime() + (3*60*60*1000) )/ 1000); // unix timestamp 3hrs from now
      routerContract.methods.swapExactETHForTokens(0, [defs.WETH, defs.tokenAddr],account, deadline).send({from: account, value: amountETH}, function(err, txHash) {
        if (err) {
          reject(err)
          module.exports.logger.error('swapExactETHForTokens Failed Error:', err);
          return null;
        }
        resolve(txHash);
        return;
      });
    });
  },
  sellToken: async function(routerContract, tokenContract, account, amountToken) {
    var allowance = await module.exports.getAllowance(tokenContract, account, defs.pancakeRouter);
    if(allowance < amountToken ){
      var approveHash = await module.exports.approveSpender(tokenContract,account, defs.pancakeRouter, BigInt(99999999999999999999999999999999));
      var approveRec = await module.exports.getTxReceipt(approveHash);
      if(approveRec == null || !approveRec.status){
        return null;
      }
    }

    return new Promise(function(resolve, reject) {
      var deadline = Math.floor((new Date().getTime() + (3*60*60*1000) )/ 1000); // unix timestamp 3hrs from now
      routerContract.methods.swapExactTokensForETHSupportingFeeOnTransferTokens(amountToken, 0, [defs.tokenAddr, defs.WETH],account, deadline).send({from: account}, function(err, txHash) {
        if (err) {
          reject(err)
          module.exports.logger.error('swapExactTokensForETHSupportingFeeOnTransferTokens Failed Error:', err);
          return null;
        }
        resolve(txHash);
        return;
      });
    });
  },
  getStakingSnapshot: async function(contract, idx, verbose = true) {
    return new Promise(function(resolve, reject) {
      contract.methods.stakingLedger(idx).call({}, function(err, res) {
        if (err) {
          reject(err)
          if(verbose)
            module.exports.logger.error('stakingLedger Failed Error:', err);
          return null;
        }
        resolve(res);
        return;
      });
    });
  },
  getBalanceRewards: async function(contract, account) {
    return new Promise(function(resolve, reject) {
      contract.methods.balanceRewards(account).call({}, function(err, res) {
        if (err) {
          reject(err)
          module.exports.logger.error('balanceRewards Failed Error:', err);
          return null;
        }
        resolve(res);
        return;
      });
    });
  },
  claimRewards: async function(contract, account, verbose = true) {
    return new Promise(function(resolve, reject) {
      contract.methods.claimRewards().send({from: account}, function(err, res) {
          if (err) {
            reject(err)
            if(verbose)
              module.exports.logger.error('claimRewards Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  getStakingInterval: async function(contract) {
    return new Promise(function(resolve, reject) {
      contract.methods.minStackingInterval().call({}, function(err, res) {
        if (err) {
          reject(err)
          module.exports.logger.error('minStackingInterval Failed Error:', err);
          return null;
        }
        resolve(res);
        return;
      });
    });
  },
  getMultiSigAuthReq: async function(contract, reqID) {
    return new Promise(function(resolve, reject) {
      contract.methods.multiSigReq(reqID).call({}, function(err, res) {
        if (err) {
          reject(err)
          module.exports.logger.error('multiSigReq Failed Error:', err);
          return null;
        }
        resolve(res);
        return;
      });
    });
  },
  liquifyLP: async function(contract, account, amount, to, ReqID, verbose = true) {
    return new Promise(function(resolve, reject) {
      contract.methods.generateLiquidity(amount, to, ReqID).send({from: account}, function(err, res) {
          if (err) {
            reject(err)
            if(verbose)
              module.exports.logger.error('generateLiquidity Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  financialCleanup: async function(contract, account, ReqID, verbose = true) {
    return new Promise(function(resolve, reject) {
      contract.methods.financialCleanup(ReqID).send({from: account}, function(err, res) {
          if (err) {
            reject(err)
            if(verbose)
              module.exports.logger.error('financialCleanup Error:', err);
            return;
          }
          resolve(res);
          return;
      });
    });
  },
  getTxReceipt: async function(txHash) {
    const transactionReceiptAsync = function(resolve, reject) {
        module.exports.web3.eth.getTransactionReceipt(txHash, (error, receipt) => {
            if (error) {
                reject(error);
            } else if (receipt == null) {
                setTimeout(
                    () => transactionReceiptAsync(resolve, reject), 500);
            } else {
                resolve(receipt);
            }
        });
    };

    if (typeof txHash === "string") {
        return new Promise(transactionReceiptAsync);
    } else {
        throw new Error("Invalid Type: " + txHash);
    }
  },
  getBlockNo: async function() {
    return new Promise(function(resolve, reject) {
      module.exports.web3.eth.getBlockNumber((err, res) => {
        if (err) {
          reject(err)
          return;
        }
        resolve(res);
        return;
      });
    });
  },
  // if i expect a given output(amountOut), how much of the other do i need to give?
  // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
  getAmountIn: function(amountOut, reserveIn, reserveOut){
    var numerator = reserveIn * amountOut * 1000n;
    var denominator = 998n * (reserveOut - amountOut);
    return (numerator / denominator) + 1n;
  },
  // if i send a given value of an asset(amountIn), how much to expect of the other?
  // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
  getAmountOut: function(amountIn, reserveIn, reserveOut){
    var amountInWithFee = amountIn * 998n;
    var numerator = amountInWithFee * reserveOut;
    var denominator = (reserveIn * 1000n) + amountInWithFee;
    return (numerator / denominator);
  },
  sleep: function(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
  }
}
