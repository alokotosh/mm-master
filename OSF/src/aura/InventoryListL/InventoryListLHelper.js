({
deleteInventory : function(component, expense, callback) {
    // Call the Apex controller and update the view in the callback
    var action = component.get("c.deleteInventory");
    action.setParams({
        "inventory": inventory
    });
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
            // Remove only the deleted expense from view
            var inventories = component.get("v.inventory");
            var items = [];
            for (i = 0; i < inventories.length; i++) {
                if(inventories[i]!==inventories) {
                    items.push(inventories[i]);
                }
            }
            component.set("v.inventories", items);
            // Other client-side logic
        }
    });
    $A.enqueueAction(action);
}
})
