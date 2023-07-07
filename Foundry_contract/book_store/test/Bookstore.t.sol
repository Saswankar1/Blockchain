// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/Bookstore.sol";

contract BookstoreTest is Test {
    Bookstore public bookstore;
    address public owner;
    uint public bookId;

    function setUp() public {
        bookstore = new Bookstore();
        owner = address(this);
        bookstore.addBook("Title 1", "Author 1", "Publication 1");
        bookId = 1;
    }

    // Test adding a book
    function testAddBook() public {
        string memory title = "Title 2";
        string memory author = "Author 2";
        string memory publication = "Publication 2";

        bookstore.addBook(title, author, publication);

        uint[] memory bookIds = bookstore.findBookByTitle(title);
        assertEq(bookIds[0], bookId + 1);
    }

    // Test removing a book
    function testRemoveBook() public {
        bookstore.removeBook(bookId);

        (, , , bool available) = bookstore.getDetailsById(bookId);
        assertFalse(available);
    }

    // Test updating book details
    function testUpdateDetails() public {
        string memory newTitle = "New Title";
        string memory newAuthor = "New Author";
        string memory newPublication = "New Publication";
        bool newAvailability = false;

        bookstore.updateDetails(bookId, newTitle, newAuthor, newPublication, newAvailability);

        (string memory title, string memory author, string memory publication, bool available) = bookstore.getDetailsById(bookId);
        assertEq(title, newTitle);
        assertEq(author, newAuthor);
        assertEq(publication, newPublication);
        assertEq(available, newAvailability);
    }

    // Test finding book by title
    function testFindBookByTitle() public {
        string memory title = "Title 1";

        uint[] memory bookIds = bookstore.findBookByTitle(title);

        assertEq(bookIds[0], bookId);
    }

    // Test finding books by publication
    function testFindAllBooksOfPublication() public {
        string memory publication = "Publication 1";

        uint[] memory bookIds = bookstore.findAllBooksOfPublication(publication);

        assertEq(bookIds[0], bookId);
    }

    // Test finding books by author
    function testFindAllBooksOfAuthor() public {
        string memory author = "Author 1";

        uint[] memory bookIds = bookstore.findAllBooksOfAuthor(author);

        assertEq(bookIds[0], bookId);
    }

    // Test getting book details by ID
    function testGetDetailsById() public {
        (string memory title, string memory author, string memory publication, bool available) = bookstore.getDetailsById(bookId);

        assertEq(title, "Title 1");
        assertEq(author, "Author 1");
        assertEq(publication, "Publication 1");
        assertTrue(available);
    }
}
