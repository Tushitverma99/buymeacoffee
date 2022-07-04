//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;


// 0x4759E69b9fFe0438BEd2986875B482C3168278F7

contract Buymecoffee {
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    Memo[] memos;

    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message)
        public
        payable
    {
        require(msg.value > 0, "You must send a non-zero amount of ether");
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));
        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }
}
