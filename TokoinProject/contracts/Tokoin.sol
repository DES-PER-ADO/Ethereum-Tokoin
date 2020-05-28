pragma solidity >=0.4.21 <0.6.0;
// pragma experimental ABIEncoderV2;

contract Tokoin{

  address contractOwner;

  struct _Tokoin{
    uint256 _itemId;
    //string _homeAddress;
    //string _phoneNumber;
    uint _redeemTimes;
    uint _currentTime;
    uint _dateToDelivery;
    uint _DeliveryTimeInterval;
    address _client;
    address _owner;
    uint256 _tokenId;
  }

  event tokoin(
    address indexed _owner,
    uint256 _tokenId
  );

  event Transfer(
    address indexed _from,
    address indexed _to,
    uint256 _tokenId
  );

  event TokoinId(
    uint256 _tokenId
  );

  event Approval(
    address indexed _owner,
    address indexed _approved,
    uint256 _tokenId
  );

  event tokoinRedeem(
    address indexed _owner,
    uint256 _tokenId
  );

  //Tokoin internal tokoin = Tokoin({_client: 1});
  //Mapping from token ID to owner
  mapping (uint256 => address) private _tokenOwner;

  // Mapping from token ID to approved address
  mapping (uint256 => address) private _tokenApprovals;

  // Mapping from owner to Tokoin
  mapping (address => _Tokoin) private _tokoinOwner;

  // Mapping from token ID to Tokoin
  mapping (uint256 => _Tokoin) private _tokoinApprovals;

  // Mapping from owner to number of owned token
  mapping (address => uint256) private _ownedTokensCount;

  // Mapping from owner to operator approvals
  mapping (address => mapping (address => bool)) private _operatorApprovals;

  //Constructor of constract
  constructor() public {
     contractOwner = msg.sender;
  }

  function get() public view returns (address retVal) {
    return contractOwner;
  }

  // function _mint(address to, uint256 _itemId, uint _redeemTimes, uint _dateToDelivery,
  //  uint _DeliveryTimeInterval, address _client, address _owner) public returns (_Tokoin memory) {

  //   uint256 tokenId = 1;
  //   _Tokoin memory _tokoin = _Tokoin(_itemId, _redeemTimes, now, _dateToDelivery, _DeliveryTimeInterval, _client, _owner, tokenId);
  //   require(to != address(0), "Tokoin^0.1.0: mint to the zero address");
  //   require(!_exists(tokenId), "Tokoin^0.1.0: token already minted");
  //   _tokenOwner[tokenId] = to;
  //   _ownedTokensCount[to] ++;
  //   emit Transfer(address(0), to, tokenId);
  //   return _tokoin;
  //   }
  function _mint(address to, uint256 _itemId, uint _redeemTimes, uint _dateToDelivery,
  uint _DeliveryTimeInterval, address _client, address _owner) public returns (bool) {
    uint256 tokenId = 1;
    _Tokoin memory _tokoin = _Tokoin(_itemId, _redeemTimes, now, _dateToDelivery, _DeliveryTimeInterval, _client, _owner, tokenId);
    require(to != address(0), "Tokoin^0.1.0: mint to the zero address");
    require(!_exists(tokenId), "Tokoin^0.1.0: token already minted");
    _tokenOwner[tokenId] = to;
    _ownedTokensCount[to] ++;
    _tokoinOwner[to] = _tokoin;
    emit Transfer(to, to, tokenId);
    return true;
    //emit Transfer(address(0), to, tokenId);
  }

    // function _mint(address to, uint256 tokenId) public {
    //     require(to != address(0), "ERC721: mint to the zero address");
    //     require(!_exists(tokenId), "ERC721: token already minted");

    //     _tokenOwner[tokenId] = to;
    //     _ownedTokensCount[to] ++;

    //     emit Transfer(address(0), to, tokenId);
    // }

  //Get the amount of tokens owned by the specific address
  function balanceOf(address _owner) public view returns (uint256) {
    require(_owner != address(0), "Tokoin^0.1.0: balance query for the zero address");
    return _ownedTokensCount[_owner];
    }

  //Get the owner of the specified token ID.
  function ownerOf(uint256 _tokenId) public view returns (address) {
    address _owner = _tokenOwner[_tokenId];
    require(_owner != address(0), "Tokoin^0.1.0: owner query for nonexistent token");
    return _owner;
    }

  /**
   * @dev Tells whether an operator is approved by a given owner.
   * @param owner owner address which you want to query the approval of
   * @param operator operator address which you want to query the approval of
   * @return bool whether the given operator is approved by the given owner
   */
  function isApprovedForAll(address owner, address operator) public view returns (bool) {
    return _operatorApprovals[owner][operator];
  }

  //Approves another address to transfer the given token ID
  function approve(address to, uint256 tokenId) public {
    address owner = ownerOf(tokenId);
    require(to != owner, "Tokoin^0.1.0: approval to current owner");
    require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "Tokoin^0.1.0: approve caller is not owner nor approved for all");
    _tokenApprovals[tokenId] = to;
    emit Approval(owner, to, tokenId);
    }

  /**
   * @dev Returns whether the specified token exists.
   * @param tokenId uint256 ID of the token to query the existence of
   * @return bool whether the token exists
   */
  function _exists(uint256 tokenId) internal view returns (bool) {
    address owner = _tokenOwner[tokenId];
    return owner != address(0);
    }

  /**
   * @dev Gets the approved address for a token ID, or zero if no address set
   * Reverts if the token ID does not exist.
   * @param tokenId uint256 ID of the token to query the approval of
   * @return address currently approved for the given token ID
   */
  function getApproved(uint256 tokenId) public view returns (address) {
    require(_exists(tokenId), "Tokoin^0.1.0: approved query for nonexistent token");
    return _tokenApprovals[tokenId];
  }

  /**
   * @dev Returns whether the given spender can transfer a given token ID.
   * @param spender address of the spender to query
   * @param tokenId uint256 ID of the token to be transferred
   * @return bool whether the msg.sender is approved for the given token ID,
   * is an operator of the owner, or is the owner of the token
   */
  function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
    require(_exists(tokenId), "Tokoin^0.1.0: operator query for nonexistent tokoin");
    address owner = ownerOf(tokenId);
    return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

  /**
   * @dev Private function to clear current approval of a given token ID.
   * @param tokenId uint256 ID of the token to be transferred
   */
  function _clearApproval(uint256 tokenId) private {
    if (_tokenApprovals[tokenId] != address(0)) {
      _tokenApprovals[tokenId] = address(0);
      }
  }

  function _transferFrom(address from, address to, uint256 tokenId) public returns (bool) {
    require(ownerOf(tokenId) == from, "Tokoin^0.1.0: transfer of tokoin that is not own");
    require(to != address(0), "Tokoin^0.1.0: transfer to the zero address");

    _clearApproval(tokenId);

    _ownedTokensCount[from] --;
    _ownedTokensCount[to] ++;

    _tokenOwner[tokenId] = to;

    emit Transfer(from, to, tokenId);

    return true;
    }
  /**
   * @dev Transfers the ownership of a given token ID to another address.
   * Usage of this method is discouraged, use `safeTransferFrom` whenever possible.
   * Requires the msg.sender to be the owner, approved, or operator.
   * @param from current owner of the token
   * @param to address to receive the ownership of the given token ID
   * @param tokenId uint256 ID of the token to be transferred
   */
  function transferFrom(address from, address to, uint256 tokenId) public {
    //solhint-disable-next-line max-line-length
    require(_isApprovedOrOwner(msg.sender, tokenId), "Tokoin^0.1.0: transfer caller is not owner nor approved");
    _transferFrom(from, to, tokenId);
    }

  /**
   * _redeemCheckCondition
   * Get the time (location), check if it is reasonable
   */
  function _redeemCheckCondition(uint256 tokenId) public view returns (bool){
      uint DeliveryTimeInterval = _tokoinApprovals[tokenId]._DeliveryTimeInterval;
      uint currentTime = _tokoinApprovals[tokenId]._currentTime;
      return (now >= (currentTime + DeliveryTimeInterval) || now <= (currentTime + DeliveryTimeInterval + 10 minutes));
  }

  /**
   * _redeemCheckTrail
   * Check the full trail of tokoin transfer is legal
   * This is related to ABE
   */


  /**
   * _redeemVerification
   * Verify the owner of tokoin
   */
  function _redeemVerification(address from, uint256 tokenId) public returns (bool) {
    require(ownerOf(tokenId) == from, "Tokoin^0.1.0: redeem of tokoin that is not own");
    emit tokoinRedeem(from, tokenId);
    return true;
  }

  /**
   * _tokoinRedeem includes _redeemCheckCondition, _redeemCheckTrail, _redeemVerification
   *
   */
  function _tokoinRedeem(address from, address to, uint256 tokenId) public returns (bool) {
    require(ownerOf(tokenId) == from, "Tokoin^0.1.0: redeem of tokoin that is not own");
    if( _redeemCheckCondition(tokenId) == true || _redeemVerification(from, tokenId) == true){
        _transferFrom(from, to, tokenId);
        emit tokoinRedeem(from, tokenId);
        return true;
    }
    else return false;
  }

//   modifier ownerRestricted {
//       require(owner == msg.sender);
//       _;
//   }

  /**
   * modify access rule
   */
  function _accessRule(uint256 _itemId, uint _redeemTimes, uint _dateToDelivery,
  uint _DeliveryTimeInterval, address _client, address _owner, uint256 tokenId) public returns (bool) {
    if (contractOwner == msg.sender){
      _tokoinApprovals[tokenId] = _Tokoin(_itemId, _redeemTimes, now,
       _dateToDelivery, _DeliveryTimeInterval, _client, _owner, tokenId);
      return true;
    } else {
         log("Tokoin^0.1.0: deconstruction of contract that is not own: ", msg.sender);
    }
  }

  /**
   * modify access rule
   */
  function _accessOutput() public {
    if (contractOwner == msg.sender){
        log("IoT actions: ", msg.sender);
    } else {
         log("Tokoin^0.1.0: deconstruction of contract that is not own: ", msg.sender);
    }
  }

  /**
   * Burn tokoin and destroy contract
   */
  function _accessRevocation() public returns (bool) {
     if (contractOwner == msg.sender){
         selfdestruct(msg.sender);
         return true;
     } else {
         log("Tokoin^0.1.0: deconstruction of contract that is not own: ", msg.sender);
         return false;
     }
  }

  /**
   * log for error message
   */
  event LogAddress(string, address);
  function log(string memory s, address x) internal {
      emit LogAddress(s, x);
  }

}
