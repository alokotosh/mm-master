/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/28/2016
    @Purpose: This is request object structure for SendPasswordResetEamil api
*/
global class ResetPasswordEmailRequest{
        public String email;
        public String userId;
        public String resetLink;
    }