public class RowWrapper
    {
     // the values (cells) making up this row
     public List<String> values {get; set;}
      
     // constructor
     public RowWrapper()
     {
      values=new List<String>();
     }
      
     // append a value (cell) to the row
     public void addValue(String value)
     {
      values.add(value);
     }
    }