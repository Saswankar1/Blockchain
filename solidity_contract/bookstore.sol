// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*
In this contract:
    1. add book
    2. rermov book
    3. update details of the book
    4. finding book by title, author, publication, id
   
*/

contract Bookstore {

    struct Book {
        string title;
        string author;
        string publication;
        bool available;
    }

    mapping(uint => Book) public books;
    uint public bookCount;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can access this function");
        _;
    }


    // this function can add a book and only accessible by gavin
    function addBook(string memory title, string memory author, string memory publication) public onlyOwner{
        bookCount++;
        books[bookCount] = Book(title, author, publication, true);
    }

    // this function makes book unavailable and only accessible by gavin
    function removeBook(uint id) public onlyOwner{
        require(id <= bookCount, "Invalic Id");
        books[id].available = false;
    }

    // this function modifies the book details and only accessible by gavin
    function updateDetails(
        uint id, 
        string memory title, 
        string memory author, 
        string memory publication, 
        bool available) public onlyOwner{
            require(id <= bookCount, "Invalid book ID");
            books[id].title = title;
            books[id].author = author;
            books[id].publication = publication;
            books[id].available = available;
        }

    // this function returns the ID of all books with given title
    function findBookByTitle(string memory title) public view returns (uint [] memory )  {
        uint[] memory result;
        uint count = 0;
        for(uint i; i <= bookCount; i++){
           if (keccak256(bytes(books[i].title)) == keccak256(bytes(title))) {
                result[count] = i;
                count ++;
            }
        }
        // it will return the ids of the book with similar title
        return result;
    }

    // this function returns the ID of all books with given publication
    function findAllBooksOfPublication (string memory publication) public view returns (uint[] memory )  {
        uint[] memory result;
        uint count = 0;
        for (uint i = 1; i <= bookCount; i++) {
            if (keccak256(bytes(books[i].publication)) == keccak256(bytes(publication))) {
                result[count] = i;
                count++;
            }
        }
        return result;
    }

    // this function returns the ID of all books with given author
    function findAllBooksOfAuthor (string memory author) public view returns (uint[] memory )  {
        uint[] memory result;
        uint count = 0;
        for (uint i = 1; i <= bookCount; i++) {
            if (keccak256(bytes(books[i].author)) == keccak256(bytes(author))) {
                result[count] = i;
                count++;
            }
        }
        return result;
    }

    // this function returns all the details of book with given ID
    function getDetailsById(uint id) public view returns (
        string memory title, 
        string memory author, 
        string memory publication, 
        bool available)  {
            require(id <= bookCount, "Invalid book ID");
            Book memory book = books[id];
            require(book.available || msg.sender == owner, "Book is not available");
            return (book.title, book.author, book.publication, book.available);
        }

}
 
