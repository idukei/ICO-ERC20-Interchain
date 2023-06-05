// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0;

import {TokenCollateral} from "hyperlane-token/contracts/HypERC20Collateral.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC721/IERC20.sol";

/**
 * @title Hyperlane ERC20 Token Collateral that wraps an existing ERC721 with remote transfer functionality.
 */
contract BoletokenInterchain is TokenCollateral {
    IERC20 public immutable wrappedToken;
     
    constructor(address erc20) {
        wrappedToken = IERC20(erc20);
    }

    /**
     * @notice Initializes the Hyperlane router.
     * @param _mailbox The address of the mailbox contract.
     * @param _interchainGasPaymaster The address of the interchain gas paymaster contract.
     */
    function initialize(address _mailbox, address _interchainGasPaymaster)
        external
        initializer
    {
        __HyperlaneConnectionClient_initialize(
            _mailbox,
            _interchainGasPaymaster
        );
    }

    ///Funciones Heredadas de HypERC20Collateral.sol no hace falta ponerlas

    /**
     * @dev Transfers `_tokenId` of `wrappedToken` from `msg.sender` to this contract.
     * @inheritdoc TokenRouter
     */
    function _transferFromSender(uint256 _tokenId)///Import contrct and Use in Exchange
        internal
        virtual
        override
        returns (bytes memory)
    {
        // safeTransferFrom not used here because recipient is this contract
        wrappedToken.transferFrom(msg.sender, address(this), _tokenId);
        return bytes(""); // no metadata
    }

    /**
     * @dev Transfers `_tokenId` of `wrappedToken` from this contract to `_recipient`.
     * @inheritdoc TokenRouter
     */
    function _transferTo(/// Funcionalidad usada en Exchange
        address _recipient,
        uint256 _tokenId,
        bytes calldata // no metadata
    ) internal override {
        wrappedToken.safeTransferFrom(address(this), _recipient, _tokenId);
    }
}