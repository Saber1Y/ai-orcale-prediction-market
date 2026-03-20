->  Functions to Implement
1. constructor - set admin, USDC address
2. createMarket(question, deadline) - onlyAdmin, validate deadline
3. placeBet(marketId, prediction, amount) - requires: active, not resolved, before deadline, amount > 0, approve USDC first
4. resolveMarket(marketId, outcome) - onlyOracleAggregator, requires: resolved=false, deadline passed
5. claimReward(marketId) - calculate share, transfer USDC, mark claimed
6. refundMarket(marketId) - onlyAdmin, only if 48h after deadline and not resolved, return all bets