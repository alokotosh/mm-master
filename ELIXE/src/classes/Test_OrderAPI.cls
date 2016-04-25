@isTest (SeeAllData=true)
  private class Test_OrderAPI {

  static {
    // setup test data  
  }

static testMethod void OrderTestMethod() {

   //Creating HM_Agreement
   HM_Agreement agreement1 = new HM_Agreement();
   agreement1.key = '' ;
   agreement1.version = '' ;
   agreement1.agreed = true ;
   HM_Agreement agreement2 = new HM_Agreement();
   agreement2.key = '' ;
   agreement2.version = '' ;
   agreement2.agreed = true ;
   List<HM_Agreement> agreements = new List<HM_Agreement>();
   agreements.add(agreement1);
   agreements.add(agreement2);
   
   HM_Contact buyerHMCon = new HM_Contact();
   buyerHMCon.firstName = 'fName';
   buyerHMCon.lastName = 'lName';
   buyerHMCon.email = 'fName@lName.com';
   buyerHMCon.userId = '';
   buyerHMCon.phone = '9902944899';
   buyerHMCon.biologicalSex = 'Male';
   buyerHMCon.blackNaturally = 'Yes';
   buyerHMCon.agreements = agreements;
   
   HM_Account buyerHMAcc = new HM_Account();
   buyerHMAcc.contact = buyerHMCon;
   
   HM_Contact shiToHMCon = new HM_Contact();
   shiToHMCon.firstName = 'firstName';
   shiToHMCon.lastName = 'lastName';
   shiToHMCon.email = 'f1Name@l1Name.com';
   shiToHMCon.userId = '';
   shiToHMCon.phone = '9902944899';
   shiToHMCon.biologicalSex = 'Male';
   shiToHMCon.blackNaturally = 'Yes';
   shiToHMCon.agreements = agreements;
   
   HM_Account shipToHMAcc = new HM_Account();
   shipToHMAcc.contact = shiToHMCon;
   
   HM_Address shippingAddress = new HM_Address();
   shippingAddress.street1 = 'street 1';
   shippingAddress.street2 = 'street 2';
   shippingAddress.city = 'city';
   shippingAddress.state = 'state';
   shippingAddress.zip = '';
   shippingAddress.country = 'India';
   
   HM_Address billingAddress = new HM_Address();
   billingAddress.street1 = 'street 4';
   billingAddress.street2 = 'street 5';
   billingAddress.city = 'city';
   billingAddress.state = 'state';
   billingAddress.zip = '';
   billingAddress.country = 'US';
   
   HM_OrderLine orderLine1 = new HM_OrderLine();
   orderLine1.quantity = 2;
   orderLine1.sku = '';
   orderLine1.appId = '654321';
   
   HM_OrderLine orderLine2 = new HM_OrderLine();
   orderLine2.quantity = 3;
   orderLine2.sku = '';
   orderLine2.appId = '123456';
   
   List<HM_OrderLine> lineList = new List<HM_OrderLine>();
   lineList.add(orderLine1);
   lineList.add(orderLine2);
   
   HM_Order hmOrder = new HM_Order();
   hmorder.buyerAccount = buyerHMAcc;
   hmorder.shipToAccount = shipToHMAcc;
   hmorder.shippingAddress = shippingAddress;
   hmorder.billingAddress = billingAddress;
   hmorder.totalPrice = 100;
   hmorder.transactionId = '';
   hmorder.purchaseDateTime = null;     //'2016-03-20 22:34:00';
   hmorder.lines = lineList;
   
   CreateHMOrderResponse result = OrderAPI.createHMOrder(hmOrder);
   
   hmorder.buyerAccount.contact.userId = '123456';
   
   CreateHMOrderResponse result2 = OrderAPI.createHMOrder(hmOrder);
   
   /*RegisterUserRequest userReq = new RegisterUserRequest();
   userReq.userId = '456789';
   userreq.orderNumber = '';*/
   
   Account buyerAcc = new Account(Name = 'Buyer Acc', NON_BUYER_Account__c = False);
   insert buyerAcc;
   
   Account nonBuyerAcc = new Account(Name = 'Non-Buyer Acc', NON_BUYER_Account__c = true);
   insert nonBuyerAcc;
   
   Contact con1 = new Contact(LastName = 'Con1', AccountId = buyerAcc.Id, userid__c = '456789');
   insert con1;
   
   Contact con2 = new Contact(LastName = 'Con2', AccountId = nonBuyerAcc.Id, userid__c = '45678909');
   insert con2;
   
   hmorder.buyerAccount.contact.userId = '456789';  
   CreateHMOrderResponse result3 = OrderAPI.createHMOrder(hmOrder);
   
   hmorder.buyerAccount.contact.userId = '45678909';  
   CreateHMOrderResponse result4 = OrderAPI.createHMOrder(hmOrder);
   
   Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
   
    Pricebook2 priceBook = new  Pricebook2(Name = 'Test Price Book', IsActive = true);
    insert priceBook;
    
    Product2 product = new Product2(Name = 'Test Product', ProductCode = '123456');
    insert product;
    
    PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = standardPB.Id, Product2Id = product.Id, UnitPrice = 10, IsActive = true, UseStandardPrice = false);
    insert standardPrice;
    
    PricebookEntry priceBookEntry = new PricebookEntry(Pricebook2Id = priceBook.Id, Product2Id = product.Id, UnitPrice = 50);
    insert priceBookEntry;
    
    CreateHMOrderResponse result5 = OrderAPI.createHMOrder(hmOrder);
}

}