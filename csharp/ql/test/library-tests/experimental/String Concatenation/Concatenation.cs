using System;
using System.Globalization;
using System.Text;

namespace Test
{
  public class MyClass
  {
    private const string _field1 = "field_init";
    private readonly string _field2; // assigned in constructor
    private const string _field3 = _field1 + "3"; // field_init3
    private readonly String[] _field4;
    private string _field5; // assigned in constructor, overridden in method

    public MyClass()
    {
        _field2 = "field_assigned_from_constructor";
        _field4 = new String[]{"a", "/", "b"};
        _field5 = "field_assigned_from_constructor";
    }
    
    public void MyMethod(string param1, string param2 = "param_default") {
      string var1 = "var_init";
      string var2;
      var2 = "var_assigned";
      string var3 = var1 + "3"; // var_init3
      var var4 = new String[]{"a", "/", "b"};      
      var var5 = new ClassWithProperty();
      var5.Property2 = "property_assigned_from_method";
      
      // Concatentation via InterpolatedString
      string testIps = $"a/b"; // a/b
      testIps = $"{_field1}/{_field2}"; // field_init/field_assigned_from_constructor
      testIps = $"{_field1}/{_field3}"; // field_init/field_init3 TODO
      testIps = $"{_field1}/{_field5}"; // field_init/field_assigned_from_constructor
      testIps = $"{param1}/{param2}"; // <unknown>/param_default
      testIps = $"{var1}/{var2}"; // var_init/var_assigned
      testIps = $"{var1}/{var3}"; // var_init/var_init3 TODO
      testIps = $"{var5.Property1}/{var5.Property2}"; // property_init/property_assigned_from_method
      testIps = $"{var5.Property1}/{var5.Property3}"; // property_init/property_init3 TODO
      testIps = $"{var5.Property1}/{var5.Property5}"; // property_init/property_assigned_from_constructor
      // testIps = $"{field}/{var5.Property5}"; // property_init5/property_init5 TODO preview feature for C# 13
      
      // Concatentation via AddExpr
      string testAdd = "a" + "/" + "b"; // a/b
      testAdd = _field1 + "/" + _field2; // field_init/field_assigned_from_constructor
      testAdd = _field1 + "/" + _field3; // field_init/field_init3 TODO
      testAdd = _field1 + "/" + _field5; // field_init/field_assigned_from_constructor
      testAdd = param1 + "/" + param2; // <unknown>/param_default
      testAdd = var1 + "/" + var2; // var_init/var_assigned
      testAdd = var1 + "/" + var3; // var_init/var_init3 TODO
      testAdd = var5.Property1 + "/" + var5.Property2; // property_init/property_assigned_from_method
      testAdd = var5.Property1 + "/" + var5.Property3; // property_init/property_init3 TODO
      testAdd = var5.Property1 + "/" + var5.Property5; // property_init/property_assigned_from_constructor

      
      // Concatenation via InterpolatedString and AddExpr
      string testIpsAndAdd = $"{_field1}/{_field2}" + "/" + _field3; // field_init/field_assigned_from_constructor/field_init3 TODO
      
      // Concatentation via StringFormat
      string testFormat = string.Format("{0}/{1}", "a", "b"); // a/b
      testFormat = string.Format("{0}/{1}", _field1, _field2); // field_init/field_assigned_from_constructor
      testFormat = string.Format("{0}/{1}", _field1, _field3); // field_init/field_init3 TODO
      testFormat = string.Format("{0}/{1}", _field1, _field5); // field_init/field_assigned_from_constructor
      testFormat = string.Format("{0}/{1}", param1, param2); // <unknown>/param_default
      testFormat = string.Format("{0}/{1}", var1, var2); // var_init/var_assigned
      testFormat = string.Format("{0}/{1}", var1, var3); // var_init/var_init3 TODO
      testFormat = string.Format("{0}/{1}", var5.Property1, var5.Property2); // property_init/property_assigned_from_method
      testFormat = string.Format("{0}/{1}", var5.Property1, var5.Property3); // property_init/property_init3 TODO
      testFormat = string.Format("{0}/{1}", var5.Property1, var5.Property5); // property_init/property_assigned_from_constructor
      testFormat = string.Format(CultureInfo.CurrentCulture, "{0}/{1}", "a", "b"); // a/b
      
      // Complex concatentation via StringFormat
      string format1 = "{0}";
      string format2 = "/{1}";
      string formatAdd = format1 + format2; // {0}/{1}
      string formatIps = $"{format1}{format2}"; // {0}/{1}
      testFormat = string.Format(format1 + format2, var1, var2); // var_init/var_assigned
      testFormat = string.Format($"{format1}{format2}", var1, var2); // var_init/var_assigned
      testFormat = string.Format(formatAdd, var1, var2); // var_init/var_assigned TODO
      testFormat = string.Format(formatIps, var1, var2); // var_init/var_assigned TODO
      
      // Concatentation via StringBuilder - with constructor value
      StringBuilder stringBuilder1 = new StringBuilder("a"); // a/b
      stringBuilder1.Append("/");
      stringBuilder1.Append("b");
      
      // Concatentation via StringBuilder - without constructor value
      StringBuilder stringBuilder2 = new StringBuilder(); // field_init/field_assigned_from_constructor
      stringBuilder2.Append(_field1);
      stringBuilder2.Append("/");
      stringBuilder2.Append(_field2);
      
      // Concatentation via StringBuilder - append chain
      StringBuilder stringBuilder3 = new StringBuilder(); // field_init/field_assigned_from_constructor
      stringBuilder3.Append(_field1).Append("/").Append(_field2);
      
      // Concatentation via StringBuilder - appendLine
      StringBuilder stringBuilder4 = new StringBuilder(); // field_init/field_assigned_from_constructor/n
      stringBuilder4.Append(_field1).Append("/").AppendLine(_field2);
      
      // Concatentation via StringBuilder - appendFormat
      StringBuilder stringBuilder5 = new StringBuilder(); // field_init/field_assigned_from_constructor
      stringBuilder5.AppendFormat("{0}/{1}", _field1, _field2);
      
      // Concatentation via StringBuilder - appendJoin
       StringBuilder stringBuilder6 = new StringBuilder(); // field_init/field_assigned_from_constructor
      stringBuilder6.AppendJoin("/", new String[]{_field1, _field2});
      
      // override initial values, check the new values are used and no cartesian product
      var2 = "override_var_assigned";
      _field5 = "override_field_assigned_from_method";
      var5.Property2 = "override_property_assigned_from_method";
      var5.Property5 = "override_property_assigned_from_constructor";
      
      // Concatentation via String.Concat
      string testConcat = string.Concat("a","/", "b"); // a/b
      testConcat = string.Concat(_field1,"/", _field2); // field_init/field_assigned_from_constructor
      testConcat = string.Concat(_field1,"/", _field3); // field_init/field_init3 TODO
      testConcat = string.Concat(_field1,"/", _field5); // field_init/override_field_assigned_from_method
      testConcat = string.Concat(param1,"/", param2); // <unknown>/param_default
      testConcat = string.Concat(var1,"/", var2); // var_init/override_var_assigned
      testConcat = string.Concat(var1,"/", var3); // var_init/var_init3 TODO
      testConcat = string.Concat(var5.Property1,"/", var5.Property2); // property_init/override_property_assigned_from_method
      testConcat = string.Concat(var5.Property1,"/", var5.Property3); // property_init/property_init3 TODO
      testConcat = string.Concat(var5.Property1,"/", var5.Property5); // property_init/override_property_assigned_from_constructor
      testConcat = string.Concat(new String[]{"a", "/", "b"}); // a/b
      testConcat = string.Concat(_field4); // a/b
      testConcat = string.Concat(var4); // a/b
      
      // Concatentation via String.Join
      string stringJoin = string.Join("", new String[]{"a", "/", "b"}); // a/b
      stringJoin = string.Join("/", new String[]{_field1, _field2}); // field_init/field_assigned_from_constructor
      stringJoin = string.Join("/", new String[]{_field1, _field3}); // field_init/field_init3 TODO
      stringJoin = string.Join("/", new String[]{_field1, _field5}); // field_init/override_field_assigned_from_method
      stringJoin = string.Join("/", new String[]{param1, param2}); // <unknown>/param_default
      stringJoin = string.Join("/", new String[]{var1, var2}); // var_init/override_var_assigned
      stringJoin = string.Join("/", new String[]{var1, var3}); // var_init/var_init3 TODO
      stringJoin = string.Join("/", new String[]{var5.Property1, var5.Property2}); // property_init/override_property_assigned_from_method
      stringJoin = string.Join("/", new String[]{var5.Property1, var5.Property3}); // property_init/property_init3 TODO
      stringJoin = string.Join("/", new String[]{var5.Property1, var5.Property5}); // property_init/override_property_assigned_from_constructor
      stringJoin = string.Join("", _field4); // a/b
      stringJoin = string.Join("", var4); // a/b
      
      // Verify no cartesian product with PropertyAccess
      var unused = new ClassWithProperty();
      unused.Property2 = "unused_property_assigned";

      // Test limitations on string length (currently 120 char per element)
      string testLength = string.Concat("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum", "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum");

      // Test limitations on number of elements (currently 15)
      string testNumElements = $"{_field1}/{_field2}/{_field3}/{param1}/{param2}/{var1}/{var2}/{var3}/{var5.Property1}"; // includes IPS children, not just inserts
      testNumElements = "a" + "b" + "c" + "d" + "e" + "f" + "g" + "h" + "i" + "j" + "k" + "l" +"m" + "n" + "o" + "p" + "q";
      testNumElements = string.Format("{0}/{1}/{2}/{3}/{4}/{5}/{6}/{7}/{8}/{9}/{10}/{11}/{12}/{13}/{14}/{15}/{16}", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q"); // based on number of inserts
      testNumElements = string.Concat("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l" +"m", "n", "o", "p", "q");
      testNumElements = string.Join("", new String[]{"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l" +"m", "n", "o", "p", "q"});
    
      StringBuilder stringBuilder7 = new StringBuilder();
      stringBuilder7.Append("a").Append("b").Append("c").Append("d").Append("e").Append("f").Append("g").Append("h").Append("i").Append("j").Append("k").Append("l").Append("m").Append("n").AppendFormat("{0}", "o").AppendJoin("", new String[]{"p"}).AppendLine("q");
    
      StringBuilder stringBuilder8 = new StringBuilder();
      stringBuilder8.Append("a");
      stringBuilder8.Append("b");
      stringBuilder8.Append("c");
      stringBuilder8.Append("d");
      stringBuilder8.Append("e");
      stringBuilder8.Append("f");
      stringBuilder8.Append("g");
      stringBuilder8.Append("h");
      stringBuilder8.Append("i");
      stringBuilder8.Append("j");
      stringBuilder8.Append("k");
      stringBuilder8.Append("l");
      stringBuilder8.Append("m");
      stringBuilder8.Append("n");
      stringBuilder8.AppendFormat("{0}", "o");
      stringBuilder8.AppendJoin("", new String[]{"p"});
      stringBuilder8.AppendLine("q");
      
      // verify assignment after access is not used
      var2 = "var_assigned_unused";
      _field5 = "field_assigned_from_method_unused";
      var5.Property2 = "property_assigned_from_method_unused";
    }
  }
  
  public class ClassWithProperty
  {
    public string Property1 { get; set; } = "property_init";
    public string Property2 { get; set; } // assigned in method
    public string Property3 => $"{Property1}3"; // property_init3
    // TODO: currently preview feature for C# 13
    // public string? Property4
    // {
    //   get;
    //   set => field = "property_init4";
    // }
    public string Property5 { get; set; } // assigned in constructor

    public ClassWithProperty() {
      Property5 = "property_assigned_from_constructor";
    }
  }
}