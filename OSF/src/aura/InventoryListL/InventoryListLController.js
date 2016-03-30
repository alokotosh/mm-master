({
deleteEvent : function(component, event, helper) {
    // Call the helper function to delete record and update view
    helper.deleteInventory(component, event.getParam("inventory"));
},

    update: function(component, evt, helper) {
      var inventory = component.get("v.inventory");
      // Note that updateExpense matches the name attribute in <aura:registerEvent>
      var updateInventory = component.getEvent("updateInventory");
      updateInventory.setParams({ "inventory": inventory }).fire();
    }
})
