using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;
using System.Xml.Xsl;
using AutoMapper;
using XMLtoObj.Models;


namespace XMLtoObj.Service
{
    public static class XMLService
    {
        public static void TransfromXML(string xslPath, string xmlPath, string transformedPath)
        {
            XslTransform myXslTransform;
            myXslTransform = new XslTransform();
            myXslTransform.Load(xslPath);
            myXslTransform.Transform(xmlPath, transformedPath);
        }

        public static void SaveChangesInXML(string path, string newPath, TopRatedMovies topRatedMovies)
        {

            //read old Document
            TopRatedMovies loadStateFromFile = ReadXml(path); 
            //read to create new Document
            XDocument newDocument = XDocument.Load(path);

                var root = newDocument.Descendants("authors").FirstOrDefault();
                root?.Elements().Remove();
                foreach (var author in topRatedMovies.Authors)
                {
                    root?.Add(new XElement("author", author.Name));
                }

                root = newDocument.Descendants("locales").FirstOrDefault();
                root?.Elements().Remove();
                foreach (var local in topRatedMovies.Locales)
                {
                    root?.Add(new XElement("localeId", new XAttribute("id_lang", local.Id), local.Name));
                }



                root = newDocument.Descendants("genres").FirstOrDefault();
                root?.Elements().Remove();
                foreach (var genre in topRatedMovies.Genres)
                {
                    root?.Add(new XElement("genre", new XAttribute("id_g", genre.Id), genre.Name));
                }



                root = newDocument.Descendants("movies_list").FirstOrDefault();
                root?.Elements().Remove();
                foreach (var movie in topRatedMovies.Movies)
                {
                    root?.Add(new XElement("movie", new XAttribute("genre_id_ref", movie.Id),
                        new XElement("titles", movie.Titles.Select(_ => new XElement("title",
                            new XAttribute("locale_id_ref", _.LocaleId),
                            _.Original != null ? new XAttribute("original", _.Original) : null,
                            _.TitleValue))),
                        new XElement("rate", movie.Rate),
                        new XElement("director", movie.Director),
                        new XElement("duration", movie.Duration),
                        new XElement("release_date",
                            new XElement("day", movie.ReleaseDate.Day),
                            new XElement("month", movie.ReleaseDate.Month),
                            new XElement("year", movie.ReleaseDate.Year))
                    ));
                }

            newDocument.Save(newPath);
        }

        public static Tuple<bool,string> ValidateAgainstSchema(string xmlPath, string schemaPath)
        {
            bool result = true;
            string resultMessage = ""; 
            FileStream stream = new FileStream(xmlPath, FileMode.Open);
            XmlValidatingReader vr = new XmlValidatingReader(stream, XmlNodeType.Element, null);

            vr.Schemas.Add(null, schemaPath);
            vr.ValidationType = ValidationType.Schema;
            vr.ValidationEventHandler += (sender, args) =>
            {
                result = false;
                resultMessage += args.Message + '\n';
            };
            try
            {
                while (vr.Read())
                {
                }
            }
            catch (Exception e)
            {
                resultMessage += e.Message + '\n';
            }
            finally
            {
                vr.Close();
                stream.Close();
            }

            return new Tuple<bool, string>(result, resultMessage);
        }

        public static TopRatedMovies ReadXml(string path)
        {
            //initialize mapper
            var config = new MapperConfiguration(cfg => cfg.CreateMissingTypeMaps = true);
            var mapper = config.CreateMapper();

            //read document
            XDocument document = XDocument.Load(path);
            var authors = document.Descendants("author").Select(genre => new
            {
                Name = genre.Value,
            }).Select(mapper.Map<Author>).ToList();

            var genres = document.Descendants("genre").Select(genre => new
            {
                Id = genre.Attribute("id_g")?.Value,
                Name = genre.Value,
            }).Select(mapper.Map<Genre>).ToList();

            var locales = document.Descendants("localeId").Select(locale => new
            {
                Id = locale.Attribute("id_lang")?.Value,
                Name = locale.Value,
            }).Select(mapper.Map<Locale>).ToList();

            var movies = document.Descendants("movie").Select(movie => new
            {
                Id = movie.Attribute("genre_id_ref")?.Value,
                Titles = movie.Descendants("title").Select(_ => new
                {
                    LocaleId = _.Attribute("locale_id_ref")?.Value,
                    Original = _.Attribute("original")?.Value,
                    TitleValue = _.Value,
                }).Select(mapper.Map<Title>).ToList(),
                Rate = movie.Element("rate")?.Value,
                Director = movie.Element("director")?.Value,
                Duration = movie.Element("duration")?.Value,
                ReleaseDate = movie.Descendants("release_date").Select(_ => new
                {
                    Day = _.Element("day")?.Value,
                    Month = _.Element("month")?.Value,
                    Year = _.Element("year")?.Value,
                }).Select(mapper.Map<ReleaseDate>).FirstOrDefault(),
            }).Select(mapper.Map<Movie>).ToList();
           
            
            return new TopRatedMovies
            {
                Authors = new ObservableCollection<Author>(authors),
                Genres = new ObservableCollection<Genre>(genres),
                Locales = new ObservableCollection<Locale>(locales),
                Movies = new ObservableCollection<Movie>(movies)
            };
        }
    }
}
