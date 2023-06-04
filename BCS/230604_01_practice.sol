
// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.18;

/*
안건을 올리고 이에 대한 찬성과 반대를 할 수 있는 기능을 구현하세요.
안건은 번호, 제목, 내용, 제안자(address) 그리고 찬성자 수와 반대자 수로 이루어져 있습니다.(구조체)
안건들을 모아놓은 자료구조도 구현하세요.

사용자는 자신의 이름과 주소, 자신이 만든 안건 그리고 자신이 투표한 안건과 어떻게 투표했는지(찬/반)에 대한 정보[string => bool]로 이루어져 있습니다.(구조체)

- 사용자 등록 기능 - 사용자를 등록하는 기능
- 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
- 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
- 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 - (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
- 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
*/

contract q6 {
    struct proposal{
        uint number;
        string subject;
        string detail;
        address by;
        uint accept;
        uint deny;
        proStatus status;
    }

    struct user {
        string userName;
        address userAddress;
        string[] userProposal;
        mapping(string => voteStatus) userVoteStatus;
    }

    enum voteStatus{
        notvoted,
        voted,
        xvoted
    }

    enum proStatus {
        ongoing,
        accepted,
        rejected
    }

    mapping(string => proposal) proposalM;

    mapping(address => user) users;

    mapping(address => bool) isUser;  // 등록된 유저인지 확인

    uint public userCount;
    uint public proposalCount;

    modifier requireIsUser(){
        require(isUser[msg.sender] == true,"sign in first.");
        _;
    }

    // - 사용자 등록 기능 - 사용자를 등록하는 기능
    function addUser(string calldata _name) public {
        require(isUser[msg.sender] == false,"This address has user account.");
        (users[msg.sender].userName, users[msg.sender].userAddress) = (_name, msg.sender);
        isUser[msg.sender] = true;
        userCount++; // 유저 수 측정
    }

    // - 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
    function goVote(string calldata _nameOfProposal, bool _vote) public requireIsUser{
        require(users[msg.sender].userVoteStatus[_nameOfProposal] == voteStatus.notvoted); // 투표를 이미 했다면, 투표가 불가능.
        if(_vote == true){
            proposalM[_nameOfProposal].accept++;
            users[msg.sender].userVoteStatus[_nameOfProposal] = voteStatus.voted;
        } else {
            proposalM[_nameOfProposal].deny++;
            users[msg.sender].userVoteStatus[_nameOfProposal] = voteStatus.voted;
        }
    }

    // - 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
    function setProposal(string memory _nameOfProposal, string calldata _detail) public requireIsUser{
        require(keccak256(abi.encodePacked(proposalM[_nameOfProposal].subject)) != keccak256(abi.encodePacked(_nameOfProposal)),"This proposal subject already exist"); // string 을 비교할 때는 kecakk256 , abi.encodedpacked 사용.
        proposalM[_nameOfProposal] = proposal(++proposalCount, _nameOfProposal, _detail, msg.sender,0,0, proStatus.ongoing);
    }

    // - 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 - (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
    function checkMyProposal(string calldata _nameOfProposal) public view returns (proposal memory){
        require(proposalM[_nameOfProposal].by == msg.sender,"You are not propose it.");
        return proposalM[_nameOfProposal];
    }

    // - 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
    function getAllProposal(string calldata _nameOfProposal) public view returns(proposal memory){
        return proposalM[_nameOfProposal]; // 안건의 제목만 입력한다면, 누구나 확인가능.
    }

    //- 투표 종료 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 전체의 70% 그리고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각
    function completeProposal(string calldata _nameOfProposal) public {
        require(proposalM[_nameOfProposal].by == msg.sender,"You are not propose it.");
        if(proposalM[_nameOfProposal].accept + proposalM[_nameOfProposal].deny >= userCount * 7/10 && proposalM[_nameOfProposal].accept >= (proposalM[_nameOfProposal].accept + proposalM[_nameOfProposal].deny) * 66/100 ){
            proposalM[_nameOfProposal].status = proStatus.accepted;
        } else{
            proposalM[_nameOfProposal].status = proStatus.rejected;
        }
    }
}

// 같은 이름의 안건으로 제안 x
// 로그인 해야 투표가능
// modifier 2,3