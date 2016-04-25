/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/20/2016
    @Purpose: This is the contact object for HM Integration API
*/
global class HM_Contact{
        public String firstName;
        public String lastName;
        public String email;
        public String userId;
        public String phone;
        public String biologicalSex;
        public String blackNaturally;
        public List<HM_Agreement> agreements;
    }