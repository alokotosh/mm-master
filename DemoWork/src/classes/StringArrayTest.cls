public with sharing class StringArrayTest {
	public StringArrayTest() {
		
	}
		public static List<String> generateStringArray(Integer numb)
		{
            //String[] colors = new String[numb];
            List<String>  colors = new List<String>(numb);


              for(Integer i =0;i<colors.size();i++)
              {
              //	System.debug('Test '+i);
              	colors[i]= 'Test '+i;
              }
              for(Integer i =0;i<colors.size();i++)
              {
              	System.debug(colors[i]);
              	
              }
              return colors;
		}
}