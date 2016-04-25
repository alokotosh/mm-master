/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/20/2016
    @Purpose: This is the api to check if the kit id being entered by user for registration is valid or not.
            1. does a matching order line item record exist?
            2. Is the Kit Order status = Shipped? If yes, valid kit id, if not, invalid kit id
*/
@RestResource(urlMapping='/IsValidKitId/*')
global with sharing class KitUtilAPI {
    
    @HttpPost
    global static kitIdResponse isValidKitId( String kitId) {
        try{
           kitIdResponse res = new kitIdResponse();
           
           //Querying Order Products for KitId
           List<OrderItem> orderProductList = [ Select Id, OrderId,Order.Helix_Order_Number__c, Kit_ID__c, Kit_Order_Status__c From OrderItem Where Kit_ID__c = :kitId ];
           
           OrderItem orderProduct ;
           
           if(orderProductList != null && orderProductList.size() > 0 ){
             orderProduct = orderProductList[0];
           }
           system.debug('orderProduct'+orderProduct);
           
           if(orderProduct == null){
              system.debug('Order Product not found');
              res = generateResponse('Kit Id not found','106',false, null,null);
              return res;
           }
             else if(orderProduct != null && (orderProduct.Kit_Order_Status__c != 'Shipped' || orderProduct.Kit_Order_Status__c == null)){
                system.debug('Kit already registered');
                res = generateResponse('Kit already registered','107',false, null,null);
                return res;
             }
               else if(orderProduct != null && orderProduct.Kit_Order_Status__c == 'Shipped'){
                  system.debug('Kit Id Valid');
                  res = generateResponse(null,null,true,orderProduct.OrderId,orderProduct.Id);
                  return res;
               }
           system.debug('res'+res);
           return res;
        }catch(Exception e){
           system.debug('Error = '+e.getMessage());
           kitIdResponse response = generateResponse(e.getMessage(),'102',false,null,null);
        }
        return null;
    }
    
     //Method to generate response
    global static kitIdResponse generateResponse(String msg, String code, Boolean isValid, String orderNumber, String opId){
        kitIdResponse res = new kitIdResponse();
        res.isvalid = isValid;
        res.orderProductId = opId;
        res.orderNumber= orderNumber;
        if(msg != null){
            HMAPIError error = new HMAPIError();
            error.message = msg;
            error.errorCode = code;
            res.error = error;
        }
        return res;
    }
    
}