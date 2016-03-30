trigger CallOutTrigger on Account (before insert, before update) {
    CallOut.makeCallout();
}