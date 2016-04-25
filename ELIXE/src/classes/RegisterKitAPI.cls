/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/20/2016
    @Purpose: This is the registerkit api
*/
@RestResource(urlMapping='/RegisterKit/*')
global with sharing class RegisterKitAPI {   
    
@HttpPost
global static RegisterKitResponse registerKit( HM_Kit hmKit) {
    try{
    
        Id accId , conId, buyerAccId;
        Contact contact;
        List<OrderItem> orderItemList;
        String userId = hmKit.account.contact.userId;
        if(userId == null || userId == ''){
            accId = HMAPI_SFDC_IntegrationUtil.createNewAccount(hmKit.account);
            conId = HMAPI_SFDC_IntegrationUtil.createNewContact(hmKit.account.contact, accId);
        }else{
            //getExistingContact(hmKit.account);
            //When userId is not null, get Contact
            contact = HMAPI_SFDC_IntegrationUtil.getExistingContact(userId);
            
            //checking if the Contact is under Non-Buyer Account
            if(contact != null ){
               contact.phone = hmKit.account.contact.phone; 
               contact.Naturally_Black_Hair__c = hmKit.account.contact.blackNaturally; 
               contact.Biological_Sex__c = hmKit.account.contact.biologicalSex;
               update contact;
            }else{
            // This scenario covers for new users. Create new account/contact and set user id on the contact
                orderItemList = [select Orderid, Order.Registered_By__c, Order.AccountId  from OrderItem where id = :hmKit.orderProductId];
                //accId = HMAPI_SFDC_IntegrationUtil.createNewAccount(hmKit.account);
                if(orderItemList.size() > 0){
                    OrderItem oline = orderItemList[0];
                    accId = oline.Order.AccountId;
                    conId = HMAPI_SFDC_IntegrationUtil.createNewContact(hmKit.account.contact, accId);
                }
                //RegisterKitResponse res = generateResponse('User Id does not exist','100',false);
               //return res;
            }
        }
        Id cId = conId != null ? conId : contact.Id;
        /*if(hmKit.orderNumber != null){
            try{
                Order o = new Order(Id = hmKit.orderNumber, Registered_By__c = cId);
                update o;
            }catch(DMLException dml1){
                RegisterKitResponse res = generateResponse('Invalid Order Number','105',false);
                return res;
            }
        }*/
        try{
            OrderItem oli = new OrderItem(Id = hmKit.orderProductId, registeredBy__c = cId, Kit_Order_Status__c = 'Registered');
            update oli;
        }catch(DMLException dml1){
            RegisterKitResponse res = generateResponse('Invalid Order Product','110',false);
            return res;
        }
        if(orderItemList == null){
            orderItemList = [select Orderid, Order.Registered_By__c  from OrderItem where id = :hmKit.orderProductId];
        }
        if(orderItemList.size() > 0){
            OrderItem line = orderItemList[0];
            try{
                    Order o = new Order(Id = line.orderId, Registered_By__c = cId);
                    update o;
                }catch(DMLException dml1){
                    RegisterKitResponse res = generateResponse('Invalid Order Number','105',false);
                    return res;
                }
            
        }
        RegisterKitResponse res = generateResponse(null, null, true);
        return res;
   
    }
      catch(DmlException e){
         //System.debug('The following exception has occurred: ' + e.getMessage());
         RegisterKitResponse response = generateResponse(e.getDMLMessage(0),'101',false);
         return response;
      }
      catch(Exception e){
         //System.debug('DmlException caught: ' + e.getMessage()); 
         RegisterKitResponse response = generateResponse(e.getMessage(),'102',false);
         return response;
      }
    return null;
}
    global static RegisterKitResponse generateResponse(String msg, String code, Boolean registered){
        RegisterKitResponse res = new RegisterKitResponse();
        res.isKitRegistered = registered;
        if(msg != null){
            HMAPIError error = new HMAPIError();
            error.message = msg;
            error.errorCode = code;
            res.error = error;
        }
        return res;
    }
    
}