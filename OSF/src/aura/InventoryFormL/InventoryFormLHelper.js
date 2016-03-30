({
  getInventories: function(component) {
        var action = component.get("c.getInventories");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.inventories", response.getReturnValue());
                this.updateTotal(component);
            }
        });
        $A.enqueueAction(action);
  },
  updateTotal : function(component) {
      var inventories = component.get("v.inventories");
      var total = 0;
      for(var i=0; i<inventories.length; i++){
          var e = inventories[i];

          //If you’re using a namespace, use e.myNamespace__Amount__c instead
          total += e.Value__c;
      }
      //Update counters
      component.set("v.totalValue", total);
      component.set("v.inv", inventories.length);
  },//Delimiter for future code

    createInventory: function(component, inventory) {
    this.upsertInventory(component, inventory, function(a) {
        var inventory = component.get("v.inventories");
        expenses.push(a.getReturnValue());
        component.set("v.inventories", inventories);
        this.updateTotal(component);
      });
},
upsertInventory : function(component, inventory, callback) {
    var action = component.get("c.saveInventory");
    action.setParams({
        "inventory": inventory
    });
    if (callback) {
      action.setCallback(this, callback);
    }
    $A.enqueueAction(action);
}

})
