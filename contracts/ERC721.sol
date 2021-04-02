// SPDX-License-Identifier: MIT
pragma solidity =0.8.3;

import "./Interfaces/IERC721.sol";

    
contract ERC721 is IERC721 {
    string public name;
    string public symbol;

    mapping (address => uint256) public override balanceOf;
    mapping (uint256 => address) public override ownerOf;
    mapping (uint256 => address) public tokenAproved;
    mapping (address => mapping (address => bool)) private operatorApproved;

    constructor (string memory _name, string memory _symbol) {
        _name = name;
        _symbol = symbol;
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) external override payable {
        require(ownerOf[_tokenId] == msg.sender, "Caller is not owner of token");
        require(tokenAproved[_tokenId] == _to , "Token is not approved");
        require(address(0) != _to , "_to address is null");

        ownerOf[_tokenId] = _to;
        balanceOf[_to] += 1;
        balanceOf[_from] -= 1;

        emit Transfer(_from, _to, _tokenId);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external override payable {
        require(ownerOf[_tokenId] == msg.sender, "Caller is not owner of token");
        require(tokenAproved[_tokenId] == _to , "Token is not approved");
        require(address(0) != _to, "_to address is null");

        ownerOf[_tokenId] = _to;
        balanceOf[_to] += 1;
        balanceOf[_from] -= 1;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external override payable {
        require(ownerOf[_tokenId] == msg.sender , "msg.sender is not the owner");
        require(ownerOf[_tokenId] == _from , "_from is not owner of nft");
        require(ownerOf[_tokenId] != address(0) , "Token Doesn't exsit");
        require(address(0) != _to , "_to address is null");

        ownerOf[_tokenId] = _to;
        balanceOf[_to] += 1;
        balanceOf[_from] -= 1;

        emit Transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external override payable {
        require(ownerOf[_tokenId] != _approved , "_approved can't be owner");
        tokenAproved[_tokenId] = _approved;

        emit Approval(ownerOf[_tokenId], _approved, _tokenId);
    }

    function getApproved(uint256 _tokenId) external override view returns (address) {
        return (tokenAproved[_tokenId]);
    }
}