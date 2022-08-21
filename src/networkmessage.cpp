// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "networkmessage.h"

#include "container.h"
#include "player.h"
#include "podium.h"

std::string NetworkMessage::getString(uint16_t stringLen/* = 0*/)
{
	if (stringLen == 0) {
		stringLen = get<uint16_t>();
	}

	if (!canRead(stringLen)) {
		return std::string();
	}

	char* v = reinterpret_cast<char*>(buffer) + info.position; //does not break strict aliasing
	info.position += stringLen;
	return std::string(v, stringLen);
}

Position NetworkMessage::getPosition()
{
	Position pos;
	pos.x = get<uint16_t>();
	pos.y = get<uint16_t>();
	pos.z = getByte();
	return pos;
}

void NetworkMessage::addString(const std::string& value)
{
	size_t stringLen = value.length();
	if (!canAdd(stringLen + 2) || stringLen > 8192) {
		return;
	}

	add<uint16_t>(stringLen);
	memcpy(buffer + info.position, value.c_str(), stringLen);
	info.position += stringLen;
	info.length += stringLen;
}

void NetworkMessage::addDouble(double value, uint8_t precision/* = 2*/)
{
	addByte(precision);
	add<uint32_t>(static_cast<uint32_t>((value * std::pow(static_cast<float>(10), precision)) + std::numeric_limits<int32_t>::max()));
}

void NetworkMessage::addBytes(const char* bytes, size_t size)
{
	if (!canAdd(size) || size > 8192) {
		return;
	}

	memcpy(buffer + info.position, bytes, size);
	info.position += size;
	info.length += size;
}

void NetworkMessage::addPaddingBytes(size_t n)
{
	if (!canAdd(n)) {
		return;
	}

	memset(buffer + info.position, 0x33, n);
	info.length += n;
}

void NetworkMessage::addPosition(const Position& pos)
{
	add<uint16_t>(pos.x);
	add<uint16_t>(pos.y);
	addByte(pos.z);
}

void NetworkMessage::addItem(uint16_t id, uint8_t count)
{
	const ItemType& it = Item::items[id];

	add<uint16_t>(it.clientId);

	if (it.stackable) {
		addByte(count);
	} else if (it.isSplash() || it.isFluidContainer()) {
		addByte(count == 0 ? count : fluidMap[count & 7]);
	} else if (it.type == ITEM_TYPE_CONTAINER || it.type == ITEM_TYPE_DEPOT) {
		addByte(0x00); // assigned loot container icon
		addByte(0x00); // quiver ammo count
	} else if (it.classification > 0) {
		addByte(0x00); // item tier (0-10)

	// charges/duration indicators
	} else if (it.showClientCharges) {
		add<uint32_t>(it.charges);
		addByte(0x01); // (item is brand-new)
	} else if (it.showClientDuration) {
		uint32_t duration = it.decayTime;
		if (duration == 0) {
			int32_t equipId = it.transformEquipTo;
			if (equipId != 0) {
				duration = Item::items[equipId].decayTime;
			}
		}

		add<uint32_t>(duration);
		addByte(0x01); // (item is brand-new)
	}

	if (it.isPodium()) {
		add<uint16_t>(0); //lookType
		add<uint16_t>(0); //lookTypeEx
		add<uint16_t>(0); //lookMount
		addByte(2); //direction
		addByte(0x01); //is visible (bool)
	}
}

void NetworkMessage::addItem(const Item* item)
{
	const ItemType& it = Item::items[item->getID()];

	add<uint16_t>(it.clientId);

	if (it.stackable) {
		addByte(std::min<uint16_t>(0xFF, item->getItemCount()));
	} else if (it.isSplash() || it.isFluidContainer()) {
		uint16_t fluidType = item->getFluidType();
		addByte(fluidType == 0 ? fluidType : fluidMap[fluidType & 7]);
	} else if (it.classification > 0) {
		addByte(item->getIntAttr(ITEM_ATTRIBUTE_TIER)); // item tier (0-10)
	}

	// charges/duration indicators
	if (it.showClientCharges) {
		uint32_t charges = item->getCharges();
		add<uint32_t>(charges > 0 ? charges : it.charges);
		addByte(charges == it.charges); // has default charges
	} else if (it.showClientDuration) {
		uint32_t duration = item->getDuration() / 1000;
		bool isUnused = false;
		if (duration == 0) {
			int32_t equipId = it.transformEquipTo;
			if (equipId != 0) {
				duration = Item::items[equipId].decayTime;
				isUnused = true;
			}
		}

		add<uint32_t>(duration);
		addByte(isUnused); // paused decay / brand-new
	}

	if (it.type == ITEM_TYPE_CONTAINER || it.type == ITEM_TYPE_DEPOT) {
		const Container* container = item->getContainer();
		const Player* player = item->getHoldingPlayer();

		// assigned loot container icon
		if (container && player) {
			addByte(0x01);
			add<uint32_t>(player->getContainerFlags(container));
		} else {
			// no one holds the item, send no icon
			addByte(0x00);
		}

		// quiver ammo count
		if (container && it.weaponType == WEAPON_QUIVER) {
			addByte(0x01);
			add<uint32_t>(container->getAmmoCount());
		} else {
			addByte(0x00);
		}
	}

	// display outfit on the podium
	if (it.isPodium()) {
		const Podium* podium = item->getPodium();
		const Outfit_t &outfit = podium->getOutfit();

		//add outfit
		if (podium->hasFlag(PODIUM_SHOW_OUTFIT)) {
			add<uint16_t>(outfit.lookType);
			if (outfit.lookType != 0) {
				addByte(outfit.lookHead);
				addByte(outfit.lookBody);
				addByte(outfit.lookLegs);
				addByte(outfit.lookFeet);
				addByte(outfit.lookAddons);
			} else {
				add<uint16_t>(outfit.lookTypeEx);
			}
		} else {
			add<uint16_t>(0);
			add<uint16_t>(0);
		}

		//add mount
		if (podium->hasFlag(PODIUM_SHOW_MOUNT)) {
			add<uint16_t>(outfit.lookMount);
			if (outfit.lookMount != 0) {
				addByte(outfit.lookMountHead);
				addByte(outfit.lookMountBody);
				addByte(outfit.lookMountLegs);
				addByte(outfit.lookMountFeet);
			}
		} else {
			add<uint16_t>(0);
		}

		addByte(podium->getDirection());
		addByte(podium->hasFlag(PODIUM_SHOW_PLATFORM) ? 0x01 : 0x00);
		return;
	}
}

void NetworkMessage::addItemId(uint16_t itemId)
{
	add<uint16_t>(Item::items[itemId].clientId);
}
