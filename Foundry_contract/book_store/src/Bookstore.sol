// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
In this contract:
    1. add book
    2. remove book
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

    // this function can add a book and only accessible by the owner
    function addBook(
        string memory title,
        string memory author,
        string memory publication
    ) public onlyOwner {
        bookCount++;
        books[bookCount] = Book(title, author, publication, true);
    }

    // this function makes book unavailable and only accessible by the owner
    function removeBook(uint id) public onlyOwner {
        require(id <= bookCount, "Invalid Id");
        books[id].available = false;
    }

    // this function modifies the book details and only accessible by the owner
    function updateDetails(
        uint id,
        string memory title,
        string memory author,
        string memory publication,
        bool available
    ) public onlyOwner {
        require(id <= bookCount, "Invalid book ID");
        books[id].title = title;
        books[id].author = author;
        books[id].publication = publication;
        books[id].available = available;
    }

    // this function returns the IDs of all books with the given title
    function findBookByTitle(string memory title) public view returns (uint[] memory) {
        uint[] memory result = new uint[](bookCount);
        uint count = 0;
        for (uint i = 1; i <= bookCount; i++) {
            if (keccak256(bytes(books[i].title)) == keccak256(bytes(title))) {
                result[count] = i;
                count++;
            }
        }
        // resize the result array to the actual count of book IDs found
        return resize(result, count);
    }

    // this function returns the IDs of all books with the given publication
    function findAllBooksOfPublication(string memory publication) public view returns (uint[] memory) {
        uint[] memory result = new uint[](bookCount);
        uint count = 0;
        for (uint i = 1; i <= bookCount; i++) {
            if (keccak256(bytes(books[i].publication)) == keccak256(bytes(publication))) {
                result[count] = i;
                count++;
            }
        }
        // resize the result array to the actual count of book IDs found
        return resize(result, count);
    }

    // this function returns the IDs of all books with the given author
    function findAllBooksOfAuthor(string memory author) public view returns (uint[] memory) {
        uint[] memory result = new uint[](bookCount);
        uint count = 0;
        for (uint i = 1; i <= bookCount; i++) {
            if (keccak256(bytes(books[i].author)) == keccak256(bytes(author))) {
                result[count] = i;
                count++;
            }
        }
        // resize the result array to the actual count of book IDs found
        return resize(result, count);
    }

    // this function returns all the details of a book with the given ID
    function getDetailsById(uint id)
        public
        view
        returns (
            string memory title,
            string memory author,
            string memory publication,
            bool available
        )
    {
        require(id <= bookCount, "Invalid book ID");
        Book memory book = books[id];
        require(book.available || msg.sender == owner, "Book is not available");
        return (book.title, book.author, book.publication, book.available);
    }

    // helper function to resize the dynamic array
    function resize(uint[] memory array, uint newSize) internal pure returns (uint[] memory) {
        uint[] memory resizedArray = new uint[](newSize);
        for (uint i = 0; i < newSize; i++) {
            resizedArray[i] = array[i];
        }
        return resizedArray;
    }
}
