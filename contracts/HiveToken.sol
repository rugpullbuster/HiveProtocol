// SPDX-License-Identifier: Unlicensed
/********************************************************************************************
/        \_____/        \_____/        \_____/        \_____/        \_____/        \_____/
\        /     \        /     \        /     \        /     \        /     \        /     \
 \      /       \      /       \      /       \      /       \      /       \      /       \
  >----<         >----<         >----<         >----<         >----<         >----<         >
 /      \       /      \       /      \       /      \       /      \       /      \       /
/        \_____/        \_____/        \_____/        \_____/        \_____/        \_____/
\        /     \        /     \        /     \        /     \        /     \        /     \
 \      /       \      /       \      /       \      /       \      /       \      /       \
  >----<         >----<         >----<         >----<         >----<         >----<         >
 /      \       /      \       /      \       /      \       /      \       /      \       /
/        \_____/     ‗‗‗\‗‗‗‗‗/‗‗‗‗‗‗‗‗\‗‗‗‗‗/‗‗‗‗‗‗‗‗\‗‗‗‗‗/‗‗‗‗‗‗‗‗\‗‗‗‗_/        \_____/
\        /     \    ║                                                    ║ \        /     \
 \      /       \   ║             RUGPULL BUSTER PROJECT                 ║  \      /       \
  >----<         >--║                 ‗‗‗    ‗‗‗‗‗          ‗‗‗          ║   >----<         >
 /      \       /   ║   ║  ║ ║ ║   ║ ║         ║   /║  ║ / ║     ║\   ║  ║  /      \       /
/        \_____/    ║   ║  ║ ║ ║   ║ ║         ║  ║ ║  ║/  ║     ║ \  ║  ║_/        \_____/
\        /     \    ║   ╠══╣ ║ ║  /  ╠══       ║  ║ ║  ║\  ╠══   ║  \ ║  ║ \        /     \
 \      /       \   ║   ║  ║ ║ ║/    ║‗‗‗      ║  ║/   ║ \ ║‗‗‗  ║   \║  ║  \      /       \
  >----<         >--║                                                    ║   >----<         >
 /      \       /   ║               http://hiveprotocol.tk               ║  /      \       /        
/        \_____/    ║‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗║_/        \_____/    
\        /     \        /     \        /     \        /     \        /     \        /     \
 \      /       \      /       \      /       \      /       \      /       \      /       \ 
  >----<         >----<         >----<         >----<         >----<         >----<         >
 /      \       /      \       /      \       /      \       /      \       /      \       /
/        \_____/        \_____/        \_____/        \_____/        \_____/        \_____/
\        /     \        /     \        /     \        /     \        /     \        /     \
 \      /       \      /       \      /       \      /       \      /       \      /       \
  >----<         >----<         >----<         >----<         >----<         >----<         >
 /      \       /      \       /      \       /      \       /      \       /      \       /
/        \_____/        \     /        \_____/        \_____/        \     /        \_____/
*********************************************************************************************/
pragma solidity ^0.8.0;
/********************************************************************************************/
/*                                      Interfaces                                          */
/********************************************************************************************/
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
interface IUniswapV2Router01 {
    function WETH() external pure returns (address);
    function addLiquidityETH(address token, uint amountTokenDesired, uint amountTokenMin, uint amountETHMin, address to, uint deadline) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(address tokenA, address tokenB, uint liquidity, uint amountAMin, uint amountBMin, address to, uint deadline) external returns (uint amountA, uint amountB);
}
interface IUniswapV2Router02 is IUniswapV2Router01 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline) external;
}
interface IUniswapV2Pair {
    function balanceOf(address owner) external view returns (uint);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint value) external returns (bool);
    function token0() external view returns (address);
}
interface IAccessControl {
    function hasRole(bytes32 role, address account) external view returns (bool);
    function getRoleAdmin(bytes32 role) external view returns (bytes32);
    function grantRole(bytes32 role, address account) external;
    function revokeRole(bytes32 role, address account) external;
    function renounceRole(bytes32 role, address account) external;
}
/********************************************************************************************/
/*                                      Libraries                                           */
/********************************************************************************************/
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}
library Strings {
    bytes16 private constant alphabet = "0123456789abcdef";

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = alphabet[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }

}
/********************************************************************************************/
/*                              Absctract Contracts                                         */
/********************************************************************************************/
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}
abstract contract AccessControl is Context, IAccessControl {
    struct RoleData {
        mapping (address => bool) members;
        bytes32 adminRole;
    }

    mapping (bytes32 => RoleData) private _roles;

    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    /**
     * @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
     *
     * `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
     * {RoleAdminChanged} not being emitted signaling this.
     *
     * _Available since v3.1._
     */
    event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);

    /**
     * @dev Emitted when `account` is granted `role`.
     *
     * `sender` is the account that originated the contract call, an admin role
     * bearer except when using {_setupRole}.
     */
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Emitted when `account` is revoked `role`.
     *
     * `sender` is the account that originated the contract call:
     *   - if using `revokeRole`, it is the admin role bearer
     *   - if using `renounceRole`, it is the role bearer (i.e. `account`)
     */
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Modifier that checks that an account has a specific role. Reverts
     * with a standardized message including the required role.
     *
     * The format of the revert reason is given by the following regular expression:
     *
     *  /^AccessControl: account (0x[0-9a-f]{20}) is missing role (0x[0-9a-f]{32})$/
     *
     * _Available since v4.1._
     */
    modifier onlyRole(bytes32 role) {
        _checkRole(role, _msgSender());
        _;
    }

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) public view override returns (bool) {
        return _roles[role].members[account];
    }

    /**
     * @dev Revert with a standard message if `account` is missing `role`.
     *
     * The format of the revert reason is given by the following regular expression:
     *
     *  /^AccessControl: account (0x[0-9a-f]{20}) is missing role (0x[0-9a-f]{32})$/
     */
    function _checkRole(bytes32 role, address account) internal view {
        if(!hasRole(role, account)) {
            revert(string(abi.encodePacked(
                "AccessControl: account ",
                Strings.toHexString(uint160(account), 20),
                " is missing role ",
                Strings.toHexString(uint256(role), 32)
            )));
        }
    }

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) public view override returns (bytes32) {
        return _roles[role].adminRole;
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function grantRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _grantRole(role, account);
    }

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function revokeRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _revokeRole(role, account);
    }

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been granted `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `account`.
     */
    function renounceRole(bytes32 role, address account) public virtual override {
        require(account == _msgSender(), "AccessControl: can only renounce roles for self");

        _revokeRole(role, account);
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event. Note that unlike {grantRole}, this function doesn't perform any
     * checks on the calling account.
     *
     * [WARNING]
     * ====
     * This function should only be called from the constructor when setting
     * up the initial roles for the system.
     *
     * Using this function in any other way is effectively circumventing the admin
     * system imposed by {AccessControl}.
     * ====
     */
    function _setupRole(bytes32 role, address account) internal virtual {
        _grantRole(role, account);
    }

    /**
     * @dev Sets `adminRole` as ``role``'s admin role.
     *
     * Emits a {RoleAdminChanged} event.
     */
    function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal virtual {
        emit RoleAdminChanged(role, getRoleAdmin(role), adminRole);
        _roles[role].adminRole = adminRole;
    }

    function _grantRole(bytes32 role, address account) private {
        if (!hasRole(role, account)) {
            _roles[role].members[account] = true;
            emit RoleGranted(role, account, _msgSender());
        }
    }

    function _revokeRole(bytes32 role, address account) private {
        if (hasRole(role, account)) {
            _roles[role].members[account] = false;
            emit RoleRevoked(role, account, _msgSender());
        }
    }
}
/********************************************************************************************/
/* HIVEToken :: Governance token of RugPull Buster Project                                  */
/********************************************************************************************/
contract HIVEToken is IERC20, AccessControl {                                               //
    using SafeMath for uint256;                                                             // Safe math operations utility library
    using Address for address;                                                              // address utility library
                                                                                            //
    /*      structs         */                                                              //                                                  
    struct AddrType {                                                                       // address type struct
        bool wallet;                                                                        // address is a wallet addr (not contract nor burn)
        bool _contract;                                                                     // address is a contract address
        bool burn;                                                                          // address is a burn address(has alot of zeros)
    }                                                                                       //
    struct Pancakeswap {                                                                    // uniswap interfaces struct
        IUniswapV2Router02 uniswapV2Router;                                                 // Pancakeswap V2 Router Instance
        IUniswapV2Pair uniswapV2Pair;                                                       // Pancakeswap V2 Pair Instance
    }                                                                                       //
    struct Snapshot {                                                                       // Staking interval snapshot struct
        uint256 timestamp;                                                                  // Staking Snapshot Timestamp
        uint256 totStaked;                                                                  // Total Amount of Tokens Staked during the interval
        uint256 totTokenReward;                                                             // Total amount of Token Rewards collected during the interval
        uint256 totETHReward;                                                               // Total Amount of ETH Rewards collected during the interval
        uint256 totTokenClaimed;                                                            // Accumulator for Total amount of Token claimed >> cleanup
        uint256 totETHClaimed;                                                              // Accumulator for Total amount of ETH claimed >> cleanup
    }                                                                                       //
    struct UserTrade {                                                                      // User Transaction Logging struct
        uint256 timestamp;                                                                  // Transaction Timestamp
        uint256 tradeAmount;                                                                // amount of token transfered
        uint256 tBalance;                                                                   // token balance of the account after transfer
        uint256 rewardTokenBalance;                                                         // snapshot of token rewards to the time of transaction
        uint256 rewardETHBalance;                                                           // snapshot of ETH rewards to the time of transaction
        bool sellFlag;                                                                      // a flag set if the transac was a sell trade
    }                                                                                       //
    struct Authorize {                                                                      // Multi-Sig Authorization struct
        address[] sigs;                                                                     // authorized signature address array
        bool processed;                                                                     // flag to validate the auth request
    }                                                                                       //
                                                                                            //
    /*          events      */                                                              //
    event OwnershipRenounced( address prevOwner, address currentOwner, uint256 time);       //
    event SellingFeeCollected(address indexed sender, address indexed recipient, uint256 transferAmount, uint256 taxAmount, uint256 time);
    event SwapAndLiquify( uint256 tokensSwapped, uint256 ethReceived, uint256 tokensIntoLiqudity);
    event StakingSnapshot(uint256 totTokenReward,uint256 totETHReward, uint256 totStaked, uint256 time);
    event ClaimRewards(address indexed owner, uint256 tokenClaimed, uint ETHClaimed);       //
    event LiquidityGenerated(uint256 amountLP,uint256 amountToken, uint256 amountETH, uint256 time);
    event FinancialCleanup(uint256 amountToken, uint256 amountETH, uint256 time);           //
                                                                                            //
    /*  mappings/Arrays     */                                                              //
    mapping(address => UserTrade[]) public userTrade;                                       // User Trading Transaction Tracking
    mapping(address => mapping(address => uint256)) public override allowance;              // approvals mapping
    mapping(uint256 => Authorize) public multiSigReq;                                       // Multi Signature Auth Requests
    Snapshot[] public stakingLedger;                                                        // Stacking Interval Totals Tracking 
                                                                                            //
    /*      constants       */                                                              //
    address private immutable WETH;                                                         // address of WETH
    uint256 public constant override totalSupply = 1e12 * 1e8;                              // 1 Trillion supply ** 8 decimals
    string public constant name = 'HIVE Protocol';                                          // token name
    string public constant symbol = 'HVE';                                                  // token symbol
    uint8 public constant decimals = 8;                                                     // token symbols
                                                                                            //
    uint256 public constant FLAT_FEE = 5;                                                   // Flat 5% back to liquidity(SwapAndLiquify) + another 5% stacking reward
    uint256 public constant ANTI_WHALE_MIN_FEE = 10;                                        // Linear Anti-Whale Fee: min 1% of pair liquidity
    uint256 public constant ANTI_WHALE_MAX_FEE = 50;                                        // Linear Anti-Whale Fee: max deduction of 5%
    uint256 private constant minTokensToSwapAndLiquify = 5e8 * 1e8;                         // 500M : minimum internal balance to initiate a swap and liquify
                                                                                            //
    uint256 private immutable  initTimestamp ;                                              // Contract Deployment Timestamp
    uint256 public immutable minStackingInterval;                                           // Min Staking Reward Distribution Interval
                                                                                            //
    bytes32 public constant SETTER_ROLE = keccak256('SETTER_ROLE');                         // Setter Role >> renounced after init
    bytes32 public constant LIQMGR_ROLE = keccak256('LIQMGR_ROLE');                         // Liquidity Manager Role >> maintained to make useliquidity accumuaated when needed
    bytes32 public constant FINMGR_ROLE = keccak256('FINMGR_ROLE');                         // Financial Manager Role >> maintained for financial housekeeping when needed
                                                                                            //
    /*      variables       */                                                              //
    address public tokenOwner;                                                              // owner definition
    address private pairAddr;                                                               // Pancakeswap v2 Pair Address
    Pancakeswap private PANCAKESWAP;                                                        // Pancakeswap Contracts
    bool public taxEnabled;                                                                 // Enable/Disable taxing
    bool internal inSwapAndLiquify;                                                         // prevent circular loop when SwapAndLiquify
    uint256 public  swapAndLiquifyBalance ;                                                 // accumulate tokens till minTokensToSwapAndLiquify is met
                                                                                            //
    uint256 public  circulatingSupply ;                                                     // total count of tokens in wallets(excluding contracts and known burn addresses ballances)
    uint256 public  totStakedTokens ;                                                       // total count of tokens auto-staked
    uint256 public  lastSnapshotTimestamp ;                                                 // Stacking Interval Snapshot tracking
    uint256 public  intervalTokenRewardAccum ;                                              // Stacking Interval Token Reward Accumulator
    uint256 public  intervalETHRewardAccum ;                                                // Stacking Interval ETH Reward Accumulator
                                                                                            //
    /*      modifiers       */                                                              //
    modifier onlyOwner() {                                                                  // Limit Method caller to only owner
        require(_msgSender() == tokenOwner, 'HIVEToken: Caller is not the owner' );         // revert if caller is not the owner
        _;                                                                                  //
    }                                                                                       //
    modifier onlyAdmin() {                                                                  // Limit Method caller to Only of Setter Group
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), 'HIVEToken: Caller is not an Admin' );// revert if the caller is not in the Setter Group
        _;                                                                                  //
    }                                                                                       //
    modifier onlyLiqMgr() {                                                                 // Limit Method caller to Only of Liquidity Manager Group
        require(hasRole(LIQMGR_ROLE, _msgSender()), 'HIVEToken: Caller is not a Liquidity Manager' );
        _;                                                                                  //
    }                                                                                       //
    modifier onlyFinMgr() {                                                                 // Limit Method caller to Only of FInancial Manager Group
        require(hasRole(FINMGR_ROLE, _msgSender()), 'HIVEToken: Caller is not a Financial Manager' );
        _;                                                                                  //
    }                                                                                       //
    modifier onlyAfterAYear() {                                                             // Limit Method calling to after a time interval of 1 year
        require(block.timestamp > initTimestamp + 365 days , 'HIVEToken: Method Timing rate is not met' );
        _;                                                                                  //
    }                                                                                       //
    modifier lockTheSwap {                                                                  // Lock the method from re-entrance
        inSwapAndLiquify = true;                                                            // set the flag on entrance
        _;                                                                                  // process the method
        inSwapAndLiquify = false;                                                           // reset the flag after processing
    }                                                                                       //
    /****************************************************************************************/
    /*                          Constructor method                                          */
    /****************************************************************************************/
    constructor(address routerAddr, uint256 minStakingIntervalDays) {                       //
        PANCAKESWAP.uniswapV2Router= IUniswapV2Router02(routerAddr);                        // Init Uniswap V2 Router Interface Implementation
        WETH = PANCAKESWAP.uniswapV2Router.WETH();                                          // Init WETH address
                                                                                            //
        tokenOwner = _msgSender();                                                          // Define the Owner as the contract creator
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());                                       // setup Admin(ownership) Role to creator
        _setupRole(LIQMGR_ROLE, _msgSender());                                              // assign Liquidity Manager Role to creator
        _setupRole(FINMGR_ROLE, _msgSender());                                              // assign Financial Manager Role to creator
                                                                                            //
        initTimestamp = block.timestamp;                                                    // define deployment timestamp
        lastSnapshotTimestamp = block.timestamp;                                            // init stacking interval timing
        minStackingInterval = minStakingIntervalDays * 1 days;                              // define stacking interval
        intervalETHRewardAccum = 0;                                                         // init ETH Reward Accumulator
    }                                                                                       //
    /****************************************************************************************/
    /*                       Public/External Methods                                        */
    /****************************************************************************************/
    //////////////////////////////////////////////////////////////////////////////////////////
    /* fallback, to recieve ETH and accumulate as ETH reward << msg.data empty              */
    /* Access       : None/public                                                           */
    //////////////////////////////////////////////////////////////////////////////////////////
    receive() external payable {                                                            //
        intervalETHRewardAccum = intervalETHRewardAccum.add(msg.value);                     // accumulate the incoming ETH when msg.data is empty
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* fallback, to recieve ETH and accumulate as ETH reward << msg.data not empty          */
    /* Access       : None/public                                                           */
    //////////////////////////////////////////////////////////////////////////////////////////
    fallback() external payable {                                                           //
        intervalETHRewardAccum = intervalETHRewardAccum.add(msg.value);                     // accumulate the incoming ETH when msg.data is not empty
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* Initialization method >> called once as required roles get renounced within          */
    /* Access       : Only Owner or Setter Role Group                                       */
    //////////////////////////////////////////////////////////////////////////////////////////
    function init(address[4] calldata _mgrAccounts) external onlyOwner onlyAdmin returns(bool success){
        // define Dev Wallets as liquidity/Financial managers                               // << MultiSig Wallets
        for (uint256 idx = 0; idx < _mgrAccounts.length; idx++) {                           // loop through management accounts
            _setupRole(LIQMGR_ROLE, _mgrAccounts[idx]);                                     // assign Liquidity Manager Role
            _setupRole(FINMGR_ROLE, _mgrAccounts[idx]);                                     // assign Financial Manager Role
        }                                                                                   //
                                                                                            //
        // totalsupply goes to main dev wallet                                              // 40% locked + 60% goes to presale(ultimately ps v2 pair)
        UserTrade memory initTransac = UserTrade(block.timestamp, totalSupply, totalSupply, 0, 0, false);
        userTrade[_msgSender()].push(initTransac);                                          // log the transaction
        emit Transfer(address(0), _msgSender(), totalSupply);                               // emit the event
                                                                                            //
        // initialize staking system and take first snapshot                                //
        circulatingSupply = totalSupply;                                                    // init circulating supply with total
        totStakedTokens = circulatingSupply;                                                // init total staked tokens
        Snapshot memory snapshot = Snapshot(block.timestamp, totStakedTokens, 0, 0, 0, 0);  //
        stakingLedger.push(snapshot);                                                       // push the snapshot
                                                                                            //
        // disable taxing for a smooth presale                                              //
        taxEnabled = false;                                                                 // set the trade enable flag to false
                                                                                            //
        // revoke Admin role >> once done can not re-init                                   //
        renounceRole(DEFAULT_ADMIN_ROLE, _msgSender());                                     // renounce Admin Role
        tokenOwner = address(0);                                                            // renounce ownership
        emit OwnershipRenounced(_msgSender(), address(0), block.timestamp);                 // Emit renounceOwnership event
        return true;                                                                        //
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* IERC20: get balance of an account method                                             */
    //////////////////////////////////////////////////////////////////////////////////////////
    function balanceOf(address _account) public view override returns (uint256 balance) {   //
        if(userTrade[_account].length > 0)                                                  // check if account has a transac log
            return userTrade[_account][userTrade[_account].length -1].tBalance;             // return the balance
        else                                                                                //
            return 0;                                                                       // return zero balance
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* IERC20: Transfer tokens between addresses                                            */
    //////////////////////////////////////////////////////////////////////////////////////////
    function transfer(address recipient, uint256 amount) external virtual override returns (bool success) {
        _transfer(_msgSender(), recipient, amount);                                         // call the internal transfer function
        return true;                                                                        //
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* IERC20: spend on behalf of the owner                                                 */
    //////////////////////////////////////////////////////////////////////////////////////////
    function transferFrom(address sender, address recipient, uint256 amount) external virtual override returns (bool success) {
        _transfer(sender, recipient, amount);                                               // call the internal transfer function then update allowance
        _approve(sender, _msgSender(), allowance[sender][_msgSender()].sub(amount, 'ERC20: transfer amount exceeds allowance'));
        return true;                                                                        //
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* IERC20: Approve an address to spend on behalf of the owner                           */
    //////////////////////////////////////////////////////////////////////////////////////////
    function approve(address spender, uint256 amount) external virtual override returns (bool success) {
        _approve(_msgSender(), spender, amount);                                            // call the internal approve function
        return true;                                                                        //
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* Increase allownce of an approved address                                             */
    //////////////////////////////////////////////////////////////////////////////////////////
    function increaseAllowance(address spender, uint256 addedValue) external virtual returns (bool success) {
        _approve(_msgSender(), spender, allowance[_msgSender()][spender].add(addedValue));  // call the internal approve function
        return true;                                                                        //
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* Decrease allownce of an approved address                                             */
    //////////////////////////////////////////////////////////////////////////////////////////
    function decreaseAllowance(address spender, uint256 subtractedValue) external virtual returns (bool success) {
        _approve(_msgSender(), spender, allowance[_msgSender()][spender].sub(subtractedValue, 'ERC20: decreased allowance below zero'));
        return true;                                                                        //
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* Init Trading >> enable taxing/staking and set pair address                           */
    //////////////////////////////////////////////////////////////////////////////////////////
    function initTrading(address _pairAddr ) external virtual onlyLiqMgr returns (bool success) {
        require(_pairAddr.isContract(), 'ERC20: Invalid pair contract address');
        pairAddr = _pairAddr;                                                               // init pairAddress
        PANCAKESWAP.uniswapV2Pair = IUniswapV2Pair(pairAddr);                               // init pair interface
        lastSnapshotTimestamp = block.timestamp;                                            // init stacking reward timing
        taxEnabled = true;                                                                  // enable taxing
        return true;                                                                        //
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* calculate due rewards balance to date for an account                                 */
    /* Access       : None/Public                                                           */
    /* Params       : None                                                                  */
    //////////////////////////////////////////////////////////////////////////////////////////
    function balanceRewards(address account) public view returns (uint256 walletBalance, uint256 dueTokenReward, uint256 dueETHReward) {
        if(userTrade[account].length == 0)                                                  // check if account had transactions
            return (0, 0, 0);                                                               // accounts holds no tokens >> no revert
        UserTrade memory lastTrade = userTrade[account][userTrade[account].length - 1];     // get last transaction balances for the account
        if(account.isContract())                                                            // check if account address is a contract
            return (lastTrade.tBalance, 0, 0);                                              // no rewards for contracts >> no revert
        walletBalance = lastTrade.tBalance;                                                 // init wallet balance variable >> just reporting
        dueTokenReward = lastTrade.rewardTokenBalance;                                      // init the amount with last calc'd value
        dueETHReward = lastTrade.rewardETHBalance;                                          // init the amount with last calc'd value
                                                                                            //
        if(stakingLedger.length == 0)                                                       // check if no ledger snapshots
            return (walletBalance, 0, 0);                                                   // no accumulated rewards just return balance
                                                                                            //
        uint ledgerIdx = type(uint).max;                                                    // init with a unique value to check if a match found
        for(uint j = stakingLedger.length -1 ; j >= 0; j--){                                // get first ledger match after last user transac
            if(lastTrade.timestamp >= stakingLedger[j].timestamp){                          // check if timestamp is just after than last snapshot
                if(!lastTrade.sellFlag && lastTrade.timestamp == stakingLedger[j].timestamp)// if trade was a buy and at the begining of the snapshot
                    ledgerIdx = j + 1;                                                      // all balance are accounted as staked on the next snapshot
                else if (!lastTrade.sellFlag && j < (stakingLedger.length -1)){             // if trade was a buy in the middle of a snapshot
                    uint prevBal = lastTrade.tBalance.sub(lastTrade.tradeAmount);           // only the previous balance is accounted as staked on j+1
                    uint amount = prevBal.mul(1000000000000000000).div(stakingLedger[j+1].totStaked).mul(stakingLedger[j+1].totTokenReward).div(1000000000000000000);
                    dueTokenReward = dueTokenReward.add(amount);                            // accumulate calc'd token rewards for this interval
                    amount = prevBal.mul(1000000000000000000).div(stakingLedger[j+1].totStaked).mul(stakingLedger[j+1].totETHReward).div(1000000000000000000);
                    dueETHReward = dueETHReward.add(amount);                                // accumulate calc'd ETH rewards for this interval
                    ledgerIdx = j + 2;                                                      //
                }                                                                           //
                else                                                                        //
                    ledgerIdx = j + 2;                                                      // a sell trade: skip this snapshot, account by the end of the one after
                break;                                                                      // abort the loop
            }                                                                               //
        }                                                                                   //
        if(ledgerIdx == type(uint).max)                                                     // check if no ledger intervals to be processed
            return (walletBalance, 0, 0);                                                   // no accumulated rewards just return balance
                                                                                            //
        // amounts might be fractions so we need to do a fixed point by 18places            //
        for(uint j = ledgerIdx ; j < stakingLedger.length; j++){                            // loop through stacking intervals and accumulate rewards
            uint amount = lastTrade.tBalance.mul(1000000000000000000).div(stakingLedger[j].totStaked).mul(stakingLedger[j].totTokenReward).div(1000000000000000000);
            dueTokenReward = dueTokenReward.add(amount);                                    // accumulate calc'd token rewards for this interval
            amount = lastTrade.tBalance.mul(1000000000000000000).div(stakingLedger[j].totStaked).mul(stakingLedger[j].totETHReward).div(1000000000000000000);
            dueETHReward = dueETHReward.add(amount);                                        // accumulate calc'd ETH rewards for this interval
        }                                                                                   //
        return (walletBalance, dueTokenReward, dueETHReward);                               // return balance and reward amounts
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* Method for an Account to claim rewards                                               */
    /* Access       : None/Public                                                           */
    /* Params       : None                                                                  */
    //////////////////////////////////////////////////////////////////////////////////////////
    function claimRewards() external virtual returns (bool success) {                       //
        require(!_msgSender().isContract(), 'HIVEToken: No Rewards for contracts');         // revert if the sender is a contract
        (uint256 balance, uint256 amtToken, uint256 amtETH) = processRewards(_msgSender()); // process rewards balance through ledger intervals
        require(amtToken > 0 || amtETH > 0, 'HIVEToken: No Reward balance to claim');       // revert if no rewards of neither token nor ETH
        if(amtToken > 0){                                                                   // check if there's a token reward
            uint contractBalance = balanceOf(address(this));                                // get contract token balance
            uint contractRewardBalance = contractBalance.sub(swapAndLiquifyBalance);        // subtract swapAndLiquifyBalance to get total reward balance
            // revert if the contract token balance deviates                                //
            require(contractRewardBalance >= amtToken, 'HIVEToken: Not Enough Reward Token Balance');
            UserTrade memory claimTransac = UserTrade(block.timestamp, amtToken, balance.add(amtToken), 0, 0, false);
            userTrade[_msgSender()].push(claimTransac);                                     // log the transaction >> rewards accumulators reset
            UserTrade memory payTransac = UserTrade(block.timestamp, amtToken, contractBalance.sub(amtToken), 0, 0, false);
            userTrade[address(this)].push(payTransac);                                      // log the transaction >> rewards accumulators reset
            circulatingSupply = circulatingSupply.add(amtToken);                            // claimed tokens added to circulating supply
            emit Transfer(address(this), _msgSender(), amtToken);                           // emit the transfer event
        }                                                                                   //
        if(amtETH > 0){                                                                     // check if there's an ETH reward
            require(address(this).balance >= amtETH, 'HIVEToken: Not Enough ETH Balance');  // revert if the contract ETH balance deviates
            payable(_msgSender()).transfer(amtETH);                                         // send ETH reward
        }                                                                                   //
        emit ClaimRewards(_msgSender(), amtToken, amtETH);                                  // emit the claim event
        return true;                                                                        // success
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* use LP accumulated through fees to provide liquidity for extra exchange listing      */
    /* Access       : Only Liquidity Manager Role Group                                     */
    /* Params       :-                                                                      */
    /*  amountLP    : number of LP Tokens to consume                                        */
    /*  to          : the address to which we send the generated liquidity                  */
    /*  reqID       : Multi-Seg Request Identifier                                          */
    //////////////////////////////////////////////////////////////////////////////////////////
    function generateLiquidity(uint amountLP, address to, uint256 reqID) external virtual onlyLiqMgr returns(uint256 cntAuth, uint256 amountA, uint256 amountB) {
        require(amountLP > 0 , 'HIVEToken: Zero Requested Amount' );                        // 
        require(amountLP <= PANCAKESWAP.uniswapV2Pair.balanceOf(address(this)) , 'HIVEToken: Insufficient LP Token Balance' );
        if(authorize(reqID)){                                                               // validate if the method authorized by 3 designated addresses
            // ensure the router is approved to remove liquidity                            //
            if(PANCAKESWAP.uniswapV2Pair.allowance(address(this), address(PANCAKESWAP.uniswapV2Router)) < amountLP){
                PANCAKESWAP.uniswapV2Pair.approve(address(PANCAKESWAP.uniswapV2Router), type(uint).max);
            }                                                                               //
            // remove liquidity                                                             //
            (amountA, amountB) = PANCAKESWAP.uniswapV2Router.removeLiquidity(address(this), WETH, amountLP, 0, 0, to, block.timestamp);
            require(amountA > 0 && amountB > 0, 'HIVEToken: No Tokens Liquidated' );        // revert if no liquidity generated
            multiSigReq[reqID].processed = true;                                            // mark the current auth request as processed
            emit LiquidityGenerated(amountLP, amountA, amountB, block.timestamp);           // emit liquidity event
            return (multiSigReq[reqID].sigs.length, amountA, amountB);                      // return 
        }                                                                                   //
        return (multiSigReq[reqID].sigs.length, 0, 0);                                      // return just the approval count
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* ensure no tokens/eth get stuck in contract forever due to discrepancies or           */
    /*  dead(long unclaimed) accounts >> result goes back to stking rewards                 */
    /* Access       : Only Financial Manager Role Group - only after a year                 */
    /* Params       :-                                                                      */
    /*  reqID       : Multi-Seg Request Identifier                                          */
    //////////////////////////////////////////////////////////////////////////////////////////
    function financialCleanup(uint256 reqID) external virtual onlyFinMgr returns(uint256 cntAuth, uint256 amountToken, uint256 amountETH) {
        if(authorize(reqID)){                                                               // validate if the method authorized by 3 designated addresses
            for(uint j = 0 ; j < stakingLedger.length; j++){                                // loop through stacking intervals Snapshot
                if(block.timestamp - stakingLedger[j].timestamp > 365 days){                // ensure to clean only one year old intervals
                    if(stakingLedger[j].totTokenClaimed < stakingLedger[j].totTokenReward){ // is there unclaimed tokens stuck
                        amountToken.add(stakingLedger[j].totTokenReward.sub(stakingLedger[j].totTokenClaimed));
                    }                                                                       //
                    if(stakingLedger[j].totETHClaimed < stakingLedger[j].totETHReward){     // is there unclaimed ETH stuck
                        amountETH.add(stakingLedger[j].totETHReward.sub(stakingLedger[j].totETHClaimed));
                    }                                                                       //
                }else                                                                       //
                    break;                                                                  // no more snapshots old enough to process
            }                                                                               //
            intervalTokenRewardAccum = intervalTokenRewardAccum.add(amountToken);           // push the accumulated stuck token rewards into current interval
            intervalETHRewardAccum = intervalETHRewardAccum.add(amountETH);                 // push the accumulated stuck token rewards into current interval
            emit FinancialCleanup(amountToken, amountETH, block.timestamp);                 // emit cleanup event
            return (multiSigReq[reqID].sigs.length, amountToken, amountETH);                // return actual results
        }                                                                                   //
        return (multiSigReq[reqID].sigs.length, 0, 0);                                      // return just count of approvals
    }                                                                                       //
    /****************************************************************************************/
    /*                              Internal Methods                                        */
    /****************************************************************************************/
    //////////////////////////////////////////////////////////////////////////////////////////
    /* gets the address type (wallet,contract,burn)                                         */
    /* Params       :-                                                                      */
    /*  addr        : address to be examined                                                */
    //////////////////////////////////////////////////////////////////////////////////////////
    function getAddrType(address addr) internal view returns(AddrType memory addrType){     //
        addrType._contract = addr.isContract();                                             // if contract
        addrType.burn = !addrType._contract && isBurnAddr(addr);                            // if not contract and burn
        addrType.wallet = !addrType._contract && !addrType.burn;                            // if not contract nor burn
        return addrType;                                                                    //                                       
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* check if a burn address (having most places as zeros)                                */
    /* Params       :-                                                                      */
    /*  addr        : address to be examined                                                */
    //////////////////////////////////////////////////////////////////////////////////////////
    function isBurnAddr(address addr) internal pure returns(bool){                          //
        return uint256(uint160(addr)) < 0xffff;                                             // if has many zeros then it's a burn address
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* check/update multi-sig method authorization                                          */
    /* Params       :-                                                                      */
    /*  reqID       : Multi-Seg Request Identifier                                          */
    //////////////////////////////////////////////////////////////////////////////////////////
    function authorize(uint reqID) internal returns(bool){                                  //
        require(!multiSigReq[reqID].processed, 'HIVEToken: Request Already Processed' );    // revert if auth request is processed
        for (uint i = 0; i < multiSigReq[reqID].sigs.length; i++) {                         // ensure the sender has not already approved
            require(msg.sender != multiSigReq[reqID].sigs[i], 'HIVEToken: Already Signed the Request' );
        }                                                                                   //
        multiSigReq[reqID].sigs.push(_msgSender());                                         // increment no of approvals
        if(multiSigReq[reqID].sigs.length >= 3)                                             // minimum of 3 wallets approvals needed to auth
            return true;                                                                    // authorized
        else                                                                                //
            return false;                                                                   // need more approvals
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* collect rewards to date for an account                                               */
    /* Params       :-                                                                      */
    /*  account     : wallet address of the claiming account                                */
    //////////////////////////////////////////////////////////////////////////////////////////
    function processRewards(address account) internal returns (uint256 walletBalance, uint256 dueTokenReward, uint256 dueETHReward) {
        if(userTrade[account].length == 0)                                                  // check if account had transactions
            return (0, 0, 0);                                                               // accounts holds no tokens >> no revert
        UserTrade memory lastTrade = userTrade[account][userTrade[account].length - 1];     // get last transaction balances for the account
        if(account.isContract())                                                            // check if account address is a contract
            return (lastTrade.tBalance, 0, 0);                                              // no rewards for contracts >> no revert
        walletBalance = lastTrade.tBalance;                                                 // init wallet balance variable >> just reporting
        dueTokenReward = lastTrade.rewardTokenBalance;                                      // init the amount with last calc'd value
        dueETHReward = lastTrade.rewardETHBalance;                                          // init the amount with last calc'd valu
                                                                                            //
        if(stakingLedger.length == 0)                                                       // check if no ledger snapshots
            return (walletBalance, 0, 0);                                                   // no accumulated rewards just return balance
                                                                                            //
        uint ledgerIdx = type(uint).max;                                                    // init with a unique value to check if a match found
        for(uint j = stakingLedger.length -1 ; j >= 0; j--){                                // get first ledger match after last user transac
            if(lastTrade.timestamp >= stakingLedger[j].timestamp){                          // check if timestamp is just after than last snapshot
                if(!lastTrade.sellFlag && lastTrade.timestamp == stakingLedger[j].timestamp)// if trade was a buy and at the begining of the snapshot
                    ledgerIdx = j + 1;                                                      // all balance are accounted as staked on the next snapshot
                else if (!lastTrade.sellFlag && j < (stakingLedger.length -1)){             // if trade was a buy in the middle of a snapshot
                    uint prevBal = lastTrade.tBalance.sub(lastTrade.tradeAmount);           // only the previous balance is accounted as staked on j+1
                    uint amount = prevBal.mul(1000000000000000000).div(stakingLedger[j+1].totStaked).mul(stakingLedger[j+1].totTokenReward).div(1000000000000000000);
                    // revert if interval token balance deviates                            //
                    require(stakingLedger[j+1].totTokenReward.sub(stakingLedger[j+1].totTokenClaimed) >= amount, 'HIVEToken: Insufficient balance for the claimed tokens');
                    dueTokenReward = dueTokenReward.add(amount);                            // accumulate calc'd token rewards for this interval
                    // accumulate in interval claimed token accumulator                     //
                    stakingLedger[j+1].totTokenClaimed = stakingLedger[j+1].totTokenClaimed.add(amount);
                    amount = prevBal.mul(1000000000000000000).div(stakingLedger[j+1].totStaked).mul(stakingLedger[j+1].totETHReward).div(1000000000000000000);
                    // revert if interval ETH balance deviates                              //
                    require(stakingLedger[j+1].totETHReward.sub(stakingLedger[j+1].totETHClaimed) >= amount, 'HIVEToken: Insufficient balance for the claimed ETH');
                    dueETHReward = dueETHReward.add(amount);                                // accumulate calc'd ETH rewards for this interval
                    // accumulate in interval claimed token accumulator                     //
                    stakingLedger[j+1].totETHClaimed = stakingLedger[j+1].totETHClaimed.add(amount);    
                    ledgerIdx = j + 2;                                                      //
                }                                                                           //
                else                                                                        //
                    ledgerIdx = j + 2;                                                      // a sell trade: skip this snapshot, account by the end of the one after
                break;                                                                      // abort the loop
            }                                                                               //
        }                                                                                   //
        if(ledgerIdx == type(uint).max)                                                     // check if no ledger intervals to be processed
            return (walletBalance, 0, 0);                                                   // no accumulated rewards just return balance
                                                                                            //
        // amounts might be fractions so we need to do a fixed point by 18places            //
        for(uint j = ledgerIdx ; j < stakingLedger.length; j++){                            // loop through stacking intervals and accumulate rewards
            uint amount = lastTrade.tBalance.mul(1000000000000000000).div(stakingLedger[j].totStaked).mul(stakingLedger[j].totTokenReward).div(1000000000000000000);
            // revert if interval token balance deviates                                    //
            require(stakingLedger[j].totTokenReward.sub(stakingLedger[j].totTokenClaimed) >= amount, 'HIVEToken: Insufficient balance for the claimed tokens');
            dueTokenReward = dueTokenReward.add(amount);                                    // accumulate calc'd token rewards for this interval
            stakingLedger[j].totTokenClaimed = stakingLedger[j].totTokenClaimed.add(amount);// accumulate in interval claimed token accumulator
                                                                                            //
            amount = lastTrade.tBalance.mul(1000000000000000000).div(stakingLedger[j].totStaked).mul(stakingLedger[j].totETHReward).div(1000000000000000000);
            // revert if interval ETH balance deviates                                      //
            require(stakingLedger[j].totETHReward.sub(stakingLedger[j].totETHClaimed) >= amount, 'HIVEToken: Insufficient balance for the claimed ETH');
            dueETHReward = dueETHReward.add(amount);                                        // accumulate calc'd ETH rewards for this interval
            stakingLedger[j].totETHClaimed = stakingLedger[j].totETHClaimed.add(amount);    // accumulate in interval claimed token accumulator
        }                                                                                   //
        return (walletBalance, dueTokenReward, dueETHReward);                               // return balance and reward amounts
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* process a transfer                                                                   */
    /* Params       :-                                                                      */
    /*  sender      : Spending wallet address                                               */
    /*  recipient   : Receiving wallet address                                              */
    /*  amount      : amount of tokens spent                                                */
    //////////////////////////////////////////////////////////////////////////////////////////
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {//
        require(sender != address(0), 'ERC20: transfer from the zero address');             // disallow minting as a transfer
        require(recipient != address(0), 'ERC20: transfer to the zero address');            // disallow burning as a transfer
                                                                                            //
        // check if a stacking period has passed                                            //
        if((block.timestamp - lastSnapshotTimestamp) >= minStackingInterval){               // is it time to take a staking snapshot into ledger
            takeStakingSnapshot();                                                          // take the snapshot
        }                                                                                   //
        AddrType memory sendType = getAddrType(sender);                                     // get sender address type
        AddrType memory recType = getAddrType(recipient);                                   // get recipient address type
        UserTrade memory sendTransac;                                                       // send transaction log
        UserTrade memory recTransac;                                                        // receive transaction log
        uint256 Balance;                                                                    // will hold total sender balance
        {                                                                                   //
            uint256 amtToken; uint256 amtETH;                                               // temp local variables
            (Balance, amtToken, amtETH) = balanceRewards(recipient);                        // get balances to date of receipient
            recTransac = UserTrade(block.timestamp, 0, Balance, amtToken, amtETH, false);   // fill receive transaction with initital data
                                                                                            //
            (Balance, amtToken, amtETH) = balanceRewards(sender);                           // get balances to date of sender
            sendTransac = UserTrade(block.timestamp, amount, Balance.sub(amount, 'ERC20: transfer amount exceeds balance'), 0, 0, true);
        }                                                                                   //
        uint256 transferAmount = amount;                                                    // if no tax just send the amount
        if (tx.origin != recipient ) {                                                      // sell >> Orginator is sending to somebody else.
            sendTransac.sellFlag = true;                                                    // mark the transac as sell >> no staking for account
            sendTransac.rewardTokenBalance = 0;                                             // waive token reward for seller
            sendTransac.rewardETHBalance = 0;                                               // waive ETH reward for seller
            if(taxEnabled){                                                                 // apply taxing only if enabled
                uint256 flatFee = amount.mul(FLAT_FEE).div(100);                            // flat tax unit of 5%
                uint256 linearFee = 0;                                                      // init with zero linear tax
                uint256 reserveToken = 0;                                                   // init with zero token reserve
                if(PANCAKESWAP.uniswapV2Pair.token0() == address(this))                     // check pair token order
                    (reserveToken,,) = PANCAKESWAP.uniswapV2Pair.getReserves();             // token reserve returned first
                else                                                                        //
                    (,reserveToken,) = PANCAKESWAP.uniswapV2Pair.getReserves();             // token reserve returned second
                uint256 amtSalePCT = amount.mul(1000).div(reserveToken);                    // get the sale as a pct of pair reserves (x10 as a decimal digit)
                if(amtSalePCT >= ANTI_WHALE_MIN_FEE ){                                      // check if a massive (whale) sell
                    if(amtSalePCT > ANTI_WHALE_MAX_FEE)                                     // check if exceeds max flat fee
                        amtSalePCT = ANTI_WHALE_MAX_FEE;                                    // avoid too excessive taxing(max total of 15%)
                    linearFee = amount.mul(amtSalePCT).div(1000);                           // calculate linear fee
                }                                                                           //
                uint256 totFees = flatFee.add(linearFee);                                   // staking 5% flat fee + linear anti-whale fee >> goes to contract balance
                intervalTokenRewardAccum = intervalTokenRewardAccum.add(totFees);           // accumulate flat fee(5%) + Linear to be distributed as stacking reward
                totFees = totFees.add(flatFee);                                             // account for the liquidity flat 5%
                UserTrade memory taxTransac = UserTrade(block.timestamp, totFees, balanceOf(address(this)).add(totFees), 0, 0, false);
                userTrade[address(this)].push(taxTransac);                                  // credit the contract the fee tokens
                transferAmount = transferAmount.sub(totFees);                               // net transfer amount
                                                                                            //
                // accumulate 5% flat fee and SwapAndLiquify if over threshold              //
                swapAndLiquifyBalance = swapAndLiquifyBalance.add(flatFee);                 // accumulate the tax
                if ( swapAndLiquifyBalance >= minTokensToSwapAndLiquify && !inSwapAndLiquify && sender != pairAddr) {
                    swapAndLiquify(minTokensToSwapAndLiquify);                              // fixed size liquidity addition
                    swapAndLiquifyBalance = swapAndLiquifyBalance.sub(minTokensToSwapAndLiquify);
                }                                                                           //
                emit SellingFeeCollected(sender, recipient, amount, totFees, block.timestamp);
            }                                                                               //
        }                                                                                   //
        // update circulating & staking supply counters                                     //
        if(sendType.wallet && recType.wallet){                                              // wallet <=> wallet
            if(firstSellInSnapshot(sender))                                                 // prevent repeated deduction upon repeated sell in same snapshot
                totStakedTokens = totStakedTokens.sub(Balance);                             // all sender balance is deducted from staked supply
        }                                                                                   //
        else if((sendType._contract || sendType.burn) && recType.wallet){                   // contract => wallet OR burn => wallet
            circulatingSupply = circulatingSupply.add(transferAmount);                      // tokens(net) added to circulating supply
        }                                                                                   //
        else if(sendType.wallet && (recType._contract || recType.burn)){                    // wallet => contract OR wallet => burn
            circulatingSupply = circulatingSupply.sub(amount);                              // all transfer amount deducted from circulating supply
            if(firstSellInSnapshot(sender))                                                 // prevent repeated deduction upon repeated sell in same snapshot
                totStakedTokens = totStakedTokens.sub(Balance);                             // all sender balance is deducted from staked supply
        }                                                                                   //
                                                                                            //
        // log trade transactions                                                           //
        recTransac.tradeAmount = transferAmount;                                            // log net transfer amount
        recTransac.tBalance = recTransac.tBalance.add(transferAmount);                      // credit recipent net amount
        userTrade[sender].push(sendTransac);                                                // log the sell transaction
        userTrade[recipient].push(recTransac);                                              // log the buy transaction
                                                                                            //
        emit Transfer(sender, recipient, transferAmount);                                   // emit the transfer event
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* take a snapshot of the current stacking accumulators                                 */
    /* Params       : None                                                                  */
    //////////////////////////////////////////////////////////////////////////////////////////
    function takeStakingSnapshot() internal virtual {                                       //
        Snapshot memory snapshot = Snapshot(block.timestamp, totStakedTokens, intervalTokenRewardAccum, intervalETHRewardAccum, 0, 0);
        stakingLedger.push(snapshot);                                                       // push the snapshot
                                                                                            //
        intervalTokenRewardAccum = 0;                                                       // reset Token Reward Accumulator
        intervalETHRewardAccum = 0;                                                         // reset ETH Reward Accumulator
        totStakedTokens = circulatingSupply;                                                // re-init auto stacking total
        lastSnapshotTimestamp = block.timestamp;                                            // reset stacking interval timing
        emit StakingSnapshot(snapshot.totTokenReward, snapshot.totETHReward, snapshot.totStaked, block.timestamp);
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* checks if the address has made no sell operations within snapshot                    */
    /* Params       :-                                                                      */
    /*  sender      : Token Owner wallet address                                            */
    //////////////////////////////////////////////////////////////////////////////////////////
    function firstSellInSnapshot(address sender) internal view returns (bool resp )  {      //
        resp = true;                                                                        // initialize return value
        if(userTrade[sender].length == 0)                                                   // check if user made any trades
            return resp;                                                                    // true if no previous trades
                                                                                            //
        uint256 lastTimestamp = stakingLedger[stakingLedger.length - 1].timestamp ;         // get last snapshot timestamp
        for(uint256 j = userTrade[sender].length  ; j > 0 ; j--){                           // loop through user trades
            if(userTrade[sender][j-1].timestamp < lastTimestamp)                            // check the timestamp of the trade operation
                break;                                                                      // break the loop if trade lies before last snapshot
            if(userTrade[sender][j-1].sellFlag){                                            // check if the trade was a sell
                resp = false;                                                               // false return >> user sold before within this snapshot
                break;                                                                      // abort the loop
            }                                                                               //
        }                                                                                   //
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* process an approval                                                                  */
    /* Params       :-                                                                      */
    /*  owner       : Token Owner wallet address                                            */
    /*  spender     : Approved Spender wallet address                                       */
    /*  amount      : amount of tokens approved                                             */
    //////////////////////////////////////////////////////////////////////////////////////////
    function _approve(address owner, address spender, uint256 amount) internal virtual {    //
        require(owner != address(0), 'ERC20: approve from the zero address');               // revert if approving on behalf of the zero address
        require(spender != address(0), 'ERC20: approve to the zero address');               // revert if approving the zero address
                                                                                            //
        allowance[owner][spender] = amount;                                                 // update allowances mapping
        emit Approval(owner, spender, amount);                                              // emit the approve event
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* process tax tokens and add to liquidiy pair                                          */
    /* Params       :-                                                                      */
    /*  amountToken : amount of token to be split and added to liquidity                    */
    //////////////////////////////////////////////////////////////////////////////////////////
    function swapAndLiquify(uint256 amountToken) private lockTheSwap {                      //
        uint256 half = amountToken.div(2);                                                  // split the contract balance into halves
        uint256 otherHalf = amountToken.sub(half);                                          // get the exact remaining

        if(allowance[address(this)][address(PANCAKESWAP.uniswapV2Router)] < amountToken){   // save gas in repeated approvals >> since we trust the PS router
            _approve(address(this), address(PANCAKESWAP.uniswapV2Router), type(uint).max);  // approve router with max value(when needed)
        }                                                                                   //
                                                                                            //
        uint256 initialBalance = address(this).balance;                                     // capture the contract's current ETH balance.
        swapTokensForEth(half);                                                             // swap half the tokens for ETH
        uint256 amountETH = address(this).balance.sub(initialBalance);                      // how much ETH did we just swap for?
                                                                                            //
        // add liquidity to uniswap >> LP tokens generated goes to the contract             //
        PANCAKESWAP.uniswapV2Router.addLiquidityETH{value: amountETH}(address(this), otherHalf, 0, 0, address(this), block.timestamp );
        intervalETHRewardAccum = intervalETHRewardAccum.sub(amountETH);                     // deduct the amount from the Interval ETH balance Accumulator
                                                                                            //
        emit SwapAndLiquify(half, amountETH, otherHalf);                                    // emit the swap and liquify event
    }                                                                                       //
    //////////////////////////////////////////////////////////////////////////////////////////
    /* secure ETH required for liquidity addition                                           */
    /* Params       :-                                                                      */
    /*  amountToken : amount of token to be swapped for ETH                                 */
    //////////////////////////////////////////////////////////////////////////////////////////
    function swapTokensForEth(uint256 tokenAmount) private {
        address[] memory path = new address[](2);                                           // define the path parameter array
        path[0] = address(this);                                                            // first path element is the token
        path[1] = WETH;                                                                     // second path element is WETH
        // make the swap                                                                    //
        PANCAKESWAP.uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(tokenAmount, 0, path, address(this), block.timestamp);
    }                                                                                       //
}