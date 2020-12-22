orderbooks:([]time:`timespan$();sym:`symbol$();gatewayTimestamp:`timestamp$();marketTimestamp:`timestamp$();quoteId:`symbol$();market:`symbol$();bidPrices:();bidSizes:();offerPrices:();offerSizes:())
trades:([]time:`timespan$();sym:`symbol$();gatewayTimestamp:`timestamp$();tradeTimestamp:`timestamp$();market:`symbol$();tradeId:`symbol$();side:`symbol$();price:`float$();lhsFlow:`float$();rhsFlow:`float$();orderType:`symbol$();misc:`char$())
ohlcs:([]time:`timespan$();sym:`symbol$();gatewayTimestamp:`timestamp$();tradeTimestamp:`timestamp$();market:`symbol$();interval:`int$();open:`float$();high:`float$();low:`float$();close:`float$();vwap:`float$();totalVolume:`float$();tradeCount:`int$())
spreads:([]time:`timespan$();sym:`symbol$();gatewayTimestamp:`timestamp$();tradeTimestamp:`timestamp$();market:`symbol$();endTime:`timestamp$();bidPrice:`float$();bidSize:`float$();offerPrice:`float$();offerSize:`float$())

