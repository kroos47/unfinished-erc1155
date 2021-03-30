pragma solidity ^0.5.0;

import "https://github.com/0xsequence/erc-1155/blob/master/src/contracts/tokens/ERC1155/ERC1155.sol"
import "https://github.com/0xsequence/erc-1155/blob/master/src/contracts/tokens/ERC1155/ERC1155Metadata.sol"
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "./Strings.sol"

contract DotaItems is ERC1155,ERC1155Metadata,Ownable {
    using Strings for string;
    
    mapping(uint=>address) public creators;
    mapping(uint=>uint) public tokenSupply;
    mapping(uint=>uint) public OpToId;

    enum Option{
        Mythical,
        Immortal,
        Arcana
    }
    uint NUM_OPTIONS=3;

    string public name;
    string public symbol;
    
    modifier onlyCreator(uint256 _id){
        require(creators[_id]==msg.sender."ONLY CREATOR ALLOWED");
        _;
    }

    modifier onlyOwner(uint256 _id){
        require(balances[_id]>0,"own more than zero token");
        _;
    }

    constructor(string memory _name,string memory _symbol) public {
        name=_name;
        symbol=_symbol;
    }

    string constant MetaURI="";

    function name() public view returns (string memory) {
        return "Dota Collectible Sale";
    }

    function symbol() public view returns(string memory) {
        return "DOTA";
    }

    function NoOptions() public view returns(uint256){
        return NUM_OPTIONS;
    }

    function canmint(uint256 _OptionId,uint256 _amount) public view returns(bool){
        return _canmint(msg.sender,Option(_OptionId),_amount);
    }


    function mint(address _toAddress,Option _option,uint256 _amount,bytes memory _data)internal {
        require(_canmint(uint256 _id,uint256 amount),"CANNOT MINT");
        uint256 optionId=uint256(_option);
        uint id=OpToId[optionId];
        _mint(_toAddress,id,_amount,_data);  
        tokenSupply[_id] = tokenSupply[_id].add(_amount);  
    }

    function uri(uint256 _optionId)external view returns(string memory) {
        return Strings.strConcat(
            MetaURI,
            "/",
            Strings.uint2str(_optionId)
            );

    }

     function totalSupply(uint256 _id) public view returns (uint256) {
        return tokenSupply[_id];
    }

    function _setCreator(address _to, uint256 _id) internal creatorOnly(_id){
        creators[_id] = _to;
    }
    
    function setURI(string memory _newURI)public creatorOnly{
        _setBaseMetaURI(_newURI);
    }






























}