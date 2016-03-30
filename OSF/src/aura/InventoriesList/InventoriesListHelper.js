({
   //Fetch the accounts from the Apex controller
  getInventoryList: function(component) {
    var action = component.get("c.getInventories");

    //Set up the callback
    var self = this;
    action.setCallback(this, function(actionResult) {
        component.set("v.inventories", actionResult.getReturnValue());
    });
    $A.enqueueAction(action);
  }
})
