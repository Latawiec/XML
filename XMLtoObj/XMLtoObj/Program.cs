using System;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Xml.Linq;
using XMLtoObj.Service;

namespace XMLtoObj
{
    class Program
    {
        static void Main(string[] args)
        {
     

            var moviesList = XMLService.ReadXml("../movies_list.xml");
            //StringBuilder result = new StringBuilder();
            //foreach (XElement level1Element in XElement.Load("../movies_list.xml").Elements("level1"))
            //{
            //    result.AppendLine(level1Element.Attribute("name").Value);

            //    foreach (XElement level2Element in level1Element.Elements("level2"))
            //    {
            //        result.AppendLine("  " + level2Element.Attribute("name").Value);
            //    }
            //}

        }

        
    }
}
