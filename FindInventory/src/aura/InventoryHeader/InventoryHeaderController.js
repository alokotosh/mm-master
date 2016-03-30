({
    doInit : function(component, event, helper) {
        // Retrieve inventories during component initialization
        helper.getInventories(component);
    },
    createRecord : function (component, event, helper) {
    // Open the create record page
    var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({
        "entityApiName": "Computer_Inventory__c"
    });
    createRecordEvent.fire();
},
	select : function(component, event, helper){
    // Get the selected value of the ui:inputSelect component
        var action = component.get("c.getPrimary");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.inventories", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        // Return all inventories
        helper.getInventories(component);
    }

})