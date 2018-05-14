using System;
using System.IO;
using System.Xml;
using System.Xml.Schema;

namespace ConsoleApp1
{
    public class Program
    {
        public static void Main()
        {
            FileStream stream = new FileStream("../movies_list.xml", FileMode.Open);
            XmlValidatingReader vr = new XmlValidatingReader(stream, XmlNodeType.Element, null);

            vr.Schemas.Add(null, "../moviesList.xsd");
           // vr.Schemas.Add(null, "Tape.xsd");
            vr.ValidationType = ValidationType.Schema;
            vr.ValidationEventHandler += new ValidationEventHandler(ValidationHandler);

            try
            {
                while (vr.Read()) ;
            }
            catch (Exception e)
            {

            }
            Console.WriteLine("Validation finished");
        }

        public static void ValidationHandler(object sender, ValidationEventArgs args)
        {
            Console.WriteLine("***Validation error");
            Console.WriteLine("\tSeverity:{0}", args.Severity);
            Console.WriteLine("\tMessage:{0}", args.Message);
        }
    }
}
