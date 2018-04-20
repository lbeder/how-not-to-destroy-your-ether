pragma solidity 0.4.21;

import "./SafeMath.sol";
import "./Ownable.sol";
import "./Token.sol";


contract Crowdsale is Ownable {
    using SafeMath for uint256;

    Token public token;

    address public fundingRecipient;
    uint256 public cap;
    uint256 public exchangeRate;
    uint256 public totalWeiRaised;

    event TokensIssued(address indexed to, uint256 tokens);
    event Finalized();

    modifier onlyDuringSale() {
        require(!saleEnded());

        _;
    }

    modifier onlyAfterSale() {
        require(saleEnded());

        _;
    }

    function Crowdsale(address _fundingRecipient, uint256 _cap, uint256 _exchangeRate) public {
        require(_fundingRecipient != address(0));
        require(_cap > 0);
        require(_exchangeRate > 0);

        fundingRecipient = _fundingRecipient;
        cap = _cap;
        exchangeRate = _exchangeRate;

        token = new Token();
    }

    function() external payable onlyDuringSale {
        address recipient = msg.sender;

        uint256 weiReceived = msg.value;
        require(weiReceived > 0);

        // Calculate how much wei can the user participate with.
        uint256 weiLeftInSale = cap.sub(totalWeiRaised);
        uint256 weiToParticipate = SafeMath.min256(weiReceived, weiLeftInSale);
        require(weiToParticipate > 0);

        // Issue tokens and transfer to recipient.
        totalWeiRaised = totalWeiRaised.add(weiToParticipate);
        uint256 tokensToIssue = weiToParticipate.mul(exchangeRate);

        // Issue the tokens to the token sale smart contract itself, which will hold them for future refunds.
        issueTokens(recipient, tokensToIssue);

        // Partial refund if full participation not possible, e.g. due to cap being reached.
        uint256 refund = weiReceived.sub(weiToParticipate);
        if (refund > 0) {
            recipient.transfer(refund);
        }
    }

    function finalize() external onlyOwner onlyAfterSale {
        // Finish minting and therefore enable transfers.
        token.finishMinting();

        uint256 balance = address(this).balance;
        assert(balance == totalWeiRaised);
        fundingRecipient.transfer(address(this).balance);

        emit Finalized();
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function issueTokens(address _recipient, uint256 _tokens) private {
        assert(token.mint(_recipient, _tokens));

        emit TokensIssued(_recipient, _tokens);
    }

    function saleEnded() private view returns (bool) {
        return totalWeiRaised >= cap;
    }
}
