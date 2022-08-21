// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#ifndef FS_IOMARKET_H
#define FS_IOMARKET_H

#include "database.h"
#include "enums.h"

class IOMarket
{
	public:
		static IOMarket& getInstance() {
			static IOMarket instance;
			return instance;
		}

		static MarketOfferList getActiveOffers(MarketAction_t action, uint16_t itemId, uint8_t tier);
		static MarketOfferList getOwnOffers(MarketAction_t action, uint32_t playerId);
		static HistoryMarketOfferList getOwnHistory(MarketAction_t action, uint32_t playerId);

		static void processExpiredOffers(DBResult_ptr result, bool);
		static void checkExpiredOffers();

		static uint32_t getPlayerOfferCount(uint32_t playerId);
		static MarketOfferEx getOfferByCounter(uint32_t timestamp, uint16_t counter);

		static void createOffer(uint32_t playerId, MarketAction_t action, uint32_t itemId, uint16_t amount, uint8_t tier, uint64_t price, bool anonymous);
		static void acceptOffer(uint32_t offerId, uint16_t amount);
		static void deleteOffer(uint32_t offerId);

		static void appendHistory(uint32_t playerId, MarketAction_t type, uint16_t itemId, uint16_t amount, uint8_t tier, uint64_t price, time_t timestamp, MarketOfferState_t state);
		static bool moveOfferToHistory(uint32_t offerId, MarketOfferState_t state);

		void updateStatistics();

		MarketStatistics* getPurchaseStatistics(uint16_t itemId, uint8_t tier);
		MarketStatistics* getSaleStatistics(uint16_t itemId, uint8_t tier);

	private:
		IOMarket() = default;

		std::unordered_map<std::pair<uint16_t, uint8_t>, MarketStatistics, ItemTypeTierHash> purchaseStatistics;
		std::unordered_map<std::pair<uint16_t, uint8_t>, MarketStatistics, ItemTypeTierHash> saleStatistics;
};

#endif
