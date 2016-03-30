({
    doInit : function(component, event, helper) {
       //Update expense counters
       helper.getInventories(component);
    },//Delimiter for future code
    createInventory : function(component, event, helper) {
    var amtField = component.find("amount");
    var amt = amtField.get("v.value");
    if (isNaN(amt)||amt==''){
        amtField.set("v.errors", [{message:"Enter an expense amount."}]);
    }
    else {
        amtField.set("v.errors", null);
        var newInventory = component.get("v.newInventory");
        helper.createInventory(component, newInventory);
    }
},//Delimiter for future code

    updateEvent : function(component, event, helper) {
    helper.upsertInventory(component, event.getParam("inventory"));
}

})
