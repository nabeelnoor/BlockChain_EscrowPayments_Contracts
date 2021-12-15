// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;




contract EscrowPayments {
    struct Product{
    string title ;
    uint itemPrice ;
    address payable buyerAddress ;
    bytes1 availableStatus ; //A,P,D,R,C,E
    }

    address payable public owner;
    address public trustedTP;
    Product[] public productData;  //product Array -dynamic  //can this be map

    constructor () {
        owner=payable(msg.sender); //owner
    }

    function addItem(string memory _title,uint _price) public{
        require(msg.sender==owner);
        Product memory temp=Product(_title,_price,payable(0),'A');  
        productData.push(temp);
    }

    function listItems() public view returns(Product[] memory) {
        return  productData;
    }

    function addTTP(address _ttp) public{
        require(msg.sender==owner); //only called by owner
        trustedTP=_ttp; //add TTP
    }

    function buyItem(string memory _title) public payable{
        uint length=productData.length;
        Product memory temp;
        for(uint i=0;i<length;i++){
            temp=productData[i];
            if(keccak256(bytes(temp.title))==keccak256(bytes(_title))){
                require(temp.availableStatus=='A');
                require(msg.value>=temp.itemPrice);
                productData[i].buyerAddress=payable(msg.sender);
                productData[i].itemPrice=msg.value;
                productData[i].availableStatus='P';
            }
        }
    }

    function confirmPurchase(string memory _title,bool _flag) public{
        uint length=productData.length;
        Product memory temp;
        for(uint i=0;i<length;i++){
            temp=productData[i];
            if(keccak256(bytes(temp.title))==keccak256(bytes(_title))){
                require(temp.availableStatus=='P');
                require(temp.buyerAddress==msg.sender);
                if(_flag==true){
                    productData[i].availableStatus='C';
                }else{
                    productData[i].availableStatus='D';
                }
                return;
            }
        }
    }

    function handleDispute(string memory _title,bytes1 _status) public{
        uint length=productData.length;
        Product memory temp;
        for(uint i=0;i<length;i++){
            temp=productData[i];
            if(keccak256(bytes(temp.title))==keccak256(bytes(_title))){
                require(temp.availableStatus=='D');
                require(trustedTP==msg.sender);
                productData[i].availableStatus=_status;
                return;
            }
        }
    }

    function receivePayment(string memory _title) public{
        uint length=productData.length;
        Product memory temp;
        for(uint i=0;i<length;i++){
            temp=productData[i];
            if(keccak256(bytes(temp.title))==keccak256(bytes(_title))){
                if(temp.availableStatus=='C'){
                    require(owner==msg.sender);
                    productData[i].availableStatus='E';
                    owner.transfer(temp.itemPrice);
                }else if(temp.availableStatus=='R'){
                    require(temp.buyerAddress==msg.sender);
                    productData[i].availableStatus='E';
                    temp.buyerAddress.transfer(temp.itemPrice);
                }
                return;
            }
        }
    }




}