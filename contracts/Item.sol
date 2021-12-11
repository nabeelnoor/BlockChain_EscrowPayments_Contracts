// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;




contract Item {
    address owner;

    struct Product{
    string title ;
    uint itemPrice ;
    address payable buyerAddress ;
    bytes1 availableStatus ;
    }

    Product[] productData;  //product Array -dynamic

    constructor () {
        owner=msg.sender; //owner
    }

    function addItem(string memory _title,uint _price) public{
        Product memory temp=Product(_title,_price,payable(0),'A');  
        productData.push(temp);
    }

    function getItem() public view returns(Product[] memory) {
        return  productData;
    }


}