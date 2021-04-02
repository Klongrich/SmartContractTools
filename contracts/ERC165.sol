// SPDX-License-Identifier: MIT
pragma solidity =0.8.3;

import "./Interfaces/IERC165.sol";

contract ERC165 is IERC165 {
    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}