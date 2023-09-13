// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PropertyRentals is ERC721Enumerable  {
  using Counters for Counters.Counter;
  Counters.Counter private _nextTokenId;

  // PROPERTY = TIER
  struct Tier {
    uint256 id;
    uint256 totalSupply;
    string name;
  }
  mapping(uint256 => Tier) private _tier;
  mapping(address => mapping(uint256 => uint256)) private _ownerTierBalance;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) private _ownerTierToken;
  uint256 private constant _maxTiers = 10;
  uint256 private _totalTiers;

  // RENTAL DAY = RENTAL (NFT) INFO
  struct RentalDay{
    uint256 tokenId;
    uint256 startTime;
    uint256 endTime;
  }
  mapping(uint256 => RentalDay) private tokenIdToRentalDay;

  // EVENTS
  event PropertyAdded(uint256 id, string name);
  event RentalDayCreated(address indexed to, uint256 indexed tierId, uint256 tokenId, uint256 startTime, uint256 endTime);

  constructor(
    string memory name_,
    string memory symbol_
  ) ERC721(name_, symbol_) {
    // start at token id = 1
    _nextTokenId.increment();
  }
  
  /**
  ////////////////////////////////////////////////////
  // External Functions 
  ///////////////////////////////////////////////////
  */

  // Create property = init tier
  // Called by owner right after contract deployed: add access control
  function createProperty(
    uint256 id_,
    string memory name_
  ) external virtual {
    require(id_ < _maxTiers, "TIER_UNAVAILABLE");
    require(_tier[id_].id == 0, "TIER_ALREADY_INITIALIZED");

    _tier[id_] = Tier(id_,0, name_);
    _totalTiers++;

    emit PropertyAdded(id_, name_);
  }

  // Create rental day = mint tier.
  // Called by owner: add access control
  function createRentalDay(
    address to,
    uint256 tierId,
    uint256 startTime,
    uint256 endTime
  ) external {
    uint256 tokenId = _mintTier(to, tierId);
    tokenIdToRentalDay[tokenId] = RentalDay(
      tokenId,
      startTime,
      endTime
    );
    emit RentalDayCreated(to, tierId, tokenId, startTime, endTime);
  }

  /**
  ////////////////////////////////////////////////////
  // Internal Functions 
  ///////////////////////////////////////////////////
  */

  // mint tier NFT
  function _mintTier(address to, uint256 tierId) internal returns (uint256) {
    Tier storage tier = _tier[tierId];

    uint256 tokenId = _maxTiers + (tier.totalSupply * _maxTiers) + tierId;
    _safeMint(to, tokenId);
    tier.totalSupply++;
    _ownerTierToken[to][tierId][
        _ownerTierBalance[to][tierId]
    ] = tokenId;
    _ownerTierBalance[to][tierId]++;

    return tokenId;
  }

  /**
  ////////////////////////////////////////////////////
  // View only functions
  ///////////////////////////////////////////////////
  */

  function maxTiers() external view virtual returns (uint256) {
    return _maxTiers;
  }

  function totalTiers() external view virtual returns (uint256) {
    return _totalTiers;
  }

  function tierInfo(
    uint256 tierId_
    ) external view virtual returns (uint256 totalSupply, string memory name) {
      require(tierId_ <= _totalTiers, "TIER_UNAVAILABLE");
      Tier storage tier = _tier[tierId_];
      return (tier.totalSupply, tier.name);
  }

  // TODO: incorrect?
  function tierTokenByIndex(
    uint256 tierId_,
    uint256 index_
  ) external view returns (uint256) {
    require(tierId_ <= _totalTiers, "TIER_UNAVAILABLE");
    return (index_ * _maxTiers) + tierId_;
  }

  function tierTokenOfOwnerByIndex(
    address owner_,
    uint256 tierId_,
    uint256 index_
  ) external view returns (uint256) {
    require(tierId_ <= _totalTiers, "TIER_UNAVAILABLE");
    require(index_ < _ownerTierBalance[owner_][tierId_], "INVALID_INDEX");
    return _ownerTierToken[owner_][tierId_][index_];
  }

  function balanceOfTier(
    address owner_,
    uint256 tierId_
  ) external view virtual returns (uint256) {
    require(tierId_ <= _totalTiers, "TIER_UNAVAILABLE");
    return _ownerTierBalance[owner_][tierId_];
  }

  function rentalDayByTokenId(uint256 tokenId) external view returns (RentalDay memory) {
    return tokenIdToRentalDay[tokenId];
  }
}