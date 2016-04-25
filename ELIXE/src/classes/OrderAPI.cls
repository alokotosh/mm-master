/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/20/2016
    @Purpose: This is the CreateHMOrder api that creates the account/contact/order and order lines 
*/
@RestResource(urlMapping='/CreateHMOrder/*')
global with sharing class OrderAPI {

   
    
@HttpPost
global static CreateHMOrderResponse createHMOrder( HM_Order hmOrder) {
    try{
    
    Id accId , conId, buyerAccId;
    Contact contact;

    String userId = hmOrder.buyerAccount.contact.userId;
    if(userId == null || userId == ''){
        accId = HMAPI_SFDC_IntegrationUtil.createNewAccount(hmOrder.buyerAccount);
        conId = HMAPI_SFDC_IntegrationUtil.createNewContact(hmOrder.buyerAccount.contact, accId);
    }else{
        //getExistingContact(hmOrder.buyerAccount);
        //When userId is not null, get Contact
        contact = HMAPI_SFDC_IntegrationUtil.getExistingContact(userId);
        
        //checking if the Contact is under Non-Buyer Account
        if(contact != null && contact.Account.NON_BUYER_Account__c == true){
           accId = HMAPI_SFDC_IntegrationUtil.createNewAccount(hmOrder.buyerAccount);
           contact.AccountId = accId;
           update contact;
        }else if(contact != null && !contact.Account.NON_BUYER_Account__c ){
            accId = contact.AccountId;
        }else{
            CreateHMOrderResponse res = generateResponse('User Id does not exist','100',null);
            return res;
        }
    }
    List<OrderItem> lineList = new List<OrderItem>();
    //get pricebook entries for the products
    Set<String> prodList = new Set<String>();
    for(HM_OrderLine line : hmOrder.lines){
        prodList.add(line.appid);
    }
    Map<String, Id> productIdToPricebkId = new Map<String, Id>();
    Id pbId = [select id from Pricebook2 where isActive = true Limit 1].Id;
    for(PricebookEntry  p :[SELECT Product2Id,Product2.name, Id,ProductCode FROM PricebookEntry 
                            WHERE ProductCode in :prodList AND  PriceBook2Id = :pbId]){
        productIdToPricebkId.put(p.Productcode, p.Id);     
    
    }
    Id cId = conId != null?conId:contact.Id;
    Order o = new Order(accountid = accid, transactionid__c = hmOrder.transactionId, Status = 'Draft',EffectiveDate = system.today(), PriceBook2Id = pbId);
    if(hmOrder.shippingAddress != null){                     
        o.shippingcountry = hmOrder.shippingAddress.country;
        o.shippingCity = hmOrder.shippingAddress.city; 
        o.shippingState = hmOrder.shippingAddress.state;
        o.shippingstreet = hmOrder.shippingAddress.street1+' '+hmOrder.shippingAddress.street2; 
        o.shippingpostalcode = hmOrder.shippingAddress.zip;
    }
    if(hmOrder.billingAddress != null){ 
        o.billingcountry = hmOrder.billingAddress.country; 
        o.billingCity = hmOrder.billingAddress.city; 
        o.billingState = hmOrder.billingAddress.state;
        o.billingstreet = hmOrder.billingAddress.street1 + ' ' + hmOrder.billingAddress.street2; 
        o.billingpostalcode = hmOrder.billingAddress.zip;
    }
    if(hmOrder.isBillToSameAsBuyer != null && hmOrder.isBillToSameAsBuyer){
        o.BillToContactId = cId;    
    }else{
        if(hmOrder.billToAccount != null) {
            Id billToAccId = HMAPI_SFDC_IntegrationUtil.createNewAccount(hmOrder.billToAccount);
            Id billToConId = HMAPI_SFDC_IntegrationUtil.createNewContact(hmOrder.billToAccount.contact, billToAccId);
            o.BillToContactId = billToConId;
        }
    } 
    if(hmOrder.isShipToSameAsBillTo != null && hmOrder.isShipToSameAsBillTo){
        o.ShipToContactId = o.BillToContactId;
    }else{
        if(hmOrder.shipToAccount != null){
            Id shipToAccId = HMAPI_SFDC_IntegrationUtil.createNewAccount(hmOrder.shipToAccount);
            Id shipToConId = HMAPI_SFDC_IntegrationUtil.createNewContact(hmOrder.shipToAccount.contact, shipToAccId);
            o.ShipToContactId = shipToConId;
        }
    }
    insert o;
       
    Order ord = [select Helix_Order_Number__c from Order where id = :o.Id limit 1];
    for(HM_OrderLine line : hmOrder.lines){
        OrderItem lineItem = new OrderItem();
        lineItem.OrderId = o.id;
        lineItem.quantity = line.quantity;
        lineItem.UnitPrice = 1;
        if(productIdToPricebkId.containsKey(line.appid)){
            lineItem.pricebookentryId = productIdToPricebkId.get(line.appid);
        }
        lineList.add(lineItem);
    }
    insert lineList ;
    //update invitation code as used once the order has been created successfully
    List<Lead> leadList = [ Select Id, Invitation_Code__c, Invitation_Code_Used__c From Lead Where email = :hmOrder.buyerAccount.contact.email];
    if(leadList.size() > 0){
        Lead l = leadList[0];
        l.Invitation_Code_Used__c = true;
        update l;
    }
    CreateHMOrderResponse res = generateResponse(null,null,ord.Helix_Order_Number__c);
    return res;
    }
      catch(DmlException e){
         //System.debug('The following exception has occurred: ' + e.getMessage());
         CreateHMOrderResponse response = generateResponse(e.getMessage(),'101',null);
         return response;
      }
      catch(Exception e){
         //System.debug('DmlException caught: ' + e.getMessage()); 
         System.debug('Error = '+e.getStackTraceString());
         CreateHMOrderResponse response = generateResponse(e.getMessage(),'102',null);
         return response;
      }
    return null;
}
    global static CreateHMOrderResponse generateResponse(String msg, String code, String oId){
        CreateHMOrderResponse res = new CreateHMOrderResponse();
        if(oId != null){
            res.orderNumber = oId;
            
        }
        if(msg != null){
            HMAPIError error = new HMAPIError();
            error.message = msg;
            error.errorCode = code;
            res.error = error;
        }
        return res;
    }
   
}