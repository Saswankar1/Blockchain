// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*
In this contract:
    1. register student into scholaship
    2. register merchant into the program
    3. have categories like food, academic, sports
    4. spend in any categories but can only spend in the merchant registered with the program
    5. check the balance
   
*/

contract ScholarshipCreditContract {

    // setting the owner of the contract
    address private owner;
    uint public totalCredits;
    constructor() {
        owner = msg.sender;
        totalCredits = 1000000;
    }

    // mpdifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }
    modifier onlyMerchant() {
        bool isMerchant = false;
        for (uint256 i = 0; i < merchants.length; i++) {
            if (merchants[i].merchantAddress == msg.sender) {
                isMerchant = true;
                break;
            }}
        require(isMerchant, "Only registered merchants can call this function");
        _;
    }
    
    modifier onlyStudent(){
        bool isStudent = false;
        for (uint256 i = 0; i < students.length; i++) {
            if (students[i].studentAddress == msg.sender) {
                isStudent = true;
                break;
            }}
        require(isStudent, "Only registered students can call this function");
        _;
    }

    // students with scholarship
    struct Student {
        address studentAddress;
        mapping (string => uint) categ_credit;
    }
    // array of struct Student
    Student[] public students;

    // students with scholarship
    struct Merchant {
        address merchantAddress;
        string category;
        uint balance;
    }
    // array of struct Student
    Merchant[] public merchants;

    //This function assigns credits of particular category to student getting the scholarship
    function grantScholarship(address studentAddress, uint credits, string memory category) public onlyOwner {
        require(msg.sender == owner, "Not accesible");
        // storing the newstudent entry directly into the student array, as solidity does not accept push() with nested mapping
        Student storage newStudent = students[students.length];
        newStudent.studentAddress = studentAddress;
        newStudent.categ_credit[category]  = credits;
    }

    //This function is used to register a new merchant under given category
    function registerMerchantAddress(address merchantAddress, string memory category) public onlyOwner {
        require(msg.sender == owner, "Not accesible");
        merchants.push(Merchant(merchantAddress, category, 0));

    }

    //This function is used to deregister an existing merchant
    function deregisterMerchantAddress(address merchantAddress) public onlyOwner {
        for (uint256 i = 0; i < merchants.length; i++) {
            if (merchants[i].merchantAddress == merchantAddress) {
                delete merchants[i];
                break;
            }
        }
    }

    //This function is used to revoke the scholarship of a student
    function revokeScholarship(address studentAddress) public onlyOwner{
        for (uint256 i = 0; i < students.length; i++) {
            if (students[i].studentAddress == studentAddress) {
                delete students[i];
                break;
            }
        }
    }

    //Students can use this function to transfer credits only to registered merchants
    function spend(address merchantAddress, uint amount) public onlyStudent{
        for (uint256 i = 0; i < merchants.length; i++) {
            if (merchants[i].merchantAddress == merchantAddress) {
                merchants[i].balance += amount;
                students[getIndex(msg.sender)].categ_credit[merchants[i].category] -= amount;
                break;}}
    }

    // Internal function to get the index of a student in the students array
    function getIndex(address studentAddress) internal view returns (uint) {
        for (uint i = 0; i < students.length; i++) {
            if (students[i].studentAddress == studentAddress) {
                return i;
            }
        }
        revert("Student not registered");
    }

     // This function is used to see the available credits assigned to a student for a category
    function checkBalance(string memory category) public view onlyStudent returns (uint) {
        return students[getIndex(msg.sender)].categ_credit[category];
    }

    // This function is used by merchants to check their credits
    function checkMerchantBalance() public view onlyMerchant returns (uint) {
        for (uint256 i = 0; i < merchants.length; i++) {
            if (merchants[i].merchantAddress == msg.sender) {
                return merchants[i].balance;
            }
        }
        revert("Merchant not registered");
    }

}
